import 'package:flutter/widgets.dart';

import 'loader.dart';
import 'painter.dart';

class TileMap extends StatelessWidget {
  final LoadedTileMap loadedMap;
  final Offset offset;
  final Size size;
  final double scale;
  final int elapsedMilliseconds;
  final bool debugMode;

  const TileMap(
    this.loadedMap,
    this.offset,
    this.size, {
    this.scale = 1,
    this.elapsedMilliseconds = 0,
    this.debugMode,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TileMapPainter(
        loadedMap,
        offset,
        scale: scale,
        elapsedMs: elapsedMilliseconds,
        debugMode: debugMode,
      ),
      size: size,
    );
  }
}
