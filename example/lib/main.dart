import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:tiler/tiler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiler Example Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TileMapWidget('assets/example_map.json'),
    );
  }
}

class TileMapWidget extends StatefulWidget {
  final String mapFile;
  const TileMapWidget(this.mapFile);

  @override
  _TileMapWidgetState createState() => _TileMapWidgetState(mapFile);
}

class _TileMapWidgetState extends State<TileMapWidget> {
  String mapFile;
  Future<LoadedTileMap> tileMap;
  Offset offset = Offset.zero;
  Stopwatch sw = Stopwatch()..start();

  _TileMapWidgetState(this.mapFile);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LoadedTileMap>(
      future: tileMap,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final loadedMap = snapshot.data;
          final map = loadedMap.map;
          return Padding(
            padding: const EdgeInsets.all(60),
            child: CustomPaint(
              painter: TileMapPainter(
                loadedMap,
                offset,
                sw.elapsedMilliseconds,
              ),
              size: Size(
                (map.width * map.tileWidth).toDouble(),
                (map.height * map.tileHeight).toDouble(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // TODO: ....
          return Text('ERROR LOADING MAP: ${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    tileMap = loadMap(rootBundle, mapFile);
  }

  @override
  void deactivate() {
    super.deactivate();
    sw.stop();
  }
}
