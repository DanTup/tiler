# Tiler

A [Dart/Flutter library](https://pub.dev/packages/tiler) for rendering maps created with the Tiled map editor in Dart/Flutter.

Example map in the [Tiled](https://www.mapeditor.org/) editor:

<img src="https://github.com/DanTup/tiler/raw/master/doc/screenshots/simple_example_tiled.png" width="795" height="345" />

Example map rendered in Flutter using Tiler:

<img src="https://github.com/DanTup/tiler/raw/master/doc/screenshots/simple_example.png" width="840" height="510" />

## Usage

Tile maps and tilesets must use the JSON format (not XML).

Use `loadMap` to load a map and all external assets asynchronously (for ex. during a loading screen or using a `FutureBuilder`):

```dart
var loadedMap = await loadMap(rootBundle, 'assets/example_map.json');
```

Use the `TileMap` widget to render the map at a given offset with a given size. The number of elapsed milliseconds must be supplied for animated tiles to animate.

```dart
TileMap(
  loadedMap,
  offset,
  Size(
    (map.width * map.tileWidth).toDouble(),
    (map.height * map.tileHeight).toDouble(),
  ),
  sw.elapsedMilliseconds,
)
```
