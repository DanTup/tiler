import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path show join;
import 'package:tiler/tiler.dart';

/// A bundle for tests.
final _DiskAssetBundle testBundle = _DiskAssetBundle('test');

Future<void> expectMapRender(
  WidgetTester tester,
  String mapName, [
  String goldenName,
  Offset offset = Offset.zero,
  Size size = const Size(1000, 1000),
]) async {
  final map = await tester.runAsync(
    () => loadMap(testBundle, mapFile(mapName)),
  );

  await tester.pumpWidget(CustomPaint(
    painter: TileMapPainter(map, offset, 0),
    size: size,
  ));

  await expectLater(
    find.byType(CustomPaint),
    matchesGoldenFile(goldenFile(goldenName ?? mapName)),
  );
}

String goldenFile(String name) => 'test-levels/$name.png';

String mapFile(String name) => 'test-levels/$name.json';

class _DiskAssetBundle extends AssetBundle {
  final String rootFolder;
  _DiskAssetBundle(this.rootFolder);

  @override
  Future<ByteData> load(String key) async {
    final file = File(path.join(rootFolder, key));
    final bytes = await file.readAsBytes() as Uint8List;
    return ByteData.view(bytes.buffer);
  }

  @override
  Future<T> loadStructuredData<T>(
          String key, Future<T> Function(String value) parser) =>
      throw UnimplementedError();
}
