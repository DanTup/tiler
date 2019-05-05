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
