// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoolProperty _$BoolPropertyFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BoolProperty',
      json,
      ($checkedConvert) {
        final val = BoolProperty(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('propertytype', (v) => v as String?),
          $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$PropertyTypeEnumMap, v) ??
                  PropertyType.string),
          $checkedConvert('value', (v) => v as bool),
        );
        return val;
      },
    );

const _$PropertyTypeEnumMap = {
  PropertyType.string: 'string',
  PropertyType.int: 'int',
  PropertyType.float: 'float',
  PropertyType.bool: 'bool',
  PropertyType.color: 'color',
  PropertyType.file: 'file',
  PropertyType.mapObject: 'object',
  PropertyType.class_: 'class',
};

Chunk _$ChunkFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Chunk',
      json,
      ($checkedConvert) {
        final val = Chunk(
          $checkedConvert('data', (v) => decodeData(v)),
          $checkedConvert('height', (v) => v as int),
          $checkedConvert('width', (v) => v as int),
          $checkedConvert('x', (v) => v as int),
          $checkedConvert('y', (v) => v as int),
        );
        return val;
      },
    );

ClassProperty _$ClassPropertyFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ClassProperty',
      json,
      ($checkedConvert) {
        final val = ClassProperty(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('propertytype', (v) => v as String?),
          $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$PropertyTypeEnumMap, v) ??
                  PropertyType.string),
          $checkedConvert('value', (v) => v),
        );
        return val;
      },
    );

ColorProperty _$ColorPropertyFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ColorProperty',
      json,
      ($checkedConvert) {
        final val = ColorProperty(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('propertytype', (v) => v as String?),
          $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$PropertyTypeEnumMap, v) ??
                  PropertyType.string),
          $checkedConvert('value', (v) => v as String),
        );
        return val;
      },
    );

CornerWangSet _$CornerWangSetFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CornerWangSet',
      json,
      ($checkedConvert) {
        final val = CornerWangSet(
          $checkedConvert('class', (v) => v as String?),
          $checkedConvert(
              'colors',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => WangColor.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('name', (v) => v as String),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('tile', (v) => v as int),
          $checkedConvert(
              'type', (v) => $enumDecodeNullable(_$WangSetTypeEnumMap, v)),
          $checkedConvert(
              'wangtiles',
              (v) => (v as List<dynamic>)
                  .map((e) => WangTile.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'class_': 'class', 'wangTiles': 'wangtiles'},
    );

const _$WangSetTypeEnumMap = {
  WangSetType.corner: 'corner',
  WangSetType.edge: 'edge',
  WangSetType.mixed: 'mixed',
};

EdgeWangSet _$EdgeWangSetFromJson(Map<String, dynamic> json) => $checkedCreate(
      'EdgeWangSet',
      json,
      ($checkedConvert) {
        final val = EdgeWangSet(
          $checkedConvert('class', (v) => v as String?),
          $checkedConvert(
              'colors',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => WangColor.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('name', (v) => v as String),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('tile', (v) => v as int),
          $checkedConvert(
              'type', (v) => $enumDecodeNullable(_$WangSetTypeEnumMap, v)),
          $checkedConvert(
              'wangtiles',
              (v) => (v as List<dynamic>)
                  .map((e) => WangTile.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'class_': 'class', 'wangTiles': 'wangtiles'},
    );

FileProperty _$FilePropertyFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FileProperty',
      json,
      ($checkedConvert) {
        final val = FileProperty(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('propertytype', (v) => v as String?),
          $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$PropertyTypeEnumMap, v) ??
                  PropertyType.string),
          $checkedConvert('value', (v) => v as String),
        );
        return val;
      },
    );

FloatProperty _$FloatPropertyFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FloatProperty',
      json,
      ($checkedConvert) {
        final val = FloatProperty(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('propertytype', (v) => v as String?),
          $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$PropertyTypeEnumMap, v) ??
                  PropertyType.string),
          $checkedConvert('value', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Frame _$FrameFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Frame',
      json,
      ($checkedConvert) {
        final val = Frame(
          $checkedConvert('duration', (v) => v as int),
          $checkedConvert('tileid', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {'tileId': 'tileid'},
    );

GroupLayer _$GroupLayerFromJson(Map<String, dynamic> json) => $checkedCreate(
      'GroupLayer',
      json,
      ($checkedConvert) {
        final val = GroupLayer(
          $checkedConvert('class', (v) => v as String?),
          $checkedConvert('id', (v) => v as int),
          $checkedConvert('locked', (v) => v as bool? ?? false),
          $checkedConvert('visible', (v) => v as bool),
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('offsetx', (v) => (v as num?)?.toDouble() ?? 0),
          $checkedConvert('offsety', (v) => (v as num?)?.toDouble() ?? 0),
          $checkedConvert('opacity', (v) => (v as num).toDouble()),
          $checkedConvert('parallaxx', (v) => (v as num?)?.toDouble() ?? 1),
          $checkedConvert('parallaxy', (v) => (v as num?)?.toDouble() ?? 1),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('startx', (v) => v as int?),
          $checkedConvert('starty', (v) => v as int?),
          $checkedConvert('tintcolor', (v) => v as String?),
          $checkedConvert('type', (v) => $enumDecode(_$LayerTypeEnumMap, v)),
          $checkedConvert('x', (v) => v as int),
          $checkedConvert('y', (v) => v as int),
          $checkedConvert(
              'layers',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Layer.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'class_': 'class',
        'isLocked': 'locked',
        'isVisible': 'visible',
        'offsetX': 'offsetx',
        'offsetY': 'offsety',
        'startX': 'startx',
        'startY': 'starty'
      },
    );

const _$LayerTypeEnumMap = {
  LayerType.tileLayer: 'tilelayer',
  LayerType.objectGroup: 'objectgroup',
  LayerType.imageLayer: 'imagelayer',
  LayerType.group: 'group',
};

ImageLayer _$ImageLayerFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ImageLayer',
      json,
      ($checkedConvert) {
        final val = ImageLayer(
          $checkedConvert('class', (v) => v as String?),
          $checkedConvert('id', (v) => v as int),
          $checkedConvert('locked', (v) => v as bool? ?? false),
          $checkedConvert('visible', (v) => v as bool),
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('offsetx', (v) => (v as num?)?.toDouble() ?? 0),
          $checkedConvert('offsety', (v) => (v as num?)?.toDouble() ?? 0),
          $checkedConvert('opacity', (v) => (v as num).toDouble()),
          $checkedConvert('parallaxx', (v) => (v as num?)?.toDouble() ?? 1),
          $checkedConvert('parallaxy', (v) => (v as num?)?.toDouble() ?? 1),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('startx', (v) => v as int?),
          $checkedConvert('starty', (v) => v as int?),
          $checkedConvert('tintcolor', (v) => v as String?),
          $checkedConvert('type', (v) => $enumDecode(_$LayerTypeEnumMap, v)),
          $checkedConvert('x', (v) => v as int),
          $checkedConvert('y', (v) => v as int),
          $checkedConvert('image', (v) => v as String?),
          $checkedConvert('repeatx', (v) => v as bool?),
          $checkedConvert('repeaty', (v) => v as bool?),
          $checkedConvert('transparentcolor', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'class_': 'class',
        'isLocked': 'locked',
        'isVisible': 'visible',
        'offsetX': 'offsetx',
        'offsetY': 'offsety',
        'startX': 'startx',
        'startY': 'starty',
        'isRepeatx': 'repeatx',
        'isRepeaty': 'repeaty',
        'transparentColor': 'transparentcolor'
      },
    );

IntProperty _$IntPropertyFromJson(Map<String, dynamic> json) => $checkedCreate(
      'IntProperty',
      json,
      ($checkedConvert) {
        final val = IntProperty(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('propertytype', (v) => v as String?),
          $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$PropertyTypeEnumMap, v) ??
                  PropertyType.string),
          $checkedConvert('value', (v) => v as int),
        );
        return val;
      },
    );

MapObject _$MapObjectFromJson(Map<String, dynamic> json) => $checkedCreate(
      'MapObject',
      json,
      ($checkedConvert) {
        final val = MapObject(
          $checkedConvert('class', (v) => v as String?),
          $checkedConvert('gid', (v) => v as int?),
          $checkedConvert('height', (v) => (v as num).toDouble()),
          $checkedConvert('id', (v) => v as int),
          $checkedConvert('ellipse', (v) => v as bool?),
          $checkedConvert('point', (v) => v as bool?),
          $checkedConvert('visible', (v) => v as bool),
          $checkedConvert('name', (v) => v as String),
          $checkedConvert(
              'polygon',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Point.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert(
              'polyline',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Point.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('rotation', (v) => (v as num).toDouble()),
          $checkedConvert('template', (v) => v as String?),
          $checkedConvert(
              'text',
              (v) => v == null
                  ? null
                  : ObjectText.fromJson(v as Map<String, dynamic>)),
          $checkedConvert('width', (v) => (v as num).toDouble()),
          $checkedConvert('x', (v) => (v as num).toDouble()),
          $checkedConvert('y', (v) => (v as num).toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {
        'class_': 'class',
        'isEllipse': 'ellipse',
        'isPoint': 'point',
        'isVisible': 'visible'
      },
    );

MixedWangSet _$MixedWangSetFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'MixedWangSet',
      json,
      ($checkedConvert) {
        final val = MixedWangSet(
          $checkedConvert('class', (v) => v as String?),
          $checkedConvert(
              'colors',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => WangColor.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('name', (v) => v as String),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('tile', (v) => v as int),
          $checkedConvert(
              'type', (v) => $enumDecodeNullable(_$WangSetTypeEnumMap, v)),
          $checkedConvert(
              'wangtiles',
              (v) => (v as List<dynamic>)
                  .map((e) => WangTile.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'class_': 'class', 'wangTiles': 'wangtiles'},
    );

ObjectGroupLayer _$ObjectGroupLayerFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ObjectGroupLayer',
      json,
      ($checkedConvert) {
        final val = ObjectGroupLayer(
          $checkedConvert('class', (v) => v as String?),
          $checkedConvert('id', (v) => v as int),
          $checkedConvert('locked', (v) => v as bool? ?? false),
          $checkedConvert('visible', (v) => v as bool),
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('offsetx', (v) => (v as num?)?.toDouble() ?? 0),
          $checkedConvert('offsety', (v) => (v as num?)?.toDouble() ?? 0),
          $checkedConvert('opacity', (v) => (v as num).toDouble()),
          $checkedConvert('parallaxx', (v) => (v as num?)?.toDouble() ?? 1),
          $checkedConvert('parallaxy', (v) => (v as num?)?.toDouble() ?? 1),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('startx', (v) => v as int?),
          $checkedConvert('starty', (v) => v as int?),
          $checkedConvert('tintcolor', (v) => v as String?),
          $checkedConvert('type', (v) => $enumDecode(_$LayerTypeEnumMap, v)),
          $checkedConvert('x', (v) => v as int),
          $checkedConvert('y', (v) => v as int),
          $checkedConvert(
              'draworder',
              (v) =>
                  $enumDecodeNullable(_$LayerDrawOrderEnumMap, v) ??
                  LayerDrawOrder.topDown),
          $checkedConvert(
              'objects',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => MapObject.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'class_': 'class',
        'isLocked': 'locked',
        'isVisible': 'visible',
        'offsetX': 'offsetx',
        'offsetY': 'offsety',
        'startX': 'startx',
        'startY': 'starty',
        'drawOrder': 'draworder'
      },
    );

const _$LayerDrawOrderEnumMap = {
  LayerDrawOrder.topDown: 'topdown',
  LayerDrawOrder.indexOrder: 'index',
};

ObjectProperty _$ObjectPropertyFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ObjectProperty',
      json,
      ($checkedConvert) {
        final val = ObjectProperty(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('propertytype', (v) => v as String?),
          $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$PropertyTypeEnumMap, v) ??
                  PropertyType.string),
          $checkedConvert('value', (v) => v),
        );
        return val;
      },
    );

ObjectTemplate _$ObjectTemplateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ObjectTemplate',
      json,
      ($checkedConvert) {
        final val = ObjectTemplate(
          $checkedConvert(
              'object', (v) => MapObject.fromJson(v as Map<String, dynamic>)),
          $checkedConvert(
              'tileset',
              (v) => v == null
                  ? null
                  : Tileset.fromJson(v as Map<String, dynamic>)),
          $checkedConvert('type', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'mapObject': 'object'},
    );

ObjectText _$ObjectTextFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ObjectText',
      json,
      ($checkedConvert) {
        final val = ObjectText(
          $checkedConvert('color', (v) => v as String?),
          $checkedConvert('fontfamily', (v) => v as String? ?? 'sans-serif'),
          $checkedConvert(
              'halign',
              (v) =>
                  $enumDecodeNullable(_$ObjectTextHorizontalAlignEnumMap, v) ??
                  ObjectTextHorizontalAlign.left),
          $checkedConvert('bold', (v) => v as bool? ?? false),
          $checkedConvert('italic', (v) => v as bool? ?? false),
          $checkedConvert('kerning', (v) => v as bool? ?? true),
          $checkedConvert('strikeout', (v) => v as bool? ?? false),
          $checkedConvert('underline', (v) => v as bool? ?? false),
          $checkedConvert('wrap', (v) => v as bool? ?? false),
          $checkedConvert('pixelsize', (v) => v as int? ?? 16),
          $checkedConvert('text', (v) => v as String),
          $checkedConvert(
              'valign',
              (v) =>
                  $enumDecodeNullable(_$ObjectTextVerticalAlignEnumMap, v) ??
                  ObjectTextVerticalAlign.top),
        );
        return val;
      },
      fieldKeyMap: const {
        'horizontalAlign': 'halign',
        'isBold': 'bold',
        'isItalic': 'italic',
        'isKerning': 'kerning',
        'isStrikeout': 'strikeout',
        'isUnderline': 'underline',
        'isWrap': 'wrap',
        'verticalAlign': 'valign'
      },
    );

const _$ObjectTextHorizontalAlignEnumMap = {
  ObjectTextHorizontalAlign.center: 'center',
  ObjectTextHorizontalAlign.right: 'right',
  ObjectTextHorizontalAlign.justify: 'justify',
  ObjectTextHorizontalAlign.left: 'left',
};

const _$ObjectTextVerticalAlignEnumMap = {
  ObjectTextVerticalAlign.center: 'center',
  ObjectTextVerticalAlign.bottom: 'bottom',
  ObjectTextVerticalAlign.top: 'top',
};

Point _$PointFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Point',
      json,
      ($checkedConvert) {
        final val = Point(
          $checkedConvert('x', (v) => (v as num).toDouble()),
          $checkedConvert('y', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

StringProperty _$StringPropertyFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'StringProperty',
      json,
      ($checkedConvert) {
        final val = StringProperty(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('propertytype', (v) => v as String?),
          $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$PropertyTypeEnumMap, v) ??
                  PropertyType.string),
          $checkedConvert('value', (v) => v as String),
        );
        return val;
      },
    );

Terrain _$TerrainFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Terrain',
      json,
      ($checkedConvert) {
        final val = Terrain(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('tile', (v) => v as int),
        );
        return val;
      },
    );

Tile _$TileFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Tile',
      json,
      ($checkedConvert) {
        final val = Tile(
          $checkedConvert(
              'animation',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Frame.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('class', (v) => v as String?),
          $checkedConvert('height', (v) => v as int?),
          $checkedConvert('id', (v) => v as int),
          $checkedConvert('image', (v) => v as String?),
          $checkedConvert('imageheight', (v) => v as int),
          $checkedConvert('imagewidth', (v) => v as int),
          $checkedConvert(
              'objectgroup',
              (v) => v == null
                  ? null
                  : ObjectGroupLayer.fromJson(v as Map<String, dynamic>)),
          $checkedConvert('probability', (v) => (v as num?)?.toDouble()),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('terrain',
              (v) => (v as List<dynamic>?)?.map((e) => e as int).toList()),
          $checkedConvert('width', (v) => v as int?),
          $checkedConvert('x', (v) => v as int? ?? 0),
          $checkedConvert('y', (v) => v as int? ?? 0),
        );
        return val;
      },
      fieldKeyMap: const {
        'class_': 'class',
        'imageHeight': 'imageheight',
        'imageWidth': 'imagewidth',
        'objectGroup': 'objectgroup'
      },
    );

TileLayer _$TileLayerFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TileLayer',
      json,
      ($checkedConvert) {
        final val = TileLayer(
          $checkedConvert('class', (v) => v as String?),
          $checkedConvert('id', (v) => v as int),
          $checkedConvert('locked', (v) => v as bool? ?? false),
          $checkedConvert('visible', (v) => v as bool),
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('offsetx', (v) => (v as num?)?.toDouble() ?? 0),
          $checkedConvert('offsety', (v) => (v as num?)?.toDouble() ?? 0),
          $checkedConvert('opacity', (v) => (v as num).toDouble()),
          $checkedConvert('parallaxx', (v) => (v as num?)?.toDouble() ?? 1),
          $checkedConvert('parallaxy', (v) => (v as num?)?.toDouble() ?? 1),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('startx', (v) => v as int?),
          $checkedConvert('starty', (v) => v as int?),
          $checkedConvert('tintcolor', (v) => v as String?),
          $checkedConvert('type', (v) => $enumDecode(_$LayerTypeEnumMap, v)),
          $checkedConvert('x', (v) => v as int),
          $checkedConvert('y', (v) => v as int),
          $checkedConvert(
              'chunks',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Chunk.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('compression', (v) => v as String? ?? 'empty'),
          $checkedConvert('data', (v) => decodeDataNullable(v)),
          $checkedConvert(
              'encoding',
              (v) =>
                  $enumDecodeNullable(_$LayerEncodingEnumMap, v) ??
                  LayerEncoding.csv),
          $checkedConvert('height', (v) => v as int?),
          $checkedConvert('width', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'class_': 'class',
        'isLocked': 'locked',
        'isVisible': 'visible',
        'offsetX': 'offsetx',
        'offsetY': 'offsety',
        'startX': 'startx',
        'startY': 'starty'
      },
    );

const _$LayerEncodingEnumMap = {
  LayerEncoding.csv: 'csv',
  LayerEncoding.base64: 'base64',
};

TileMap _$TileMapFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TileMap',
      json,
      ($checkedConvert) {
        final val = TileMap(
          $checkedConvert('backgroundcolor', (v) => v as String?),
          $checkedConvert('class', (v) => v as String?),
          $checkedConvert('compressionlevel', (v) => v as int?),
          $checkedConvert('height', (v) => v as int),
          $checkedConvert('hexsidelength', (v) => v as int?),
          $checkedConvert('infinite', (v) => v as bool),
          $checkedConvert(
              'layers',
              (v) => (v as List<dynamic>)
                  .map((e) => Layer.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('nextlayerid', (v) => v as int),
          $checkedConvert('nextobjectid', (v) => v as int),
          $checkedConvert('orientation',
              (v) => $enumDecode(_$TileMapOrientationEnumMap, v)),
          $checkedConvert('parallaxoriginx', (v) => (v as num?)?.toDouble()),
          $checkedConvert('parallaxoriginy', (v) => (v as num?)?.toDouble()),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('renderorder',
              (v) => $enumDecodeNullable(_$TileMapRenderOrderEnumMap, v)),
          $checkedConvert('staggeraxis',
              (v) => $enumDecodeNullable(_$TileMapStaggerAxisEnumMap, v)),
          $checkedConvert('staggerindex',
              (v) => $enumDecodeNullable(_$TileMapStaggerIndexEnumMap, v)),
          $checkedConvert('tileheight', (v) => v as int),
          $checkedConvert('tilewidth', (v) => v as int),
          $checkedConvert('tiledversion', (v) => v as String?),
          $checkedConvert(
              'tilesets',
              (v) => (v as List<dynamic>)
                  .map((e) => Tileset.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('type', (v) => v as String?),
          $checkedConvert('version', (v) => v),
          $checkedConvert('width', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'backgroundColor': 'backgroundcolor',
        'class_': 'class',
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
      },
    );

const _$TileMapOrientationEnumMap = {
  TileMapOrientation.orthogonal: 'orthogonal',
  TileMapOrientation.isometric: 'isometric',
  TileMapOrientation.staggered: 'staggered',
  TileMapOrientation.hexagonal: 'hexagonal',
};

const _$TileMapRenderOrderEnumMap = {
  TileMapRenderOrder.rightDown: 'right-down',
  TileMapRenderOrder.rightUp: 'right-up',
  TileMapRenderOrder.leftDown: 'left-down',
  TileMapRenderOrder.leftUp: 'left-up',
};

const _$TileMapStaggerAxisEnumMap = {
  TileMapStaggerAxis.x: 'x',
  TileMapStaggerAxis.y: 'y',
};

const _$TileMapStaggerIndexEnumMap = {
  TileMapStaggerIndex.odd: 'odd',
  TileMapStaggerIndex.even: 'even',
};

TileOffset _$TileOffsetFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TileOffset',
      json,
      ($checkedConvert) {
        final val = TileOffset(
          $checkedConvert('x', (v) => v as int),
          $checkedConvert('y', (v) => v as int),
        );
        return val;
      },
    );

TileSetGrid _$TileSetGridFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TileSetGrid',
      json,
      ($checkedConvert) {
        final val = TileSetGrid(
          $checkedConvert('height', (v) => v as int),
          $checkedConvert(
              'orientation',
              (v) =>
                  $enumDecodeNullable(_$TileSetGridOrientationEnumMap, v) ??
                  TileSetGridOrientation.orthogonal),
          $checkedConvert('width', (v) => v as int),
        );
        return val;
      },
    );

const _$TileSetGridOrientationEnumMap = {
  TileSetGridOrientation.orthogonal: 'orthogonal',
  TileSetGridOrientation.isometric: 'isometric',
};

Tileset _$TilesetFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Tileset',
      json,
      ($checkedConvert) {
        final val = Tileset(
          $checkedConvert('backgroundcolor', (v) => v as String?),
          $checkedConvert('class', (v) => v as String?),
          $checkedConvert('columns', (v) => v as int?),
          $checkedConvert(
              'fillmode',
              (v) =>
                  $enumDecodeNullable(_$TilesetFillmodeEnumMap, v) ??
                  TilesetFillmode.stretch),
          $checkedConvert('firstgid', (v) => v as int?),
          $checkedConvert(
              'grid',
              (v) => v == null
                  ? null
                  : TileSetGrid.fromJson(v as Map<String, dynamic>)),
          $checkedConvert('image', (v) => v as String?),
          $checkedConvert('imageheight', (v) => v as int?),
          $checkedConvert('imagewidth', (v) => v as int?),
          $checkedConvert('margin', (v) => v as int?),
          $checkedConvert('name', (v) => v as String?),
          $checkedConvert(
              'objectalignment',
              (v) =>
                  $enumDecodeNullable(_$TilesetObjectalignmentEnumMap, v) ??
                  TilesetObjectalignment.unspecified),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('source', (v) => v as String?),
          $checkedConvert('spacing', (v) => v as int?),
          $checkedConvert(
              'terrains',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Terrain.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('tilecount', (v) => v as int?),
          $checkedConvert('tileheight', (v) => v as int?),
          $checkedConvert(
              'tileoffset',
              (v) => v == null
                  ? null
                  : TileOffset.fromJson(v as Map<String, dynamic>)),
          $checkedConvert('tilewidth', (v) => v as int?),
          $checkedConvert('tiledversion', (v) => v as String?),
          $checkedConvert(
              'tilerendersize',
              (v) =>
                  $enumDecodeNullable(_$TilesetTilerendersizeEnumMap, v) ??
                  TilesetTilerendersize.tile),
          $checkedConvert(
              'tiles',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Tile.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert(
              'transformations',
              (v) => v == null
                  ? null
                  : TilesetTransformations.fromJson(v as Map<String, dynamic>)),
          $checkedConvert('transparentcolor', (v) => v as String?),
          $checkedConvert('type', (v) => v as String?),
          $checkedConvert('version', (v) => v),
          $checkedConvert(
              'wangsets',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => WangSet.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'backgroundColor': 'backgroundcolor',
        'class_': 'class',
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
      },
    );

const _$TilesetFillmodeEnumMap = {
  TilesetFillmode.stretch: 'stretch',
  TilesetFillmode.preserveAspectFit: 'preserve-aspect-fit',
};

const _$TilesetObjectalignmentEnumMap = {
  TilesetObjectalignment.unspecified: 'unspecified',
  TilesetObjectalignment.topleft: 'topleft',
  TilesetObjectalignment.top: 'top',
  TilesetObjectalignment.topright: 'topright',
  TilesetObjectalignment.left: 'left',
  TilesetObjectalignment.center: 'center',
  TilesetObjectalignment.right: 'right',
  TilesetObjectalignment.bottomleft: 'bottomleft',
  TilesetObjectalignment.bottom: 'bottom',
  TilesetObjectalignment.bottomright: 'bottomright',
};

const _$TilesetTilerendersizeEnumMap = {
  TilesetTilerendersize.tile: 'tile',
  TilesetTilerendersize.grid: 'grid',
};

TilesetTransformations _$TilesetTransformationsFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'TilesetTransformations',
      json,
      ($checkedConvert) {
        final val = TilesetTransformations(
          $checkedConvert('hflip', (v) => v as bool),
          $checkedConvert('vflip', (v) => v as bool),
          $checkedConvert('preferuntransformed', (v) => v as bool),
          $checkedConvert('rotate', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'isFlippedHorizontally': 'hflip',
        'isFlippedVertically': 'vflip',
        'isPreferuntransformed': 'preferuntransformed',
        'isRotate': 'rotate'
      },
    );

WangColor _$WangColorFromJson(Map<String, dynamic> json) => $checkedCreate(
      'WangColor',
      json,
      ($checkedConvert) {
        final val = WangColor(
          $checkedConvert('class', (v) => v as String?),
          $checkedConvert('color', (v) => v as String),
          $checkedConvert('name', (v) => v as String),
          $checkedConvert('probability', (v) => (v as num).toDouble()),
          $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('tile', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {'class_': 'class'},
    );

WangTile _$WangTileFromJson(Map<String, dynamic> json) => $checkedCreate(
      'WangTile',
      json,
      ($checkedConvert) {
        final val = WangTile(
          $checkedConvert('tileid', (v) => v as int),
          $checkedConvert('wangid',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
        );
        return val;
      },
      fieldKeyMap: const {'tileId': 'tileid', 'wangId': 'wangid'},
    );
