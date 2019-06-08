import 'dart_generator.dart';

final _arrayDescription = RegExp(r'Array of :ref:`[\w ]+ <json-([\w\-]+)>`');
final _csvRow = RegExp(
    r'^\s*(?:([^"][^,]*)|"([^"]+)")\s*,\s*(?:([^"][^,]*)|"([^"]+)")\s*,\s*(?:([^"][^,]*)|"([^"]+)")\s*$',
    multiLine: true);
final _defaultValue = RegExp(
    r'``([\w\-]+)`` \(default\)|(empty) \(default\)|\(default: `?`?([\d\w\-]+)`?`?\)');
final _descriptionReferences = RegExp(r'``([\w ]+)``');
final _enumValue = RegExp(r'``([\w\-]+)``(?! only)|empty');
final _refType = RegExp(r':ref:`json-([\w\-]+)`');
final _table = RegExp(
    r'^\.\. _json-([\w\-]+):\n\n[\w ]+(?: \(?\w+\))?\n[-~\^]+\n+\s*\n[\s\S]*?\.\. csv-table::\n(?:\s*:\w+.*\n)*\n([\s\S]+?)\n$',
    multiLine: true);
final _wordSeparators = RegExp('[ \-]');

/// Stores the [rawDescription] on a FieldDefinition to allow parsin additional
/// data from it.
class FieldDefinitionWithRawDescription extends FieldDefinition {
  final String rawDescription;
  FieldDefinitionWithRawDescription(String jsonName, String name, String type,
      this.rawDescription, String description, String defaultValue)
      : super(jsonName, name, type, description, defaultValue);
}

/// Parses the Tiled JSON spec into Class and Field definitions.
class TiledJsonSpecParser {
  List<Definition> parse(String spec) {
    final samples = _extractTables(spec);
    return samples.keys
        .expand((name) => _parseTable(name, samples[name]))
        .toList();
  }

  String _cleanDescription(String input) => input
      ?.trim()
      ?.replaceAllMapped(_descriptionReferences, (m) => m.group(1));

  EnumDefinition _createEnum(
      String className, FieldDefinitionWithRawDescription f) {
    final values = _enumValue
        .allMatches(f.rawDescription)
        .map((m) => m.group(1) ?? 'none')
        .toSet()
        .toList();
    return EnumDefinition('$className${_upperFirst(_improveName('', f.name))}',
        values.map(_generateEnumValue).toList());
  }

  FieldDefinitionWithRawDescription _createField(Match m, String className) {
    final jsonName = (m.group(1) ?? m.group(2)).trim();
    final jsonType = (m.group(3) ?? m.group(4)).trim();
    final description = (m.group(5) ?? m.group(6)).trim();
    final defaultMatch = _defaultValue.firstMatch(description);
    final defaultValue = defaultMatch?.group(1) ??
        defaultMatch?.group(2) ??
        defaultMatch?.group(3);

    final name = _improveName(jsonType, jsonName);
    final type = _isEnum(description)
        ? '$className${_upperFirst(_improveName(jsonType, name))}'
        : jsonType;

    final defaultString = defaultValue == null
        ? null
        : _isEnum(description)
            ? '$type.${defaultValue == 'empty' ? 'none' : _improveName(null, defaultValue)}'
            : jsonType == 'string' ? "'$defaultValue'" : defaultValue;

    final cleanDescription = _cleanDescription(description);

    final dartType = _toDartType(name, type, cleanDescription);

    return FieldDefinitionWithRawDescription(
        jsonName, name, dartType, description, cleanDescription, defaultString);
  }

  String _extractArrayType(String description) {
    if (description.contains('A list of x,y coordinates in pixels')) {
      return 'Point';
    }
    if (description.contains('Array of Wang color indexes')) {
      return 'int';
    }
    if (description.contains('Index of terrain for each corner of tile')) {
      return 'int';
    }
    return _improveName('', _arrayDescription.firstMatch(description).group(1));
  }

  Map<String, String> _extractTables(String doc) {
    return Map.fromEntries(
      _table.allMatches(doc).map((g) => MapEntry(g.group(1), g.group(2))),
    );
  }

  EnumValueDefinition _generateEnumValue(String value) =>
      EnumValueDefinition(_improveName(null, value), value);

  /// Converts TSX fields like "backgroundcolor" into camelCase equivalents.
  String _improveName(String type, String name) {
    const nameImprovements = {
      'backgroundcolor': 'backgroundColor',
      'cornercolors': 'cornerColors',
      'dflip': 'flippedDiagonally',
      'draworder': 'drawOrder',
      'edgecolors': 'edgeColors',
      'firstgid': 'firstGid',
      'halign': 'horizontalAlign',
      'hexsidelength': 'hexSideLength',
      'hflip': 'flippedHorizontally',
      'imageheight': 'imageHeight',
      'imagelayer': 'imageLayer',
      'imagewidth': 'imageWidth',
      'index': 'indexOrder',
      'map': 'tileMap',
      'nextlayerid': 'nextLayerId',
      'nextobjectid': 'nextObjectId',
      'object': 'mapObject',
      'objectgroup': 'objectGroup',
      'objectgrouplayer': 'objectGroupLayer',
      'objecttemplate': 'objectTemplate',
      'offsetx': 'offsetX',
      'offsety': 'offsetY',
      'renderorder': 'renderOrder',
      'staggeraxis': 'staggerAxis',
      'staggerindex': 'staggerIndex',
      'startx': 'startX',
      'starty': 'startY',
      'tilecount': 'tileCount',
      'tiledversion': 'tiledVersion',
      'tileheight': 'tileHeight',
      'tileid': 'tileId',
      'tilelayer': 'tileLayer',
      'tileoffset': 'tileOffset',
      'tilesetgrid': 'tileSetGrid',
      'tilesettileoffset': 'tileOffset',
      'tilewidth': 'tileWidth',
      'topdown': 'topDown',
      'transparentcolor': 'transparentColor',
      'valign': 'verticalAlign',
      'vflip': 'flippedVertically',
      'wangcolor': 'wangColor',
      'wangid': 'wangId',
      'wangset': 'wangSet',
      'wangsets': 'wangSets',
      'wangtile': 'wangTile',
      'wangtiles': 'wangTiles',
    };
    name =
        name.replaceAllMapped(RegExp(r'-(.)'), (m) => m.group(1).toUpperCase());
    name = nameImprovements[name.toLowerCase()] ?? name;
    return type == 'bool' ? 'is${_upperFirst(name)}' : name;
  }

  bool _isEnum(String fieldDescription) =>
      fieldDescription.contains('`` or ') ||
      fieldDescription.contains('`` (default) or ');

  List<Definition> _parseTable(String name, String fieldSpec) {
    final className = _pascalCase(_improveName(null, name));

    final fields = _csvRow
        .allMatches(fieldSpec)
        .map((m) => _createField(m, className))
        // Special handling for Property - remove `value` since it'll be added
        // to the subclasses.
        .where((f) => className != 'Property' || f.name != 'value')
        .toList();

    final enums = fields
        .where((f) => _isEnum(f.rawDescription))
        .map((f) => _createEnum(className, f))
        .toList();

    // If the `type` field is an enum, when split this into subclasses.
    final subClasses = <SubClassDefinition>[];
    for (final f
        in fields.where((f) => f.name == 'type' && _isEnum(f.rawDescription))) {
      final types = _enumValue
          .allMatches(f.rawDescription)
          .map((m) => m.group(1))
          .where((v) => v != null)
          .toSet()
          .toList();
      for (final type in types) {
        // Get any fields specific to this type.
        final myFieldsPattern = RegExp('``$type`` only');
        final myFields = fields
            .where((f) => myFieldsPattern.hasMatch(f.rawDescription))
            .toList();

        // Special handling for Property types - we add in the `value` field
        // with the correct type.
        if (className == 'Property') {
          myFields.add(FieldDefinitionWithRawDescription('value', 'value',
              _toDartType('value', type, null), null, null, null));
        }

        final name = type.toLowerCase().endsWith(className.toLowerCase())
            ? type
            : '$type$className';
        subClasses.add(SubClassDefinition(
            type, _upperFirst(_improveName(null, name)), myFields));
      }
    }

    final sharedFieldsPattern = RegExp(r'``\w+`` only');
    final sharedFields = fields
        .where((f) => !sharedFieldsPattern.hasMatch(f.rawDescription))
        .toList();

    return [
      ClassDefinition(
        className,
        sharedFields,
        subClasses: subClasses,
      ),
    ]
      // TODO: Remove this ignore and change to spread collections after next
      // Flutter release.
      // ignore: prefer_spread_collections
      ..addAll(subClasses)
      ..addAll(enums);
  }

  /// Converts "string of words" to "StringOfWords".
  String _pascalCase(String input) {
    final words = input.split(_wordSeparators);
    return words.map(_upperFirst).join();
  }

  String _toDartType(String fieldName, String type, String description) {
    const typeMapping = {
      'int': 'int',
      'string': 'String',
      'float': 'double',
      'bool': 'bool',
      'object': 'dynamic', // TODO: Make better?
      'number': 'num',
      'double': 'double',
      'color': 'String',
      'file': 'String',
    };
    if (type == 'array or string' && fieldName == 'data') {
      return 'List<int>';
    } else if (type == 'object' && fieldName == 'objects') {
      return 'List<MapObject>';
    } else if (type == 'array') {
      return 'List<${_toDartType('', _extractArrayType(description), '')}>';
    } else if (type.startsWith(':ref:')) {
      final typeName = _refType.firstMatch(type).group(1);
      // HACK: Handle Tile.objectGroup
      if (fieldName == 'objectGroup' && typeName == 'layer') {
        return 'ObjectGroupLayer';
      } else {
        return _pascalCase(_improveName('', typeName));
      }
    } else {
      return typeMapping[type] ?? _pascalCase(type);
    }
  }

  /// Uppercases the first letter of a string.
  String _upperFirst(String s) => s[0].toUpperCase() + s.substring(1);
}
