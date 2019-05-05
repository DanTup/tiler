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
  final String jsonName, type, description, defaultValue;
  FieldDefinition(this.jsonName, String name, this.type, this.description,
      this.defaultValue)
      : super(name);
}

class SubClassDefinition extends ClassDefinition {
  ClassDefinition parent;
  final String type;
  SubClassDefinition(this.type, String name, List<FieldDefinition> fields)
      : super(name, fields);
}
