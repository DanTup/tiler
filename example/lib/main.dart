import 'dart:async';

import 'package:flutter/material.dart' hide Image;
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
  late Future<LoadedTileMap> tileMap;
  Offset offset = Offset.zero;
  Stopwatch sw = Stopwatch()..start();

  _TileMapWidgetState(this.mapFile);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LoadedTileMap>(
      future: tileMap,
      builder: (context, snapshot) {
        final loadedMap = snapshot.data;
        if (loadedMap != null) {
          final map = loadedMap.map;
          return Padding(
            padding: const EdgeInsets.all(60),
            child: TileMap(
              loadedMap,
              offset,
              Size(
                (map.width * map.tileWidth).toDouble(),
                (map.height * map.tileHeight).toDouble(),
              ),
              scale: 0.5,
              elapsedMilliseconds: sw.elapsedMilliseconds,
              debugMode: true,
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
