import 'dart:io';

import 'package:path/path.dart';

import 'src/dart_generator.dart';
import 'src/tiled_json_spec_parser.dart';
import 'src/utils.dart';

Future<void> main() async {
  // Ensure relative paths are from this script.
  Directory.current = Directory(dirname(Platform.script.toFilePath()));

  final specUri = Uri.parse(
      'https://raw.githubusercontent.com/mapeditor/tiled/7fa253f244d2d2d74796f0e1fd7ea2d70a5250f3/docs/reference/json-map-format.rst');
  final outputFile = File('../lib/src/entities_generated.dart');

  final codeGen = DartGenerator();
  final parser = TiledJsonSpecParser();

  // Add any custom definitions for things the JSON spec assumes exist.
  final customDefs = <ClassDefinition>[
    // ClassDefinition(
    //   // TODO: Remove this is Point is added to the spec
    //   // https://github.com/bjorn/tiled/issues/2116
    //   'Point',
    //   [
    //     FieldDefinition('x', 'x', 'double', '', null),
    //     FieldDefinition('y', 'y', 'double', '', null),
    //   ],
    // )
  ];

  final doc = await fetch(specUri);
  final defs = parser.parse(doc)..addAll(customDefs);
  final defsCode = codeGen.generate(defs);
  final code = '''
part of 'entities.dart';

$defsCode''';

  await writeFile(outputFile, code);
  await formatFile(outputFile);
}
