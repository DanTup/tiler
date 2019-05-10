import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

import 'entities.dart';

String fixPath(String p) => path.normalize(p).replaceAll(r'\', '/');

/// Loads a Tiled json map asynchronously. All external resources (including
/// images and external tilesets) must be in the same bundle and will be loaded
/// during this phase, plus some additional computation the reduce work required
/// during rendering.
Future<LoadedTileMap> loadMap(AssetBundle bundle, String mapFile) async {
  final map = TileMap.fromJson(
    jsonDecode(
      await bundle.loadString(fixPath(mapFile)),
    ) as Map<String, dynamic>,
  );

  final mapFolder = path.dirname(mapFile);
  final externalTilesets = await _getExternalTilesets(bundle, mapFolder, map);
  final mapImages = await _preloadMapImages(bundle, mapFolder, map);
  final tilesetImages = <Tileset, Map<String, Image>>{};
  await Future.wait(map.tilesets.map((ts) async {
    tilesetImages[ts] = await _preloadTilesetImages(bundle, mapFolder, ts);
  }));
  await Future.wait(externalTilesets.keys.map((tsPath) async {
    final ts = externalTilesets[tsPath];
    final tsFolder = path.join(mapFolder, path.dirname(tsPath));
    tilesetImages[ts] = await _preloadTilesetImages(bundle, tsFolder, ts);
  }));

  final hasAnimations = map.tilesets.followedBy(externalTilesets.values).any(
      (ts) =>
          ts.tiles != null &&
          ts.tiles.any((t) => t.animation != null && t.animation.isNotEmpty));
  return LoadedTileMap(
      map, mapImages, externalTilesets, tilesetImages, hasAnimations);
}

Future<Map<String, Tileset>> _getExternalTilesets(
    AssetBundle bundle, String mapFolder, TileMap map) async {
  final externalTilesets = map.tilesets
      .where((ts) => ts.source != null)
      .map((ts) => ts.source)
      .toList();

  final tilesets = <String, Tileset>{};
  await Future.wait(externalTilesets.map((tsPath) async {
    final assetsPath = '$mapFolder/$tsPath';
    tilesets[tsPath] = await _loadTileset(bundle, assetsPath);
  }));
  return tilesets;
}

Future<Image> _loadImage(AssetBundle bundle, String assetsPath) async {
  final imageData = await bundle.load(fixPath(assetsPath));
  final image = await decodeImageFromList(imageData.buffer.asUint8List());
  return image;
}

Future<Tileset> _loadTileset(AssetBundle bundle, String tsFile) async =>
    Tileset.fromJson(jsonDecode(
      await bundle.loadString(fixPath(tsFile)),
    ) as Map<String, dynamic>);

Future<Map<String, Image>> _preloadMapImages(
    AssetBundle bundle, String mapFolder, TileMap map) async {
  Iterable<Layer> layerWithChildren(Layer layer) => layer is GroupLayer
      ? <Layer>[layer].followedBy(layer.layers.expand(layerWithChildren))
      : [layer];
  final allLayers =
      map.layers.followedBy(map.layers.expand(layerWithChildren)).toList();

  final allImages = allLayers
      .whereType<ImageLayer>()
      .map((l) => l.image)
      .where((img) => img != null)
      .toList();

  final images = <String, Image>{};
  await Future.wait(allImages.map((imgPath) async {
    final assetsPath = '$mapFolder/$imgPath';
    images[imgPath] = await _loadImage(bundle, assetsPath);
  }));
  return images;
}

Future<Map<String, Image>> _preloadTilesetImages(
    AssetBundle bundle, String tilesetFolder, Tileset ts) async {
  final allImages = [ts.image]
      .followedBy(ts.tiles?.map((t) => t.image) ?? const [])
      .where((img) => img != null)
      .toList();

  final images = <String, Image>{};
  await Future.wait(allImages.map((imgPath) async {
    final assetsPath = '$tilesetFolder/$imgPath';
    images[imgPath] = await _loadImage(bundle, assetsPath);
  }));
  return images;
}

// TODO: Rename this and maybe convert everything to our own data structure that
// can pre-compute anything expensive to avoid doing it every frame (for ex,
// animation lengths, TextPainter layouts, etc.)
class LoadedTileMap {
  final TileMap map;

  /// A lookup from a map-relative path to the related [Image].
  final Map<String, Image> mapImages;

  /// A lookup from a map-relative path to an external [Tileset].
  final Map<String, Tileset> externalTilesets;

  /// A lookup from a tileset-relative path to the related [Image].
  final Map<Tileset, Map<String, Image>> tilesetImages;

  /// Whether this map has animations and may need to be redrawn as time passes
  /// even if there have been no other changes.
  final bool hasAnimations;

  LoadedTileMap(this.map, this.mapImages, this.externalTilesets,
      this.tilesetImages, this.hasAnimations);
}
