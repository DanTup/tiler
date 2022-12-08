class ClassDefinition extends Definition {
  final List<SubClassDefinition> subClasses;
  final List<FieldDefinition> fields;

  ClassDefinition(
    String name,
    this.fields, {
    this.subClasses = const [],
  }) : super(name) {
    for (final s in subClasses) {
      s.parent = this;
    }
    fields.sort((f1, f2) => f1.name.compareTo(f2.name));
  }
}

class DartGenerator {
  String generate(List<Definition> definitions) {
    definitions.sort((f1, f2) => f1.name.compareTo(f2.name));
    return definitions.map(_generate).join('\n\n');
  }

  String _generate(Definition definition) {
    if (definition is ClassDefinition) {
      return _generateClass(definition);
    } else if (definition is EnumDefinition) {
      return _generateEnum(definition);
    } else {
      throw Exception('Unknown type');
    }
  }

  String _generateClass(ClassDefinition definition) {
    final className = definition.name;

    final buffer = StringBuffer();
    if (definition.subClasses.isEmpty) {
      buffer.writeln('@JsonSerializable()');
    } else {
      buffer.write('abstract ');
    }
    buffer.write('class $className ');
    if (definition is SubClassDefinition) {
      buffer.write('extends ${definition.parent.name} ');
    }

    buffer.writeln('{');
    if (definition is SubClassDefinition) {
      final allFields = definition.parent.fields
          .map((f) => '    super.${f.name},')
          .followedBy(definition.fields.map((f) => '    this.${f.name},'))
          .toList();
      buffer
        ..writeln('  $className(')
        ..writeln(allFields.join('\n'))
        ..writeln('  );');
    } else {
      buffer
        ..writeln('  $className(')
        ..writeln(
            definition.fields.map((f) => '    this.${f.name},').join('\n'))
        ..writeln('  );');
    }

    // Handle fromJson()
    if (definition.subClasses.isEmpty) {
      buffer.writeln(
          '  factory $className.fromJson(Map<String, dynamic> json) => '
          '_\$${className}FromJson(json);');
    } else {
      buffer
        ..writeln('  factory $className.fromJson(Map<String, dynamic> json) {')
        ..writeln("    switch (json['type'] as String) {");
      for (final sub in definition.subClasses) {
        buffer
          ..writeln("      case '${sub.type}':")
          ..writeln('        return ${sub.name}.fromJson(json);');
      }
      buffer
        ..writeln('      default:')
        ..writeln("        throw Exception('Unknown ${definition.name} type: "
            "\${json['type']}');")
        ..writeln('    }')
        ..writeln('  }');
    }

    // Fields
    if (definition.fields.isNotEmpty) {
      buffer
        ..writeln('')
        ..writeln(
            '${definition.fields.map((field) => _generateField(definition, field)).join('\n\n')}');
    }

    buffer.write('}');

    return buffer.toString();
  }

  String _generateEnum(EnumDefinition definition) =>
      '''enum ${definition.name} {
${definition.values.map(_generateEnumValue).join('\n')}
}''';

  String _generateEnumValue(EnumValueDefinition value) {
    final annotations = value.name != value.jsonValue
        ? '''  @JsonValue('${value.jsonValue}')\n'''
        : '';
    return '$annotations  ${value.name},';
  }

  String _generateField(ClassDefinition class_, FieldDefinition field) {
    final buffer = StringBuffer();

    if (field.description?.isNotEmpty ?? false) {
      buffer.writeln('  /// ${field.description}');
    }

    final isOptional = _fieldIsOptional(class_, field);

    final jsonKeyParams = <String>[];
    if (field.name != field.jsonName) {
      jsonKeyParams.add("name: '${field.jsonName}'");
    }
    if (field.name == 'data' && field.type == 'List<int>') {
      final decodeFunctionSuffix = isOptional ? 'Nullable' : '';
      jsonKeyParams.add('fromJson: decodeData$decodeFunctionSuffix');
    }
    if (field.defaultValue != null) {
      jsonKeyParams.add('defaultValue: ${field.defaultValue}');
    }
    if (jsonKeyParams.isNotEmpty) {
      buffer.writeln('''  @JsonKey(${jsonKeyParams.join(', ')})''');
    }

    final typeSuffix = isOptional ? '?' : '';
    buffer.write('  ${field.type}${typeSuffix} ${field.name};');

    return buffer.toString();
  }

  bool _fieldIsOptional(ClassDefinition class_, FieldDefinition field) {
    // TileSet is not defined as having optional fields, but it can be external
    // so everything can be optional if `source` is set.
    if (class_.name == 'Tileset') {
      return true;
    }
    return (field.description?.contains('optional') ?? false) ||
        (field.description?.toLowerCase().contains('only') ?? false) ||
        (field.description?.toLowerCase().contains(' in case ') ?? false) ||
        (field.description?.toLowerCase().contains(' (for ') ?? false) ||
        (field.description?.toLowerCase().contains('default:') ?? false) ||
        (field.description?.toLowerCase().contains('defaults') ?? false) ||
        (field.description?.toLowerCase().contains('since') ?? false) ||
        (field.description?.toLowerCase().contains('used to mark an object') ??
            false) ||
        (field.name == 'source') ||
        (field.name == 'animation') ||
        (field.name == 'tiledVersion') ||
        (field.name == 'version') ||
        (field.name == 'properties');
  }
}

class Definition {
  final String name;

  Definition(this.name);
}

class EnumDefinition extends Definition {
  final List<EnumValueDefinition> values;

  EnumDefinition(String name, this.values) : super(name);
}

class EnumValueDefinition extends Definition {
  final String jsonValue;

  EnumValueDefinition(String name, this.jsonValue) : super(name);
}

class FieldDefinition extends Definition {
  final String jsonName, type;
  final String? description, defaultValue;
  FieldDefinition(this.jsonName, String name, this.type, this.description,
      this.defaultValue)
      : super(name);
}

class SubClassDefinition extends ClassDefinition {
  late ClassDefinition parent;
  final String type;
  SubClassDefinition(this.type, String name, List<FieldDefinition> fields)
      : super(name, fields);
}
