import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:tiler/tiler.dart';

/// Loads a Tiled tsx map asynchronously. All external resources (including images
/// and external tilesets) will be loaded during this phase, plus some additional
/// computation the reduce work required during rendering.
Future<LoadedTileMap> loadMap(String mapFile) async {
  final map = TileMap.fromJson(
    jsonDecode(
      await rootBundle.loadString(mapFile),
    ) as Map<String, dynamic>,
  );

  final mapFolder = path.dirname(mapFile);
  final externalTilesets = await _getExternalTilesets(mapFolder, map);
  final images =
      await _getPreloadedImages(mapFolder, map, externalTilesets.values);
  // Check if any tiles have animations, as we'll need to redraw every frame for this.
  final hasAnimations = map.tilesets.followedBy(externalTilesets.values).any(
      (ts) =>
          ts.tiles != null &&
          ts.tiles.any((t) => t.animation != null && t.animation.isNotEmpty));
  return LoadedTileMap(map, externalTilesets, images, hasAnimations);
}

Future<Map<String, Tileset>> _getExternalTilesets(
    String mapFolder, TileMap map) async {
  final externalTilesets = map.tilesets
      .where((ts) => ts.source != null)
      .map((ts) => ts.source)
      .toList();

  final tilesets = <String, Tileset>{};
  await Future.wait(externalTilesets.map((tsPath) async {
    final assetsPath = '$mapFolder/$tsPath';
    tilesets[tsPath] = await _loadTileset(assetsPath);
  }));
  return tilesets;
}

Future<Map<String, Image>> _getPreloadedImages(
    String mapFolder, TileMap map, Iterable<Tileset> externalTilesets) async {
  final allTilesets = map.tilesets.followedBy(externalTilesets).toList();
  final allImages = map.layers
      .whereType<ImageLayer>()
      .map((l) => l.image)
      .followedBy(allTilesets.map((ts) => ts.image))
      .followedBy(
          allTilesets.expand((ts) => ts.tiles?.map((t) => t.image) ?? const []))
      .where((img) => img != null)
      .toList();

  // Pre-load all images into a cache while we're loading, since we can't do
  // this during rendering.
  final images = <String, Image>{};
  await Future.wait(allImages.map((imgPath) async {
    final assetsPath = '$mapFolder/$imgPath';
    images[imgPath] = await _loadImage(assetsPath);
  }));
  return images;
}

Future<Image> _loadImage(String assetsPath) async {
  final imageData = await rootBundle.load(assetsPath);
  final image = await decodeImageFromList(imageData.buffer.asUint8List());
  return image;
}

Future<Tileset> _loadTileset(String tsFile) async =>
    Tileset.fromJson(jsonDecode(
      await rootBundle.loadString(tsFile),
    ) as Map<String, dynamic>);

// TODO: Rename this and maybe convert everything to our own data structure that
// can pre-compute anything expensive to avoid doing it every frame (for ex,
// animation lengths, TextPainter layouts, etc.)
class LoadedTileMap {
  final TileMap map;
  final Map<String, Tileset> externalTilesets;
  final Map<String, Image> images;
  final bool hasAnimations;

  LoadedTileMap(
      this.map, this.externalTilesets, this.images, this.hasAnimations);

  bool isEqualTo(LoadedTileMap other) =>
      map == other.map &&
      externalTilesets == other.externalTilesets &&
      images == other.images;
}
