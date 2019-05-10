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
  final Map<int, Tileset> _tileSetForGid = {};
  // TODO: This is messy... can we merge the Tileset from the definition + external
  // file somehow without making everything mutable?
  final Map<int, int> _tileSetsFirstGidForTileGid = {};
  final Map<Tileset, Map<int, Tile>> _tilesById = {};
  final Offset _offset;
  final int _elapsedMs;
  final bool _debugMode;

  /// TODO: Tidy up debug handling.
  final Paint _paint = Paint();
  final Paint _backgroundPaint;
  final Paint _debugBorderPaint = Paint()
    ..strokeWidth = 2
    ..color = Colors.red
    ..style = PaintingStyle.stroke;

  TileMapPainter(
    this._loadedMap,
    this._offset,
    this._elapsedMs, {
    bool debugMode = false,
  })  : assert(_loadedMap != null),
        assert(_loadedMap.map != null),
        assert(_loadedMap.images != null),
        _debugMode = debugMode,
        _backgroundPaint = _loadedMap.map.backgroundColor != null
            ? (Paint()..color = colorFromHex(_loadedMap.map.backgroundColor))
            : null {
    for (final ts in _loadedMap.map.tilesets ?? const <Tileset>[]) {
      final actualTs =
          ts.source != null ? _loadedMap.externalTilesets[ts.source] : ts;
      for (var i = 0; i < actualTs.tileCount; i++) {
        _tileSetForGid[ts.firstGid + i] = actualTs;
        _tileSetsFirstGidForTileGid[ts.firstGid + i] = ts.firstGid;
      }
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
        _offset, size, _loadedMap.map.tileWidth, _loadedMap.map.tileHeight);

    canvas
      ..save()
      ..translate(-_offset.dx, -_offset.dy);

    if (_backgroundPaint != null) {
      canvas.drawPaint(_backgroundPaint);
    }

    for (final layer in _loadedMap.map.layers) {
      _paintLayer(canvas, _elapsedMs, size, layer, visible);
    }

    if (_debugMode) {
      canvas.drawRect(visible.rect, _debugBorderPaint);
    }
    canvas.restore();

    if (_debugMode) {
      TextPainter(
        text: TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.red),
          text: '$_offset\n'
              'Rendering cols ${visible.firstCol} - ${visible.lastCol}\n'
              'Rendering rows ${visible.firstRow} - ${visible.lastRow}\n',
        ),
        textDirection: TextDirection.ltr,
      )
        ..layout()
        ..paint(canvas, const Offset(100, 400));
    }
  }

  @override
  bool shouldRepaint(TileMapPainter oldDelegate) =>
      !_loadedMap.isEqualTo(oldDelegate._loadedMap) ||
      _offset != oldDelegate._offset ||
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
    canvas.drawImage(
      _loadedMap.images[layer.image],
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
        _paintTile(canvas, elapsedMs, obj.gid, obj.x, obj.y);
      } else if (_debugMode) {
        _paintObjectDebug(obj, rect, canvas);
      }
    }
  }

  void _paintTile(
      Canvas canvas, int elapsedMs, int tileGid, double x, double y) {
    if (tileGid == null || tileGid == 0) {
      return;
    }

    // Extract the flip bits (bit 32, 21, 30).
    final flippedHorizontally = tileGid & _bit32flippedHorizontally != 0;
    final flippedVertically = tileGid & _bit31flippedVertically != 0;
    final flippedAntiDiagnocally = tileGid & _bit30flippedAntiDiagonally != 0;

    // Remove the top 3 bits that were flags.
    tileGid = tileGid & _low29bits;

    final ts = _tileSetForGid[tileGid];
    var tileIndex = tileGid - _tileSetsFirstGidForTileGid[tileGid];
    final tileData = _tilesById[ts][tileIndex];

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
    }

    final image = _loadedMap.images[ts.image];
    // TODO: Margin
    // TODO: TileOffset
    // TODO: TransparentColor
    // TODO: Tile image?!!!!!!!!!!!!!!!!!!
    final tileColInImage = tileIndex % ts.columns;
    final tileRowInImage = (tileIndex / ts.columns).floor();
    final sourceRect = Rect.fromLTWH(
      (tileColInImage * ts.tileWidth).toDouble(),
      (tileRowInImage * ts.tileHeight).toDouble(),
      ts.tileWidth.toDouble(),
      ts.tileHeight.toDouble(),
    );
    final destRect = Rect.fromLTWH(
      x,
      y,
      ts.tileWidth.toDouble(),
      ts.tileHeight.toDouble(),
    );

    var needsRestore = false;
    if (flippedAntiDiagnocally) {
      if (!needsRestore) {
        canvas.save();
        needsRestore = true;
      }
      final dx = destRect.left + destRect.width / 2.0;
      final dy = destRect.top + destRect.height / 2.0;
      canvas
        ..translate(dx, dy)
        ..rotate(90 * pi / 180)
        ..scale(1, -1)
        ..translate(-dx, -dy);
    }
    if (flippedHorizontally) {
      if (!needsRestore) {
        canvas.save();
        needsRestore = true;
      }
      final dx = destRect.left + destRect.width / 2.0;
      canvas
        ..translate(dx, 0)
        ..scale(-1, 1)
        ..translate(-dx, 0);
    }
    if (flippedVertically) {
      if (!needsRestore) {
        canvas.save();
        needsRestore = true;
      }
      final dy = destRect.top + destRect.height / 2.0;
      canvas
        ..translate(0, dy)
        ..scale(1, -1)
        ..translate(0, -dy);
    }
    if (flippedAntiDiagnocally) {
      // TODO: This
    }
    canvas.drawImageRect(image, sourceRect, destRect, _paint);
    if (needsRestore) {
      canvas.restore();
    }
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

    final firstVisibleCol = max(visible.firstCol, 0);
    final lastVisibleCol = min(visible.lastCol, _loadedMap.map.width - 1);
    final firstVisibleRow = max(visible.firstRow, 0);
    final lastVisibleRow = min(visible.lastRow, _loadedMap.map.height - 1);
    for (var x = firstVisibleCol; x <= lastVisibleCol; x++) {
      for (var y = firstVisibleRow; y <= lastVisibleRow; y++) {
        final tileGid = layer.data[y * layer.width + x];
        _paintTile(
          canvas,
          elapsedMs,
          tileGid,
          (x * _loadedMap.map.tileWidth).toDouble(),
          (y * _loadedMap.map.tileHeight).toDouble(),
        );
      }
    }
  }
}

class VisibleArea {
  final Offset _offset;
  final Size _size;
  final int _tileWidth, _tileHeight;
  final Rect rect;
  final int firstCol, lastCol, firstRow, lastRow;

  VisibleArea(this._offset, this._size, this._tileWidth, this._tileHeight)
      : rect = Rect.fromLTWH(_offset.dx, _offset.dy, _size.width, _size.height),
        firstCol = (_offset.dx / _tileWidth).floor(),
        lastCol = ((_offset.dx + _size.width) / _tileWidth).floor(),
        firstRow = (_offset.dy / _tileHeight).floor(),
        lastRow = ((_offset.dy + _size.height) / _tileHeight).floor();

  VisibleArea translate(double offsetX, double offsetY) => VisibleArea(
      _offset.translate(offsetX, offsetY), _size, _tileWidth, _tileHeight);
}
