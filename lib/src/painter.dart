import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/painting.dart';

import 'entities.dart';
import 'loader.dart';

const _bit30flippedAntiDiagonally = 0x20000000;
const _bit31flippedVertically = 0x40000000;
const _bit32flippedHorizontally = 0x80000000;
const _low29bits = 0x1FFFFFFF;

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
  final Offset _offset;
  final double _scale;
  final int _elapsedMs;
  final bool _debugMode;

  /// TODO: Tidy up debug handling.
  final Paint _paint = Paint();
  final Paint _backgroundPaint;
  final Paint _debugBorderPaint = Paint()
    ..strokeWidth = 10
    ..color = Colors.red
    ..style = PaintingStyle.stroke;

  TileMapPainter(
    this._loadedMap,
    this._offset, {
    int elapsedMs = 0,
    double scale = 1,
    bool debugMode = false,
  })  : assert(_loadedMap != null),
        assert(_loadedMap.map != null),
        assert(_loadedMap.mapImages != null),
        assert(_loadedMap.externalTilesets != null),
        assert(_loadedMap.tilesetImages != null),
        _elapsedMs = elapsedMs,
        _scale = scale,
        _debugMode = debugMode,
        _backgroundPaint = _loadedMap.map.backgroundColor != null
            ? (Paint()..color = colorFromHex(_loadedMap.map.backgroundColor))
            : null {
    for (final ts in _loadedMap.map.tilesets ?? const <Tileset>[]) {
      final actualTs =
          ts.source != null ? _loadedMap.externalTilesets[ts.source] : ts;
      _tileSetForFirstGid[ts.firstGid] = actualTs;
      _tilesById[actualTs] = {};
      for (final tile in actualTs.tiles ?? const <Tile>[]) {
        _tilesById[actualTs][tile.id] = tile;
      }
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
      canvas.drawPaint(_backgroundPaint);
    }

    for (final layer in _loadedMap.map.layers) {
      _paintLayer(canvas, _elapsedMs, size, layer, visible);
    }

    canvas.restore();
    if (_debugMode) {
      canvas.drawRect(
          Rect.fromLTWH(_offset.dx, _offset.dy, size.width, size.height),
          _debugBorderPaint);
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
  bool shouldRepaint(TileMapPainter oldDelegate) =>
      _loadedMap != oldDelegate._loadedMap ||
      _offset != oldDelegate._offset ||
      // TODO: Size???
      _loadedMap.hasAnimations;

  Rect _getRectContainingPoints(List<Point> polyline) {
    final minX = polyline.map((p) => p.x).reduce(min);
    final maxX = polyline.map((p) => p.x).reduce(max);
    final minY = polyline.map((p) => p.y).reduce(min);
    final maxY = polyline.map((p) => p.y).reduce(max);
    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  Rect _getRectForObject(MapObject obj) {
    if (_isTile(obj)) {
      return Rect.fromLTWH(obj.x, obj.y, _loadedMap.map.tileWidth.toDouble(),
          _loadedMap.map.tileHeight.toDouble());
    } else if (obj.polygon != null && obj.polygon.isNotEmpty) {
      return _getRectContainingPoints(obj.polygon).translate(obj.x, obj.y);
    } else if (obj.polyline != null && obj.polyline.isNotEmpty) {
      return _getRectContainingPoints(obj.polyline).translate(obj.x, obj.y);
    } else {
      return Rect.fromLTWH(obj.x, obj.y, obj.width, obj.height);
    }
  }

  bool _isTile(MapObject obj) => obj.gid != null && obj.gid != 0;

  void _paintImageLayer(Canvas canvas, Size size, ImageLayer layer) {
    // TODO: Only if visible?
    final image = _loadedMap.mapImages[layer.image];
    assert(image != null);
    canvas.drawImage(
      image,
      Offset(layer.x.toDouble(), layer.y.toDouble()),
      _paint,
    );
  }

  void _paintLayer(Canvas canvas, int elapsedMs, Size size, Layer layer,
      VisibleArea visible) {
    canvas
      ..save()
      // Translate the canvas and visible area to account for layer offset.
      ..translate(layer.offsetX, layer.offsetY);
    visible = visible.translate(-layer.offsetX, -layer.offsetY);
    // TODO: Opacity?

    if (layer is TileLayer) {
      _paintTileLayer(canvas, elapsedMs, size, layer, visible);
    } else if (layer is ObjectGroupLayer) {
      _paintObjectGroupLayer(canvas, elapsedMs, size, layer, visible);
    } else if (layer is ImageLayer) {
      _paintImageLayer(canvas, size, layer);
    } else if (layer is GroupLayer) {
      for (final layer in layer.layers) {
        _paintLayer(canvas, elapsedMs, size, layer, visible);
      }
    } else {
      throw Exception('Unknown layer type: ${layer.runtimeType}/${layer.type}');
    }

    canvas.restore();
  }

  void _paintObjectDebug(MapObject obj, Rect rect, Canvas canvas) {
    final text = '${obj.type} ${obj.name}'.trim();
    if (text != '') {
      TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: Colors.white,
            backgroundColor: Colors.red,
          ),
          text: text,
        ),
        textDirection: TextDirection.ltr,
      )
        ..layout()
        ..paint(canvas, Offset(obj.x - 1, obj.y - 17));
    }
    if (obj.isEllipse == true) {
      canvas.drawOval(rect, _debugBorderPaint);
    } else if (obj.isPoint == true) {
      canvas.drawPoints(PointMode.points, [rect.topLeft], _debugBorderPaint);
    } else if (obj.polygon != null && obj.polygon.isNotEmpty) {
      canvas
        ..save()
        ..translate(obj.x, obj.y)
        ..drawPoints(
          PointMode.polygon,
          obj.polygon.map((p) => Offset(p.x, p.y)).toList(),
          _debugBorderPaint,
        )
        ..restore();
    } else if (obj.polyline != null && obj.polyline.isNotEmpty) {
      canvas
        ..save()
        ..translate(obj.x, obj.y);
      // PointMode.lines darw lines between pairs of points, not a full polyline
      // so we need to duplicate all items except the first/last.
      final points = List.generate(
        obj.polyline.length * 2 - 2,
        (i) => obj.polyline[((i + 1) / 2).floor()],
      );
      canvas
        ..drawPoints(
          PointMode.lines,
          points.map((p) => Offset(p.x, p.y)).toList(),
          _debugBorderPaint,
        )
        ..restore();
    } else {
      // TODO: Handle non-rects?
      canvas.drawRect(rect, _debugBorderPaint);
    }
  }

  void _paintObjectGroupLayer(Canvas canvas, int elapsedMs, Size size,
      ObjectGroupLayer layer, VisibleArea visible) {
    // TODO: Some objects should be visible, but hidden ones should
    // be visible for debug.
    // TODO: Visible?
    // TODO: Don't pain those outside of the area
    for (final obj in layer.objects) {
      final rect = _getRectForObject(obj);
      if (!visible.rect
          .overlaps(rect.translate(layer.offsetX, layer.offsetY))) {
        return;
      }
      if (_isTile(obj)) {
        _paintTile(canvas, elapsedMs, obj.gid, obj.x.round(), obj.y.round());
      } else if (_debugMode) {
        _paintObjectDebug(obj, rect, canvas);
      }
    }
  }

  void _paintTile(Canvas canvas, int elapsedMs, int tileGid, int x, int y) {
    if (tileGid == null || tileGid == 0) {
      return;
    }

    // Extract the flip bits (bit 32, 21, 30).
    final flipHorizontal = tileGid & _bit32flippedHorizontally != 0;
    final flipVertical = tileGid & _bit31flippedVertically != 0;
    final flipAntiDiagonal = tileGid & _bit30flippedAntiDiagonally != 0;

    // Remove the top 3 bits that were flags.
    tileGid = tileGid & _low29bits;

    var ts = _loadedMap.map.tilesets.lastWhere((ts) => ts.firstGid <= tileGid);
    // firstGid is always on the map tileset, not external.
    final firstGid = ts.firstGid;
    if (ts.source != null) {
      ts = _loadedMap.externalTilesets[ts.source];
    }
    var tileIndex = tileGid - firstGid;
    var tileData = _tilesById[ts][tileIndex];

    // If we're an animated file, we may need to swap the index based on the animation
    if (tileData != null &&
        tileData.animation != null &&
        tileData.animation.isNotEmpty) {
      // TODO: Why do I need to put <int> here?!
      final totalDuration =
          tileData.animation.fold<int>(0, (t, f) => t + f.duration);
      final elapsedTime = elapsedMs % totalDuration;
      var frameStart = 0;
      tileIndex = tileData.animation.firstWhere((f) {
        if (elapsedTime >= frameStart &&
            elapsedTime < frameStart + f.duration) {
          return true;
        }
        frameStart += f.duration;
        return false;
      }).tileId;
      tileData = _tilesById[ts][tileIndex];
    }

    final image = _loadedMap.tilesetImages[ts][tileData?.image ?? ts.image];
    assert(image != null);

    // TODO: Margin
    // TODO: TileOffset
    // TODO: TransparentColor
    Rect sourceRect;
    if (tileData?.image != null) {
      sourceRect = Rect.fromLTWH(
        0,
        0,
        tileData.imageWidth.toDouble(),
        tileData.imageHeight.toDouble(),
      );
    } else {
      final tileColInImage = tileIndex % ts.columns;
      final tileRowInImage = (tileIndex / ts.columns).floor();
      sourceRect = Rect.fromLTWH(
        (tileColInImage * ts.tileWidth).toDouble(),
        (tileRowInImage * ts.tileHeight).toDouble(),
        ts.tileWidth.toDouble(),
        ts.tileHeight.toDouble(),
      );
    }
    final destRect = Rect.fromLTWH(
      // Offset the difference between actual tile size and grid size to account
      // for tall isometric maps.
      (x - ts.tileWidth + _loadedMap.map.tileWidth).toDouble(),
      (y - ts.tileHeight + _loadedMap.map.tileHeight).toDouble(),
      ts.tileWidth.toDouble(),
      ts.tileHeight.toDouble(),
    );

    final dx = destRect.left + destRect.width / 2.0;
    final dy = destRect.top + destRect.height / 2.0;
    canvas
      ..save()
      ..translate(dx, dy)
      ..scale(flipHorizontal ? -1 : 1, flipVertical ? -1 : 1)
      ..rotate(flipAntiDiagonal ? -90 * pi / 180 : 0)
      ..scale(flipAntiDiagonal ? -1 : 1, 1)
      ..translate(-dx, -dy)
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
        _paintTileLayerOrgthognal(visible, layer, canvas, elapsedMs);
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

          // Floor or ceil?
          final tileX = ((screenX / visible.tileHalfWidth +
                      screenY / visible.tileHalfHeight) /
                  2)
              .ceil();
          final tileY = ((screenY / visible.tileHalfHeight -
                      screenX / visible.tileHalfWidth) /
                  2)
              .ceil();

          _paintTileLayerTile(
              tileX, tileY, layer, canvas, elapsedMs, screenX, screenY);
        }
      }
    }
  }

  void _paintTileLayerOrgthognal(
    VisibleArea visible,
    TileLayer layer,
    Canvas canvas,
    int elapsedMs,
  ) {
    for (var tileX = visible.firstCol; tileX <= visible.lastCol; tileX++) {
      for (var tileY = visible.firstRow; tileY <= visible.lastRow; tileY++) {
        final screenX = tileX * visible.tileWidth;
        final screenY = tileY * visible.tileHeight;
        _paintTileLayerTile(
            tileX, tileY, layer, canvas, elapsedMs, screenX, screenY);
      }
    }
  }

  void _paintTileLayerTile(int tileX, int tileY, TileLayer layer, Canvas canvas,
      int elapsedMs, int screenX, int screenY) {
    if (tileX < 0 ||
        tileX >= _loadedMap.map.width ||
        tileY < 0 ||
        tileY >= _loadedMap.map.height) {
      return;
    }

    final tileIndex = tileY * layer.width + tileX;
    final gid = layer.data[tileIndex];
    _paintTile(canvas, elapsedMs, gid, screenX, screenY);
  }
}

class VisibleArea {
  final Offset _offset;
  final Size _size;
  final double _scale;
  final int tileWidth, tileHeight, tileHalfWidth, tileHalfHeight;
  final Rect rect;
  final int firstCol, lastCol, firstRow, lastRow;

  // TODO: this doesn't work for isometric maps, since the visible grid is not
  // a uniform grid :(

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
