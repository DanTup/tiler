import 'dart:async';
import 'dart:math' as math;
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
      home: const TileMapWidget('assets/isometric_testing.json'),
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
            child: TileMap(
              loadedMap,
              offset,
              Size(
                (map.width * map.tileWidth).toDouble(),
                (map.height * map.tileHeight).toDouble(),
              ),
              scale: 0.3,
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
    // ..then((map) {
    //   void addLayer(Layer layer) {
    //   final layers = <Layer>[];
    //     layers.add(layer);
    //     if (layer is GroupLayer) {
    //       layer.layers.forEach(addLayer);
    //     }
    //   }

    //   map.map.layers.forEach(addLayer);
    //   final player = layers
    //       .whereType<ObjectGroupLayer>()
    //       .expand((layer) => layer.objects)
    //       .firstWhere((obj) => obj.name == 'player');

    //   final x = player.x;
    //   final y = player.y;
    //   Timer.periodic(Duration(milliseconds: 100), (t) {
    //     setState(() {
    //       player
    //         ..x = x + math.cos(t.tick.toDouble() / 5.0) * 150
    //         ..y = y + math.cos(t.tick.toDouble() / 5.0) * 150;
    //     });
    //   });
    // });
  }

  @override
  void deactivate() {
    super.deactivate();
    sw.stop();
  }
}
