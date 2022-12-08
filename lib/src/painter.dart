import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;

import 'entities.dart';
import 'loader.dart';

const _bit30flippedAntiDiagonally = 0x20000000;
const _bit31flippedVertically = 0x40000000;
const _bit32flippedHorizontally = 0x80000000;
const _defaultTextColor = '#000000';
const _defaultPixelSize = 16.0;
const _low29bits = 0x1FFFFFFF;
const _targetLayerPropertyName = 'TilerTargetLayer';

Color colorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '').trim();
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }
  return Color(int.parse(hexColor, radix: 16));
}

/// A [CustomPainter] for rendering [LoadedTileMap]s.
class TileMapPainter extends CustomPainter {
  final LoadedTileMap _loadedMap;
  final Map<int, Tileset> _tileSetForFirstGid = {};
  final Map<Tileset, Map<int, Tile>> _tilesById = {};
  final Map<String, List<MapObject>> _objectsByTargetLayer = {};
  final Offset _offset;
  final double _scale;
  final int _elapsedMs;
  final bool _debugMode;

  /// TODO: Tidy up debug handling.
  final Paint _paint = Paint()..filterQuality = FilterQuality.low;
  final Paint? _backgroundPaint;
  final Paint _objectPaint = Paint()
    ..filterQuality = FilterQuality.low
    ..strokeWidth = 2
    ..color = Colors.red
    ..style = PaintingStyle.stroke;

  TileMapPainter(
    this._loadedMap,
    this._offset, {
    int elapsedMs = 0,
    double scale = 1,
    bool debugMode = false,
  })  : _elapsedMs = elapsedMs,
        _scale = scale,
        _debugMode = debugMode,
        _backgroundPaint = _loadedMap.map.backgroundColor != null
            ? (Paint()
              ..filterQuality = FilterQuality.low
              ..color = colorFromHex(_loadedMap.map.backgroundColor!))
            : null {
    for (final ts in _loadedMap.map.tilesets) {
      final actualTs =
          ts.source != null ? _loadedMap.externalTilesets[ts.source]! : ts;
      _tileSetForFirstGid[ts.firstGid ?? 1] = actualTs;
      _tilesById[actualTs] = {};
      for (final tile in actualTs.tiles ?? const <Tile>[]) {
        _tilesById[actualTs]![tile.id] = tile;
      }
    }

    final allLayers = <Layer>[];
    void addLayer(Layer layer) {
      allLayers.add(layer);
      if (layer is GroupLayer) {
        layer.layers!.forEach(addLayer);
      }
    }

    _loadedMap.map.layers.forEach(addLayer);
    for (final layer in allLayers
        .whereType<ObjectGroupLayer>()
        .where(_hasCustomTargetLayer)) {
      final property = (layer.properties ?? [])
          .whereType<StringProperty>()
          .singleWhere((p) => p.name == _targetLayerPropertyName);
      _objectsByTargetLayer
          .putIfAbsent(property.value, () => [])
          .addAll(layer.objects ?? []);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: RenderOrder, etc.
    final visible = VisibleArea(
      _offset,
      size,
      _scale,
      _loadedMap.map.tileWidth,
      _loadedMap.map.tileHeight,
    );

    canvas
      ..save()
      ..translate(-_offset.dx, -_offset.dy)
      ..save()
      ..scale(_scale);

    if (_backgroundPaint != null) {
      canvas.drawPaint(_backgroundPaint!);
    }

    for (final layer in _loadedMap.map.layers) {
      _paintLayer(canvas, _elapsedMs, size, layer, visible);
    }

    canvas.restore();
    if (_debugMode) {
      canvas.drawRect(
          Rect.fromLTWH(_offset.dx, _offset.dy, size.width, size.height),
          _objectPaint);
    }
    canvas.restore();

    if (_debugMode) {
      TextPainter(
        text: TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.red),
          text: 'Screen $_offset\n'
              'Map ${visible.rect.topLeft}\n'
              'Map ${visible.rect.size}\n'
              'Grid Size(${_loadedMap.map.tileWidth}, ${_loadedMap.map.tileHeight}\n'
              'Rendering cols ${visible.firstCol} - ${visible.lastCol}\n'
              'Rendering rows ${visible.firstRow} - ${visible.lastRow}\n',
        ),
        textDirection: TextDirection.ltr,
      )
        ..layout()
        ..paint(canvas, const Offset(20, 300));
    }
  }

  @override
  bool shouldRepaint(TileMapPainter oldDelegate) => true;

  bool _hasCustomTargetLayer(Layer layer) =>
      layer.properties?.any((p) => p.name == _targetLayerPropertyName) ?? false;

  bool _isTile(MapObject obj) => obj.gid != null && obj.gid != 0;

  void _paintGeometricObject(Canvas canvas, MapObject obj) {
    switch (_loadedMap.map.orientation) {
      case TileMapOrientation.orthogonal:
        break;
      case TileMapOrientation.isometric:
        canvas
          ..scale(1, 0.5)
          ..rotate(45 * math.pi / 180)
          ..scale(math.sqrt(2));
        break;
      default:
        throw UnimplementedError();
    }

    if (obj.isPoint == true) {
      canvas.drawPoints(PointMode.points, [Offset.zero], _objectPaint);
    } else if (obj.isEllipse == true) {
      canvas.drawOval(
        Rect.fromPoints(Offset.zero, Offset(obj.width, obj.height)),
        _objectPaint,
      );
    } else if (obj.polygon?.isNotEmpty ?? false) {
      final polygon = obj.polygon!;
      canvas.drawPoints(
        PointMode.polygon,
        polygon
            .followedBy([polygon.first])
            .map((p) => Offset(p.x, p.y))
            .toList(),
        _objectPaint,
      );
    } else if (obj.polyline?.isNotEmpty ?? false) {
      final polyline = obj.polyline!;
      // PointMode.lines draw lines between pairs of points, not a full polyline
      // so we need to duplicate all items except the first/last.
      final points = List.generate(
        polyline.length * 2 - 2,
        (i) => polyline[((i + 1) / 2).floor()],
      );
      canvas.drawPoints(
        PointMode.lines,
        points.map((p) => Offset(p.x, p.y)).toList(),
        _objectPaint,
      );
    } else {
      canvas.drawRect(
        Rect.fromPoints(Offset.zero, Offset(obj.width, obj.height)),
        _objectPaint,
      );
    }
  }

  void _paintImageLayer(Canvas canvas, Size size, ImageLayer layer) {
    // TODO: Only if visible?
    final image = _loadedMap.mapImages[layer.image]!;
    canvas.drawImage(
      image,
      Offset(layer.x.toDouble(), layer.y.toDouble()),
      _paint,
    );
  }

  void _paintLayer(Canvas canvas, int elapsedMs, Size size, Layer layer,
      VisibleArea visible) {
    final offsetX = layer.offsetX ?? 0;
    final offsetY = layer.offsetY ?? 0;
    canvas
      ..save()
      // Translate the canvas and visible area to account for layer offset.
      ..translate(offsetX, offsetY);
    visible = visible.translate(-offsetX, -offsetY);
    // TODO: Opacity?

    if (layer is TileLayer) {
      _paintTileLayer(canvas, elapsedMs, size, layer, visible);
    } else if (layer is ObjectGroupLayer) {
      // Don't paint if this layer has a custom target, as its objects will be
      // painted during the target layer painting instead.
      if (!_hasCustomTargetLayer(layer)) {
        _paintObjectGroupLayer(canvas, elapsedMs, size, layer, visible);
      }
    } else if (layer is ImageLayer) {
      _paintImageLayer(canvas, size, layer);
    } else if (layer is GroupLayer) {
      for (final layer in layer.layers!) {
        _paintLayer(canvas, elapsedMs, size, layer, visible);
      }
    } else {
      throw Exception('Unknown layer type: ${layer.runtimeType}/${layer.type}');
    }

    canvas.restore();
  }

  void _paintObject(MapObject obj, Canvas canvas, int elapsedMs) {
    if (_debugMode) {
      final type = obj is Layer
          ? (obj as Layer).type
          : obj is Tileset
              ? (obj as Tileset).type
              : '';
      final text = '$type ${obj.name}'.trim();
      if (text != '') {
        TextPainter(
          text: TextSpan(
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.red,
              fontSize: 10 / _scale,
            ),
            text: text,
          ),
          textDirection: TextDirection.ltr,
        )
          ..layout()
          ..paint(canvas, _toOrtho(Offset(obj.x - 1, obj.y - 17)));
      }
    }
    final offset = _toOrtho(Offset(obj.x, obj.y));

    canvas
      ..save()
      ..translate(offset.dx, offset.dy)
      ..rotate(obj.rotation * math.pi / 180);

    if (_isTile(obj)) {
      _paintTile(canvas, elapsedMs, obj.gid!, Offset.zero,
          width: obj.width, height: obj.height, isObject: true);
    } else if (obj.text != null) {
      final text = obj.text!;
      // TODO: FIX THIS
      //  canvas.clipRect(Rect.fromLTWH(0, 0, obj.width, obj.height));
      TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: colorFromHex(text.color ?? _defaultTextColor),
            fontSize: text.pixelsize?.toDouble() ?? _defaultPixelSize,
            fontFamily: text.fontfamily,
          ),
          text: text.text,
        ),
        textDirection: TextDirection.ltr,
        textAlign: _toAlign(text.horizontalAlign),
      )
        ..layout(
            maxWidth: obj.width) // TODO: Cache this to avoid doing every frame.
        ..paint(canvas, Offset.zero);
    } else {
      _paintGeometricObject(canvas, obj);
    }

    canvas.restore();
  }

  void _paintObjectGroupLayer(Canvas canvas, int elapsedMs, Size size,
      ObjectGroupLayer layer, VisibleArea visible) {
    for (final obj in layer.objects!) {
      // TODO: Fix this to handle Isometric
      // if (!visible.rect
      //     .overlaps(correctedRect.translate(layer.offsetX, layer.offsetY))) {
      //   return;
      // }
      _paintObject(obj, canvas, elapsedMs);
    }
  }

  void _paintTile(Canvas canvas, int elapsedMs, int tileGid, Offset position,
      {double? width, double? height, bool isObject = false}) {
    if (tileGid == 0) {
      return;
    }

    // Extract the flip bits (bit 32, 21, 30).
    final flipHorizontal = tileGid & _bit32flippedHorizontally != 0;
    final flipVertical = tileGid & _bit31flippedVertically != 0;
    final flipAntiDiagonal = tileGid & _bit30flippedAntiDiagonally != 0;

    // Remove the top 3 bits that were flags.
    tileGid = tileGid & _low29bits;

    var ts = _loadedMap.map.tilesets
        .lastWhere((ts) => (ts.firstGid ?? 1) <= tileGid);
    // firstGid is always on the map tileset, not external.
    final firstGid = ts.firstGid ?? 1;
    if (ts.source != null) {
      ts = _loadedMap.externalTilesets[ts.source]!;
    }
    var tileIndex = tileGid - firstGid;
    var tileData = _tilesById[ts]![tileIndex];

    // If we're an animated file, we may need to swap the index based on the animation
    final animation = tileData?.animation;
    if (animation != null && animation.isNotEmpty) {
      // TODO: Why do I need to put <int> here?!
      final totalDuration = animation.fold<int>(0, (t, f) => t + f.duration);
      final elapsedTime = elapsedMs % totalDuration;
      var frameStart = 0;
      tileIndex = animation.firstWhere((f) {
        if (elapsedTime >= frameStart &&
            elapsedTime < frameStart + f.duration) {
          return true;
        }
        frameStart += f.duration;
        return false;
      }).tileId;
      tileData = _tilesById[ts]![tileIndex];
    }

    final image = _loadedMap.tilesetImages[ts]![tileData?.image ?? ts.image]!;

    // If the tile doesn't have an overriden width/height use it from the tileset.
    width ??= ts.tileWidth!.toDouble();
    height ??= ts.tileHeight!.toDouble();

    // TODO: Margin
    // TODO: TileOffset
    // TODO: TransparentColor
    Rect sourceRect;
    if (tileData != null && tileData.image != null) {
      sourceRect = Rect.fromLTWH(
        0,
        0,
        tileData.imageWidth.toDouble(),
        tileData.imageHeight.toDouble(),
      );
    } else {
      // Columns, width/height are only optional on references to external files so we
      // _must_ have it here.
      final columns = ts.columns!;
      final tileWidth = ts.tileWidth!.toDouble();
      final tileHeight = ts.tileHeight!.toDouble();
      final tileColInImage = tileIndex % columns;
      final tileRowInImage = (tileIndex / columns).floor();
      sourceRect = Rect.fromLTWH(
        (tileColInImage * tileWidth).toDouble(),
        (tileRowInImage * tileHeight).toDouble(),
        tileWidth,
        tileHeight,
      );
    }
    final destRect = Rect.fromLTWH(
      position.dx,
      // Offset the difference between actual tile height and grid height to
      // account isometric tiles taller than the grid.
      position.dy - height + _loadedMap.map.tileHeight,
      width,
      height,
    );

    final tileCenterX = destRect.left + destRect.width / 2.0;
    final tileCenterY = destRect.top + destRect.height / 2.0;

    // Calculate offsets to ensure we draw the tiles from the correct location.
    var offsetX = 0.0, offsetY = 0.0;
    switch (_loadedMap.map.orientation) {
      case TileMapOrientation.orthogonal:
        // For objects, orthogonal tiles are drawn from the top but the
        // coordinates are from the bottom.
        offsetY = isObject ? -_loadedMap.map.tileHeight.toDouble() : 0;
        break;
      case TileMapOrientation.isometric:
        // For isometric tiles, the origin is in the middle...
        offsetX = -width / 2;
        // And if they're objects, they're also drawn from the top but the
        // coordinates are for the bottom.
        offsetY = isObject ? -_loadedMap.map.tileHeight.toDouble() : 0.0;
        break;
      default:
        throw UnimplementedError();
    }

    canvas
      ..save()
      ..translate(tileCenterX, tileCenterY)
      ..scale(flipHorizontal ? -1 : 1, flipVertical ? -1 : 1)
      ..rotate(flipAntiDiagonal ? -90 * math.pi / 180 : 0)
      ..scale(flipAntiDiagonal ? -1 : 1, 1)
      ..translate(-tileCenterX, -tileCenterY)
      ..translate(offsetX, offsetY)
      ..drawImageRect(image, sourceRect, destRect, _paint)
      ..restore();
  }

  void _paintTileLayer(Canvas canvas, int elapsedMs, Size size, TileLayer layer,
      VisibleArea visible) {
    // TextPainter(
    //   text: TextSpan(
    //     style: TextStyle(color: Colors.white, backgroundColor: Colors.red),
    //     text: layer.data.join(', '),
    //   ),
    //   textDirection: TextDirection.ltr,
    // )
    //   ..layout()
    //   ..paint(canvas, const Offset(100, 100));
    // TODO: DrawOrder
    // TODO: Chunks

    //final image = images[layer.image];
    // TODO: use drawAtlas for performance?

    switch (_loadedMap.map.orientation) {
      case TileMapOrientation.orthogonal:
        _paintTileLayerOrgthogonal(visible, layer, canvas, elapsedMs);
        break;
      case TileMapOrientation.isometric:
        _paintTileLayerIsometric(visible, layer, canvas, elapsedMs);
        break;
      default:
        throw UnimplementedError();
    }
  }

  void _paintTileLayerIsometric(
    VisibleArea visible,
    TileLayer layer,
    Canvas canvas,
    int elapsedMs,
  ) {
    final objectsToRender = _objectsByTargetLayer[layer.name] ?? const [];

    for (var orthoY = visible.firstRow; orthoY <= visible.lastRow; orthoY++) {
      // Make two passes for each row so we can render the odd tiles after the
      // even tiles on either side.
      for (final renderEvens in [true, false]) {
        for (var orthoX = visible.firstCol;
            orthoX <= visible.lastCol;
            orthoX++) {
          if (orthoX.isEven != renderEvens) {
            continue;
          }

          final screenX = orthoX * visible.tileHalfWidth;
          final screenY = orthoY * visible.tileHeight +
              (orthoX.isOdd ? visible.tileHalfHeight : 0);
          final position = Offset(screenX.toDouble(), screenY.toDouble());

          final tileX = (screenX / visible.tileHalfWidth +
                  screenY / visible.tileHalfHeight) /
              2;
          final tileY = (screenY / visible.tileHalfHeight -
                  screenX / visible.tileHalfWidth) /
              2;

          _paintTileLayerTile(
            tileX.round(),
            tileY.round(),
            layer,
            canvas,
            elapsedMs,
            position,
          );

          for (final obj in objectsToRender) {
            final isoX = tileX * visible.tileHeight;
            final isoY = tileY * visible.tileHeight;
            if (Rect.fromLTWH(isoX, isoY, visible.tileHeight.toDouble(),
                    visible.tileHeight.toDouble())
                .contains(Offset(obj.x, obj.y))) {
              _paintObject(obj, canvas, elapsedMs);
            }
          }
        }
      }
    }
  }

  void _paintTileLayerOrgthogonal(
    VisibleArea visible,
    TileLayer layer,
    Canvas canvas,
    int elapsedMs,
  ) {
    for (var tileY = visible.firstRow; tileY <= visible.lastRow; tileY++) {
      // TODO: Do we need to handle this for Orthogonal?
      // final minY = tileY * visible.tileHeight.toDouble();
      // final maxY = (tileY + 1) * visible.tileHeight.toDouble();
      // final objectsToRender =
      //     _objectsTargettingLayer(layer, minY, maxY, visible);
      for (var tileX = visible.firstCol; tileX <= visible.lastCol; tileX++) {
        final position = Offset(tileX * visible.tileWidth.toDouble(),
            tileY * visible.tileHeight.toDouble());
        _paintTileLayerTile(tileX, tileY, layer, canvas, elapsedMs, position);
        // TODO: Do we need to handle this for Orthogonal? (see above)
        // for (final obj in objectsToRender) {
        //   _paintObject(obj, canvas, elapsedMs);
        // }
      }
    }
  }

  void _paintTileLayerTile(int tileX, int tileY, TileLayer layer, Canvas canvas,
      int elapsedMs, Offset position) {
    if (tileX < 0 ||
        tileX >= _loadedMap.map.width ||
        tileY < 0 ||
        tileY >= _loadedMap.map.height) {
      return;
    }

    final tileIndex = tileY * layer.width! + tileX;
    final gid = layer.data![tileIndex];
    _paintTile(canvas, elapsedMs, gid, position);
  }

  TextAlign _toAlign(ObjectTextHorizontalAlign align) {
    switch (align) {
      case ObjectTextHorizontalAlign.left:
        return TextAlign.left;
      case ObjectTextHorizontalAlign.center:
        return TextAlign.center;
      case ObjectTextHorizontalAlign.right:
        return TextAlign.right;
      case ObjectTextHorizontalAlign.justify:
        return TextAlign.justify;
    }
  }

  Offset _toOrtho(Offset point) {
    switch (_loadedMap.map.orientation) {
      case TileMapOrientation.orthogonal:
        return point;
      case TileMapOrientation.isometric:
        final x = point.dx - point.dy;
        final y = (point.dx + point.dy) / 2;
        return Offset(x, y);
      default:
        throw UnimplementedError();
    }
  }
}

class VisibleArea {
  final Offset _offset;
  final Size _size;
  final double _scale;
  final int tileWidth, tileHeight, tileHalfWidth, tileHalfHeight;
  final Rect rect;
  final int firstCol, lastCol, firstRow, lastRow;

  factory VisibleArea(
    Offset offset,
    Size size,
    double scale,
    int tileWidth,
    int tileHeight,
  ) {
    final rect = Rect.fromLTWH(offset.dx / scale, offset.dy / scale,
        size.width / scale, size.height / scale);
    final halfWidth = tileWidth / 2;
    // -1 is to get the "half" tiles on the odd rows.
    final orthoTileX = rect.left ~/ halfWidth - 1;
    final orthoTileY = rect.top ~/ tileHeight - 1;
    // +1 to account for the shift to get half tiles.
    final numCols = (rect.width / halfWidth).ceil() + 1;
    final numRows = (rect.height / tileHeight).ceil() + 1;

    return VisibleArea._(
      offset,
      size,
      scale,
      tileWidth,
      tileHeight,
      rect,
      orthoTileX,
      orthoTileX + numCols,
      orthoTileY,
      orthoTileY + numRows,
    );
  }

  VisibleArea._(
      this._offset,
      this._size,
      this._scale,
      this.tileWidth,
      this.tileHeight,
      this.rect,
      this.firstCol,
      this.lastCol,
      this.firstRow,
      this.lastRow)
      : tileHalfWidth = tileWidth ~/ 2,
        tileHalfHeight = tileHeight ~/ 2;

  VisibleArea translate(double offsetX, double offsetY) => VisibleArea(
        _offset.translate(offsetX, offsetY),
        _size,
        _scale,
        tileWidth,
        tileHeight,
      );
}
