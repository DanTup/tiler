// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoolProperty _$BoolPropertyFromJson(Map<String, dynamic> json) {
  return $checkedNew('BoolProperty', json, () {
    $checkKeys(json, allowedKeys: const ['name', 'type', 'value']);
    final val = BoolProperty(
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'type',
                (v) => _$enumDecodeNullable(_$PropertyTypeEnumMap, v)) ??
            PropertyType.string,
        $checkedConvert(json, 'value', (v) => v as bool));
    return val;
  });
}

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$PropertyTypeEnumMap = <PropertyType, dynamic>{
  PropertyType.string: 'string',
  PropertyType.int: 'int',
  PropertyType.float: 'float',
  PropertyType.bool: 'bool',
  PropertyType.color: 'color',
  PropertyType.file: 'file'
};

Chunk _$ChunkFromJson(Map<String, dynamic> json) {
  return $checkedNew('Chunk', json, () {
    $checkKeys(json, allowedKeys: const ['data', 'height', 'width', 'x', 'y']);
    final val = Chunk(
        $checkedConvert(json, 'data', (v) => v == null ? null : decodeData(v)),
        $checkedConvert(json, 'height', (v) => v as int),
        $checkedConvert(json, 'width', (v) => v as int),
        $checkedConvert(json, 'x', (v) => v as int),
        $checkedConvert(json, 'y', (v) => v as int));
    return val;
  });
}

ColorProperty _$ColorPropertyFromJson(Map<String, dynamic> json) {
  return $checkedNew('ColorProperty', json, () {
    $checkKeys(json, allowedKeys: const ['name', 'type', 'value']);
    final val = ColorProperty(
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'type',
                (v) => _$enumDecodeNullable(_$PropertyTypeEnumMap, v)) ??
            PropertyType.string,
        $checkedConvert(json, 'value', (v) => v as String));
    return val;
  });
}

FileProperty _$FilePropertyFromJson(Map<String, dynamic> json) {
  return $checkedNew('FileProperty', json, () {
    $checkKeys(json, allowedKeys: const ['name', 'type', 'value']);
    final val = FileProperty(
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'type',
                (v) => _$enumDecodeNullable(_$PropertyTypeEnumMap, v)) ??
            PropertyType.string,
        $checkedConvert(json, 'value', (v) => v as String));
    return val;
  });
}

FloatProperty _$FloatPropertyFromJson(Map<String, dynamic> json) {
  return $checkedNew('FloatProperty', json, () {
    $checkKeys(json, allowedKeys: const ['name', 'type', 'value']);
    final val = FloatProperty(
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'type',
                (v) => _$enumDecodeNullable(_$PropertyTypeEnumMap, v)) ??
            PropertyType.string,
        $checkedConvert(json, 'value', (v) => (v as num)?.toDouble()));
    return val;
  });
}

Frame _$FrameFromJson(Map<String, dynamic> json) {
  return $checkedNew('Frame', json, () {
    $checkKeys(json, allowedKeys: const ['duration', 'tileid']);
    final val = Frame($checkedConvert(json, 'duration', (v) => v as int),
        $checkedConvert(json, 'tileid', (v) => v as int));
    return val;
  }, fieldKeyMap: const {'tileId': 'tileid'});
}

GroupLayer _$GroupLayerFromJson(Map<String, dynamic> json) {
  return $checkedNew('GroupLayer', json, () {
    $checkKeys(json, allowedKeys: const [
      'height',
      'id',
      'visible',
      'name',
      'offsetx',
      'offsety',
      'opacity',
      'properties',
      'startx',
      'starty',
      'type',
      'width',
      'x',
      'y',
      'layers'
    ]);
    final val = GroupLayer(
        $checkedConvert(json, 'height', (v) => v as int),
        $checkedConvert(json, 'id', (v) => v as int),
        $checkedConvert(json, 'visible', (v) => v as bool),
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'offsetx', (v) => (v as num)?.toDouble()) ?? 0,
        $checkedConvert(json, 'offsety', (v) => (v as num)?.toDouble()) ?? 0,
        $checkedConvert(json, 'opacity', (v) => (v as num)?.toDouble()),
        $checkedConvert(
            json,
            'properties',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Property.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'startx', (v) => v as int),
        $checkedConvert(json, 'starty', (v) => v as int),
        $checkedConvert(
            json, 'type', (v) => _$enumDecodeNullable(_$LayerTypeEnumMap, v)),
        $checkedConvert(json, 'width', (v) => v as int),
        $checkedConvert(json, 'x', (v) => v as int),
        $checkedConvert(json, 'y', (v) => v as int),
        $checkedConvert(
            json,
            'layers',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Layer.fromJson(e as Map<String, dynamic>))
                ?.toList()));
    return val;
  }, fieldKeyMap: const {
    'isVisible': 'visible',
    'offsetX': 'offsetx',
    'offsetY': 'offsety',
    'startX': 'startx',
    'startY': 'starty'
  });
}

const _$LayerTypeEnumMap = <LayerType, dynamic>{
  LayerType.tileLayer: 'tilelayer',
  LayerType.objectGroup: 'objectgroup',
  LayerType.imageLayer: 'imagelayer',
  LayerType.group: 'group'
};

ImageLayer _$ImageLayerFromJson(Map<String, dynamic> json) {
  return $checkedNew('ImageLayer', json, () {
    $checkKeys(json, allowedKeys: const [
      'height',
      'id',
      'visible',
      'name',
      'offsetx',
      'offsety',
      'opacity',
      'properties',
      'startx',
      'starty',
      'type',
      'width',
      'x',
      'y',
      'image',
      'transparentcolor'
    ]);
    final val = ImageLayer(
        $checkedConvert(json, 'height', (v) => v as int),
        $checkedConvert(json, 'id', (v) => v as int),
        $checkedConvert(json, 'visible', (v) => v as bool),
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'offsetx', (v) => (v as num)?.toDouble()) ?? 0,
        $checkedConvert(json, 'offsety', (v) => (v as num)?.toDouble()) ?? 0,
        $checkedConvert(json, 'opacity', (v) => (v as num)?.toDouble()),
        $checkedConvert(
            json,
            'properties',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Property.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'startx', (v) => v as int),
        $checkedConvert(json, 'starty', (v) => v as int),
        $checkedConvert(
            json, 'type', (v) => _$enumDecodeNullable(_$LayerTypeEnumMap, v)),
        $checkedConvert(json, 'width', (v) => v as int),
        $checkedConvert(json, 'x', (v) => v as int),
        $checkedConvert(json, 'y', (v) => v as int),
        $checkedConvert(json, 'image', (v) => v as String),
        $checkedConvert(json, 'transparentcolor', (v) => v as String));
    return val;
  }, fieldKeyMap: const {
    'isVisible': 'visible',
    'offsetX': 'offsetx',
    'offsetY': 'offsety',
    'startX': 'startx',
    'startY': 'starty',
    'transparentColor': 'transparentcolor'
  });
}

IntProperty _$IntPropertyFromJson(Map<String, dynamic> json) {
  return $checkedNew('IntProperty', json, () {
    $checkKeys(json, allowedKeys: const ['name', 'type', 'value']);
    final val = IntProperty(
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'type',
                (v) => _$enumDecodeNullable(_$PropertyTypeEnumMap, v)) ??
            PropertyType.string,
        $checkedConvert(json, 'value', (v) => v as int));
    return val;
  });
}

MapObject _$MapObjectFromJson(Map<String, dynamic> json) {
  return $checkedNew('MapObject', json, () {
    $checkKeys(json, allowedKeys: const [
      'gid',
      'height',
      'id',
      'ellipse',
      'point',
      'visible',
      'name',
      'polygon',
      'polyline',
      'properties',
      'rotation',
      'template',
      'text',
      'type',
      'width',
      'x',
      'y'
    ]);
    final val = MapObject(
        $checkedConvert(json, 'gid', (v) => v as int),
        $checkedConvert(json, 'height', (v) => (v as num)?.toDouble()),
        $checkedConvert(json, 'id', (v) => v as int),
        $checkedConvert(json, 'ellipse', (v) => v as bool),
        $checkedConvert(json, 'point', (v) => v as bool),
        $checkedConvert(json, 'visible', (v) => v as bool),
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(
            json,
            'polygon',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Point.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(
            json,
            'polyline',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Point.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(
            json,
            'properties',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Property.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'rotation', (v) => (v as num)?.toDouble()),
        $checkedConvert(json, 'template', (v) => v as String),
        $checkedConvert(
            json,
            'text',
            (v) => v == null
                ? null
                : ObjectText.fromJson(v as Map<String, dynamic>)),
        $checkedConvert(json, 'type', (v) => v as String),
        $checkedConvert(json, 'width', (v) => (v as num)?.toDouble()),
        $checkedConvert(json, 'x', (v) => (v as num)?.toDouble()),
        $checkedConvert(json, 'y', (v) => (v as num)?.toDouble()));
    return val;
  }, fieldKeyMap: const {
    'isEllipse': 'ellipse',
    'isPoint': 'point',
    'isVisible': 'visible'
  });
}

ObjectGroupLayer _$ObjectGroupLayerFromJson(Map<String, dynamic> json) {
  return $checkedNew('ObjectGroupLayer', json, () {
    $checkKeys(json, allowedKeys: const [
      'height',
      'id',
      'visible',
      'name',
      'offsetx',
      'offsety',
      'opacity',
      'properties',
      'startx',
      'starty',
      'type',
      'width',
      'x',
      'y',
      'draworder',
      'objects'
    ]);
    final val = ObjectGroupLayer(
        $checkedConvert(json, 'height', (v) => v as int),
        $checkedConvert(json, 'id', (v) => v as int),
        $checkedConvert(json, 'visible', (v) => v as bool),
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'offsetx', (v) => (v as num)?.toDouble()) ?? 0,
        $checkedConvert(json, 'offsety', (v) => (v as num)?.toDouble()) ?? 0,
        $checkedConvert(json, 'opacity', (v) => (v as num)?.toDouble()),
        $checkedConvert(
            json,
            'properties',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Property.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'startx', (v) => v as int),
        $checkedConvert(json, 'starty', (v) => v as int),
        $checkedConvert(
            json, 'type', (v) => _$enumDecodeNullable(_$LayerTypeEnumMap, v)),
        $checkedConvert(json, 'width', (v) => v as int),
        $checkedConvert(json, 'x', (v) => v as int),
        $checkedConvert(json, 'y', (v) => v as int),
        $checkedConvert(json, 'draworder',
                (v) => _$enumDecodeNullable(_$LayerDrawOrderEnumMap, v)) ??
            LayerDrawOrder.topDown,
        $checkedConvert(
            json,
            'objects',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : MapObject.fromJson(e as Map<String, dynamic>))
                ?.toList()));
    return val;
  }, fieldKeyMap: const {
    'isVisible': 'visible',
    'offsetX': 'offsetx',
    'offsetY': 'offsety',
    'startX': 'startx',
    'startY': 'starty',
    'drawOrder': 'draworder'
  });
}

const _$LayerDrawOrderEnumMap = <LayerDrawOrder, dynamic>{
  LayerDrawOrder.topDown: 'topdown',
  LayerDrawOrder.indexOrder: 'index'
};

ObjectTemplate _$ObjectTemplateFromJson(Map<String, dynamic> json) {
  return $checkedNew('ObjectTemplate', json, () {
    $checkKeys(json, allowedKeys: const ['object', 'tileset', 'type']);
    final val = ObjectTemplate(
        $checkedConvert(
            json,
            'object',
            (v) => v == null
                ? null
                : MapObject.fromJson(v as Map<String, dynamic>)),
        $checkedConvert(
            json,
            'tileset',
            (v) =>
                v == null ? null : Tileset.fromJson(v as Map<String, dynamic>)),
        $checkedConvert(json, 'type', (v) => v as String));
    return val;
  }, fieldKeyMap: const {'mapObject': 'object'});
}

ObjectText _$ObjectTextFromJson(Map<String, dynamic> json) {
  return $checkedNew('ObjectText', json, () {
    $checkKeys(json, allowedKeys: const [
      'color',
      'fontfamily',
      'halign',
      'bold',
      'italic',
      'kerning',
      'strikeout',
      'underline',
      'wrap',
      'pixelsize',
      'text',
      'valign'
    ]);
    final val = ObjectText(
        $checkedConvert(json, 'color', (v) => v as String),
        $checkedConvert(json, 'fontfamily', (v) => v as String) ?? 'sans-serif',
        $checkedConvert(
                json,
                'halign',
                (v) => _$enumDecodeNullable(
                    _$ObjectTextHorizontalAlignEnumMap, v)) ??
            ObjectTextHorizontalAlign.left,
        $checkedConvert(json, 'bold', (v) => v as bool) ?? false,
        $checkedConvert(json, 'italic', (v) => v as bool) ?? false,
        $checkedConvert(json, 'kerning', (v) => v as bool) ?? true,
        $checkedConvert(json, 'strikeout', (v) => v as bool) ?? false,
        $checkedConvert(json, 'underline', (v) => v as bool) ?? false,
        $checkedConvert(json, 'wrap', (v) => v as bool) ?? false,
        $checkedConvert(json, 'pixelsize', (v) => v as int) ?? 16,
        $checkedConvert(json, 'text', (v) => v as String),
        $checkedConvert(
                json,
                'valign',
                (v) => _$enumDecodeNullable(
                    _$ObjectTextVerticalAlignEnumMap, v)) ??
            ObjectTextVerticalAlign.top);
    return val;
  }, fieldKeyMap: const {
    'horizontalAlign': 'halign',
    'isBold': 'bold',
    'isItalic': 'italic',
    'isKerning': 'kerning',
    'isStrikeout': 'strikeout',
    'isUnderline': 'underline',
    'isWrap': 'wrap',
    'verticalAlign': 'valign'
  });
}

const _$ObjectTextHorizontalAlignEnumMap = <ObjectTextHorizontalAlign, dynamic>{
  ObjectTextHorizontalAlign.center: 'center',
  ObjectTextHorizontalAlign.right: 'right',
  ObjectTextHorizontalAlign.justify: 'justify',
  ObjectTextHorizontalAlign.left: 'left'
};

const _$ObjectTextVerticalAlignEnumMap = <ObjectTextVerticalAlign, dynamic>{
  ObjectTextVerticalAlign.center: 'center',
  ObjectTextVerticalAlign.bottom: 'bottom',
  ObjectTextVerticalAlign.top: 'top'
};

Point _$PointFromJson(Map<String, dynamic> json) {
  return $checkedNew('Point', json, () {
    $checkKeys(json, allowedKeys: const ['x', 'y']);
    final val = Point($checkedConvert(json, 'x', (v) => (v as num)?.toDouble()),
        $checkedConvert(json, 'y', (v) => (v as num)?.toDouble()));
    return val;
  });
}

StringProperty _$StringPropertyFromJson(Map<String, dynamic> json) {
  return $checkedNew('StringProperty', json, () {
    $checkKeys(json, allowedKeys: const ['name', 'type', 'value']);
    final val = StringProperty(
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'type',
                (v) => _$enumDecodeNullable(_$PropertyTypeEnumMap, v)) ??
            PropertyType.string,
        $checkedConvert(json, 'value', (v) => v as String));
    return val;
  });
}

Terrain _$TerrainFromJson(Map<String, dynamic> json) {
  return $checkedNew('Terrain', json, () {
    $checkKeys(json, allowedKeys: const ['name', 'properties', 'tile']);
    final val = Terrain(
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(
            json,
            'properties',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Property.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'tile', (v) => v as int));
    return val;
  });
}

Tile _$TileFromJson(Map<String, dynamic> json) {
  return $checkedNew('Tile', json, () {
    $checkKeys(json, allowedKeys: const [
      'animation',
      'id',
      'image',
      'imageheight',
      'imagewidth',
      'objectgroup',
      'probability',
      'properties',
      'terrain',
      'type'
    ]);
    final val = Tile(
        $checkedConvert(
            json,
            'animation',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Frame.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'id', (v) => v as int),
        $checkedConvert(json, 'image', (v) => v as String),
        $checkedConvert(json, 'imageheight', (v) => v as int),
        $checkedConvert(json, 'imagewidth', (v) => v as int),
        $checkedConvert(
            json,
            'objectgroup',
            (v) =>
                v == null ? null : Layer.fromJson(v as Map<String, dynamic>)),
        $checkedConvert(json, 'probability', (v) => (v as num)?.toDouble()),
        $checkedConvert(
            json,
            'properties',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Property.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'terrain',
            (v) => (v as List)?.map((e) => e as int)?.toList()),
        $checkedConvert(json, 'type', (v) => v as String));
    return val;
  }, fieldKeyMap: const {
    'imageHeight': 'imageheight',
    'imageWidth': 'imagewidth',
    'objectGroup': 'objectgroup'
  });
}

TileLayer _$TileLayerFromJson(Map<String, dynamic> json) {
  return $checkedNew('TileLayer', json, () {
    $checkKeys(json, allowedKeys: const [
      'height',
      'id',
      'visible',
      'name',
      'offsetx',
      'offsety',
      'opacity',
      'properties',
      'startx',
      'starty',
      'type',
      'width',
      'x',
      'y',
      'chunks',
      'compression',
      'data',
      'encoding'
    ]);
    final val = TileLayer(
        $checkedConvert(json, 'height', (v) => v as int),
        $checkedConvert(json, 'id', (v) => v as int),
        $checkedConvert(json, 'visible', (v) => v as bool),
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'offsetx', (v) => (v as num)?.toDouble()) ?? 0,
        $checkedConvert(json, 'offsety', (v) => (v as num)?.toDouble()) ?? 0,
        $checkedConvert(json, 'opacity', (v) => (v as num)?.toDouble()),
        $checkedConvert(
            json,
            'properties',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Property.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'startx', (v) => v as int),
        $checkedConvert(json, 'starty', (v) => v as int),
        $checkedConvert(
            json, 'type', (v) => _$enumDecodeNullable(_$LayerTypeEnumMap, v)),
        $checkedConvert(json, 'width', (v) => v as int),
        $checkedConvert(json, 'x', (v) => v as int),
        $checkedConvert(json, 'y', (v) => v as int),
        $checkedConvert(
            json,
            'chunks',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Chunk.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'compression',
                (v) => _$enumDecodeNullable(_$LayerCompressionEnumMap, v)) ??
            LayerCompression.none,
        $checkedConvert(json, 'data', (v) => v == null ? null : decodeData(v)),
        $checkedConvert(json, 'encoding',
                (v) => _$enumDecodeNullable(_$LayerEncodingEnumMap, v)) ??
            LayerEncoding.csv);
    return val;
  }, fieldKeyMap: const {
    'isVisible': 'visible',
    'offsetX': 'offsetx',
    'offsetY': 'offsety',
    'startX': 'startx',
    'startY': 'starty'
  });
}

const _$LayerCompressionEnumMap = <LayerCompression, dynamic>{
  LayerCompression.zlib: 'zlib',
  LayerCompression.gzip: 'gzip',
  LayerCompression.none: 'none'
};

const _$LayerEncodingEnumMap = <LayerEncoding, dynamic>{
  LayerEncoding.csv: 'csv',
  LayerEncoding.base64: 'base64'
};

TileMap _$TileMapFromJson(Map<String, dynamic> json) {
  return $checkedNew('TileMap', json, () {
    $checkKeys(json, allowedKeys: const [
      'backgroundcolor',
      'height',
      'hexsidelength',
      'infinite',
      'layers',
      'nextlayerid',
      'nextobjectid',
      'orientation',
      'properties',
      'renderorder',
      'staggeraxis',
      'staggerindex',
      'tileheight',
      'tilewidth',
      'tiledversion',
      'tilesets',
      'type',
      'version',
      'width'
    ]);
    final val = TileMap(
        $checkedConvert(json, 'backgroundcolor', (v) => v as String),
        $checkedConvert(json, 'height', (v) => v as int),
        $checkedConvert(json, 'hexsidelength', (v) => v as int),
        $checkedConvert(json, 'infinite', (v) => v as bool),
        $checkedConvert(
            json,
            'layers',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Layer.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'nextlayerid', (v) => v as int),
        $checkedConvert(json, 'nextobjectid', (v) => v as int),
        $checkedConvert(json, 'orientation',
            (v) => _$enumDecodeNullable(_$TileMapOrientationEnumMap, v)),
        $checkedConvert(
            json,
            'properties',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Property.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'renderorder',
            (v) => _$enumDecodeNullable(_$TileMapRenderOrderEnumMap, v)),
        $checkedConvert(json, 'staggeraxis',
            (v) => _$enumDecodeNullable(_$TileMapStaggerAxisEnumMap, v)),
        $checkedConvert(json, 'staggerindex',
            (v) => _$enumDecodeNullable(_$TileMapStaggerIndexEnumMap, v)),
        $checkedConvert(json, 'tileheight', (v) => v as int),
        $checkedConvert(json, 'tilewidth', (v) => v as int),
        $checkedConvert(json, 'tiledversion', (v) => v as String),
        $checkedConvert(
            json,
            'tilesets',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Tileset.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'type', (v) => v as String),
        $checkedConvert(json, 'version', (v) => v as num),
        $checkedConvert(json, 'width', (v) => v as int));
    return val;
  }, fieldKeyMap: const {
    'backgroundColor': 'backgroundcolor',
    'hexSideLength': 'hexsidelength',
    'isInfinite': 'infinite',
    'nextLayerId': 'nextlayerid',
    'nextObjectId': 'nextobjectid',
    'renderOrder': 'renderorder',
    'staggerAxis': 'staggeraxis',
    'staggerIndex': 'staggerindex',
    'tileHeight': 'tileheight',
    'tileWidth': 'tilewidth',
    'tiledVersion': 'tiledversion'
  });
}

const _$TileMapOrientationEnumMap = <TileMapOrientation, dynamic>{
  TileMapOrientation.orthogonal: 'orthogonal',
  TileMapOrientation.isometric: 'isometric',
  TileMapOrientation.staggered: 'staggered',
  TileMapOrientation.hexagonal: 'hexagonal'
};

const _$TileMapRenderOrderEnumMap = <TileMapRenderOrder, dynamic>{
  TileMapRenderOrder.rightDown: 'right-down',
  TileMapRenderOrder.rightUp: 'right-up',
  TileMapRenderOrder.leftDown: 'left-down',
  TileMapRenderOrder.leftUp: 'left-up'
};

const _$TileMapStaggerAxisEnumMap = <TileMapStaggerAxis, dynamic>{
  TileMapStaggerAxis.x: 'x',
  TileMapStaggerAxis.y: 'y'
};

const _$TileMapStaggerIndexEnumMap = <TileMapStaggerIndex, dynamic>{
  TileMapStaggerIndex.odd: 'odd',
  TileMapStaggerIndex.even: 'even'
};

TileOffset _$TileOffsetFromJson(Map<String, dynamic> json) {
  return $checkedNew('TileOffset', json, () {
    $checkKeys(json, allowedKeys: const ['x', 'y']);
    final val = TileOffset($checkedConvert(json, 'x', (v) => v as int),
        $checkedConvert(json, 'y', (v) => v as int));
    return val;
  });
}

TileSetGrid _$TileSetGridFromJson(Map<String, dynamic> json) {
  return $checkedNew('TileSetGrid', json, () {
    $checkKeys(json, allowedKeys: const ['height', 'orientation', 'width']);
    final val = TileSetGrid(
        $checkedConvert(json, 'height', (v) => v as int),
        $checkedConvert(
                json,
                'orientation',
                (v) =>
                    _$enumDecodeNullable(_$TileSetGridOrientationEnumMap, v)) ??
            TileSetGridOrientation.orthogonal,
        $checkedConvert(json, 'width', (v) => v as int));
    return val;
  });
}

const _$TileSetGridOrientationEnumMap = <TileSetGridOrientation, dynamic>{
  TileSetGridOrientation.orthogonal: 'orthogonal',
  TileSetGridOrientation.isometric: 'isometric'
};

Tileset _$TilesetFromJson(Map<String, dynamic> json) {
  return $checkedNew('Tileset', json, () {
    $checkKeys(json, allowedKeys: const [
      'backgroundcolor',
      'columns',
      'firstgid',
      'grid',
      'image',
      'imageheight',
      'imagewidth',
      'margin',
      'name',
      'properties',
      'source',
      'spacing',
      'terrains',
      'tilecount',
      'tileheight',
      'tileoffset',
      'tilewidth',
      'tiledversion',
      'tiles',
      'transparentcolor',
      'type',
      'version',
      'wangsets'
    ]);
    final val = Tileset(
        $checkedConvert(json, 'backgroundcolor', (v) => v as String),
        $checkedConvert(json, 'columns', (v) => v as int),
        $checkedConvert(json, 'firstgid', (v) => v as int),
        $checkedConvert(
            json,
            'grid',
            (v) => v == null
                ? null
                : TileSetGrid.fromJson(v as Map<String, dynamic>)),
        $checkedConvert(json, 'image', (v) => v as String),
        $checkedConvert(json, 'imageheight', (v) => v as int),
        $checkedConvert(json, 'imagewidth', (v) => v as int),
        $checkedConvert(json, 'margin', (v) => v as int),
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(
            json,
            'properties',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Property.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'source', (v) => v as String),
        $checkedConvert(json, 'spacing', (v) => v as int),
        $checkedConvert(
            json,
            'terrains',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Terrain.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'tilecount', (v) => v as int),
        $checkedConvert(json, 'tileheight', (v) => v as int),
        $checkedConvert(
            json,
            'tileoffset',
            (v) => v == null
                ? null
                : TileOffset.fromJson(v as Map<String, dynamic>)),
        $checkedConvert(json, 'tilewidth', (v) => v as int),
        $checkedConvert(json, 'tiledversion', (v) => v as String),
        $checkedConvert(
            json,
            'tiles',
            (v) => (v as List)
                ?.map((e) =>
                    e == null ? null : Tile.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'transparentcolor', (v) => v as String),
        $checkedConvert(json, 'type', (v) => v as String),
        $checkedConvert(json, 'version', (v) => v as num),
        $checkedConvert(
            json,
            'wangsets',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : WangSet.fromJson(e as Map<String, dynamic>))
                ?.toList()));
    return val;
  }, fieldKeyMap: const {
    'backgroundColor': 'backgroundcolor',
    'firstGid': 'firstgid',
    'imageHeight': 'imageheight',
    'imageWidth': 'imagewidth',
    'tileCount': 'tilecount',
    'tileHeight': 'tileheight',
    'tileOffset': 'tileoffset',
    'tileWidth': 'tilewidth',
    'tiledVersion': 'tiledversion',
    'transparentColor': 'transparentcolor',
    'wangSets': 'wangsets'
  });
}

WangColor _$WangColorFromJson(Map<String, dynamic> json) {
  return $checkedNew('WangColor', json, () {
    $checkKeys(json,
        allowedKeys: const ['color', 'name', 'probability', 'tile']);
    final val = WangColor(
        $checkedConvert(json, 'color', (v) => v as String),
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'probability', (v) => (v as num)?.toDouble()),
        $checkedConvert(json, 'tile', (v) => v as int));
    return val;
  });
}

WangSet _$WangSetFromJson(Map<String, dynamic> json) {
  return $checkedNew('WangSet', json, () {
    $checkKeys(json, allowedKeys: const [
      'cornercolors',
      'edgecolors',
      'name',
      'properties',
      'tile',
      'wangtiles'
    ]);
    final val = WangSet(
        $checkedConvert(
            json,
            'cornercolors',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : WangColor.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(
            json,
            'edgecolors',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : WangColor.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(
            json,
            'properties',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : Property.fromJson(e as Map<String, dynamic>))
                ?.toList()),
        $checkedConvert(json, 'tile', (v) => v as int),
        $checkedConvert(
            json,
            'wangtiles',
            (v) => (v as List)
                ?.map((e) => e == null
                    ? null
                    : WangTile.fromJson(e as Map<String, dynamic>))
                ?.toList()));
    return val;
  }, fieldKeyMap: const {
    'cornerColors': 'cornercolors',
    'edgeColors': 'edgecolors',
    'wangTiles': 'wangtiles'
  });
}

WangTile _$WangTileFromJson(Map<String, dynamic> json) {
  return $checkedNew('WangTile', json, () {
    $checkKeys(json,
        allowedKeys: const ['dflip', 'hflip', 'vflip', 'tileid', 'wangid']);
    final val = WangTile(
        $checkedConvert(json, 'dflip', (v) => v as bool) ?? false,
        $checkedConvert(json, 'hflip', (v) => v as bool) ?? false,
        $checkedConvert(json, 'vflip', (v) => v as bool) ?? false,
        $checkedConvert(json, 'tileid', (v) => v as int),
        $checkedConvert(json, 'wangid',
            (v) => (v as List)?.map((e) => e as int)?.toList()));
    return val;
  }, fieldKeyMap: const {
    'isFlippedDiagonally': 'dflip',
    'isFlippedHorizontally': 'hflip',
    'isFlippedVertically': 'vflip',
    'tileId': 'tileid',
    'wangId': 'wangid'
  });
}
