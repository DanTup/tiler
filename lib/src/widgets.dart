import 'package:flutter/widgets.dart';

import 'loader.dart';
import 'painter.dart';

class TileMap extends StatelessWidget {
  final LoadedTileMap loadedMap;
  final Offset offset;
  final Size size;
  final int elapsedMilliseconds;

  const TileMap(
    this.loadedMap,
    this.offset,
    this.size, [
    this.elapsedMilliseconds = 0,
  ]);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TileMapPainter(
        loadedMap,
        offset,
        elapsedMilliseconds,
      ),
      size: size,
    );
  }
}
