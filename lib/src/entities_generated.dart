part of 'entities.dart';

@JsonSerializable()
class BoolProperty extends Property {
  BoolProperty(
    super.name,
    super.propertytype,
    super.type,
    this.value,
  );
  factory BoolProperty.fromJson(Map<String, dynamic> json) =>
      _$BoolPropertyFromJson(json);

  bool value;
}

@JsonSerializable()
class Chunk {
  Chunk(
    this.data,
    this.height,
    this.width,
    this.x,
    this.y,
  );
  factory Chunk.fromJson(Map<String, dynamic> json) => _$ChunkFromJson(json);

  /// Array of unsigned int (GIDs) or base64-encoded data
  @JsonKey(fromJson: decodeData)
  List<int> data;

  /// Height in tiles
  int height;

  /// Width in tiles
  int width;

  /// X coordinate in tiles
  int x;

  /// Y coordinate in tiles
  int y;
}

@JsonSerializable()
class ClassProperty extends Property {
  ClassProperty(
    super.name,
    super.propertytype,
    super.type,
    this.value,
  );
  factory ClassProperty.fromJson(Map<String, dynamic> json) =>
      _$ClassPropertyFromJson(json);

  dynamic value;
}

@JsonSerializable()
class ColorProperty extends Property {
  ColorProperty(
    super.name,
    super.propertytype,
    super.type,
    this.value,
  );
  factory ColorProperty.fromJson(Map<String, dynamic> json) =>
      _$ColorPropertyFromJson(json);

  String value;
}

@JsonSerializable()
class CornerWangSet extends WangSet {
  CornerWangSet(
    super.class_,
    super.colors,
    super.name,
    super.properties,
    super.tile,
    super.type,
    super.wangTiles,
  );
  factory CornerWangSet.fromJson(Map<String, dynamic> json) =>
      _$CornerWangSetFromJson(json);
}

@JsonSerializable()
class EdgeWangSet extends WangSet {
  EdgeWangSet(
    super.class_,
    super.colors,
    super.name,
    super.properties,
    super.tile,
    super.type,
    super.wangTiles,
  );
  factory EdgeWangSet.fromJson(Map<String, dynamic> json) =>
      _$EdgeWangSetFromJson(json);
}

@JsonSerializable()
class FileProperty extends Property {
  FileProperty(
    super.name,
    super.propertytype,
    super.type,
    this.value,
  );
  factory FileProperty.fromJson(Map<String, dynamic> json) =>
      _$FilePropertyFromJson(json);

  String value;
}

@JsonSerializable()
class FloatProperty extends Property {
  FloatProperty(
    super.name,
    super.propertytype,
    super.type,
    this.value,
  );
  factory FloatProperty.fromJson(Map<String, dynamic> json) =>
      _$FloatPropertyFromJson(json);

  double value;
}

@JsonSerializable()
class Frame {
  Frame(
    this.duration,
    this.tileId,
  );
  factory Frame.fromJson(Map<String, dynamic> json) => _$FrameFromJson(json);

  /// Frame duration in milliseconds
  int duration;

  /// Local tile ID representing this frame
  @JsonKey(name: 'tileid')
  int tileId;
}

@JsonSerializable()
class GroupLayer extends Layer {
  GroupLayer(
    super.class_,
    super.id,
    super.isLocked,
    super.isVisible,
    super.name,
    super.offsetX,
    super.offsetY,
    super.opacity,
    super.parallaxx,
    super.parallaxy,
    super.properties,
    super.startX,
    super.startY,
    super.tintcolor,
    super.type,
    super.x,
    super.y,
    this.layers,
  );
  factory GroupLayer.fromJson(Map<String, dynamic> json) =>
      _$GroupLayerFromJson(json);

  /// Array of :ref:`layers <json-layer>`. group only.
  List<Layer>? layers;
}

@JsonSerializable()
class ImageLayer extends Layer {
  ImageLayer(
    super.class_,
    super.id,
    super.isLocked,
    super.isVisible,
    super.name,
    super.offsetX,
    super.offsetY,
    super.opacity,
    super.parallaxx,
    super.parallaxy,
    super.properties,
    super.startX,
    super.startY,
    super.tintcolor,
    super.type,
    super.x,
    super.y,
    this.image,
    this.isRepeatx,
    this.isRepeaty,
    this.transparentColor,
  );
  factory ImageLayer.fromJson(Map<String, dynamic> json) =>
      _$ImageLayerFromJson(json);

  /// Image used by this layer. imagelayer only.
  String? image;

  /// Whether the image drawn by this layer is repeated along the X axis. imagelayer only. (since Tiled 1.8)
  @JsonKey(name: 'repeatx')
  bool? isRepeatx;

  /// Whether the image drawn by this layer is repeated along the Y axis. imagelayer only. (since Tiled 1.8)
  @JsonKey(name: 'repeaty')
  bool? isRepeaty;

  /// Hex-formatted color (#RRGGBB) (optional). imagelayer only.
  @JsonKey(name: 'transparentcolor')
  String? transparentColor;
}

@JsonSerializable()
class IntProperty extends Property {
  IntProperty(
    super.name,
    super.propertytype,
    super.type,
    this.value,
  );
  factory IntProperty.fromJson(Map<String, dynamic> json) =>
      _$IntPropertyFromJson(json);

  int value;
}

abstract class Layer {
  Layer(
    this.class_,
    this.id,
    this.isLocked,
    this.isVisible,
    this.name,
    this.offsetX,
    this.offsetY,
    this.opacity,
    this.parallaxx,
    this.parallaxy,
    this.properties,
    this.startX,
    this.startY,
    this.tintcolor,
    this.type,
    this.x,
    this.y,
  );
  factory Layer.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'tilelayer':
        return TileLayer.fromJson(json);
      case 'objectgroup':
        return ObjectGroupLayer.fromJson(json);
      case 'imagelayer':
        return ImageLayer.fromJson(json);
      case 'group':
        return GroupLayer.fromJson(json);
      default:
        throw Exception('Unknown Layer type: ${json['type']}');
    }
  }

  /// The class of the layer (since 1.9, optional)
  @JsonKey(name: 'class')
  String? class_;

  /// Incremental ID - unique across all layers
  int id;

  /// Whether layer is locked in the editor (default: false). (since Tiled 1.8.2)
  @JsonKey(name: 'locked', defaultValue: false)
  bool? isLocked;

  /// Whether layer is shown or hidden in editor
  @JsonKey(name: 'visible')
  bool isVisible;

  /// Name assigned to this layer
  String name;

  /// Horizontal layer offset in pixels (default: 0)
  @JsonKey(name: 'offsetx', defaultValue: 0)
  double? offsetX;

  /// Vertical layer offset in pixels (default: 0)
  @JsonKey(name: 'offsety', defaultValue: 0)
  double? offsetY;

  /// Value between 0 and 1
  double opacity;

  /// Horizontal :ref:`parallax factor <parallax-factor>` for this layer (default: 1). (since Tiled 1.5)
  @JsonKey(defaultValue: 1)
  double? parallaxx;

  /// Vertical :ref:`parallax factor <parallax-factor>` for this layer (default: 1). (since Tiled 1.5)
  @JsonKey(defaultValue: 1)
  double? parallaxy;

  /// Array of :ref:`Properties <json-property>`
  List<Property>? properties;

  /// X coordinate where layer content starts (for infinite maps)
  @JsonKey(name: 'startx')
  int? startX;

  /// Y coordinate where layer content starts (for infinite maps)
  @JsonKey(name: 'starty')
  int? startY;

  /// Hex-formatted :ref:`tint color <tint-color>` (#RRGGBB or #AARRGGBB) that is multiplied with any graphics drawn by this layer or any child layers (optional).
  String? tintcolor;

  /// tilelayer, objectgroup, imagelayer or group
  LayerType type;

  /// Horizontal layer offset in tiles. Always 0.
  int x;

  /// Vertical layer offset in tiles. Always 0.
  int y;
}

enum LayerDrawOrder {
  @JsonValue('topdown')
  topDown,
  @JsonValue('index')
  indexOrder,
}

enum LayerEncoding {
  csv,
  base64,
}

enum LayerType {
  @JsonValue('tilelayer')
  tileLayer,
  @JsonValue('objectgroup')
  objectGroup,
  @JsonValue('imagelayer')
  imageLayer,
  group,
}

@JsonSerializable()
class MapObject {
  MapObject(
    this.class_,
    this.gid,
    this.height,
    this.id,
    this.isEllipse,
    this.isPoint,
    this.isVisible,
    this.name,
    this.polygon,
    this.polyline,
    this.properties,
    this.rotation,
    this.template,
    this.text,
    this.width,
    this.x,
    this.y,
  );
  factory MapObject.fromJson(Map<String, dynamic> json) =>
      _$MapObjectFromJson(json);

  /// The class of the object (renamed from type since 1.9, optional)
  @JsonKey(name: 'class')
  String? class_;

  /// Global tile ID, only if object represents a tile
  int? gid;

  /// Height in pixels.
  double height;

  /// Incremental ID, unique across all objects
  int id;

  /// Used to mark an object as an ellipse
  @JsonKey(name: 'ellipse')
  bool? isEllipse;

  /// Used to mark an object as a point
  @JsonKey(name: 'point')
  bool? isPoint;

  /// Whether object is shown in editor.
  @JsonKey(name: 'visible')
  bool isVisible;

  /// String assigned to name field in editor
  String name;

  /// Array of :ref:`Points <json-point>`, in case the object is a polygon
  List<Point>? polygon;

  /// Array of :ref:`Points <json-point>`, in case the object is a polyline
  List<Point>? polyline;

  /// Array of :ref:`Properties <json-property>`
  List<Property>? properties;

  /// Angle in degrees clockwise
  double rotation;

  /// Reference to a template file, in case object is a :doc:`template instance </manual/using-templates>`
  String? template;

  /// Only used for text objects
  ObjectText? text;

  /// Width in pixels.
  double width;

  /// X coordinate in pixels
  double x;

  /// Y coordinate in pixels
  double y;
}

@JsonSerializable()
class MixedWangSet extends WangSet {
  MixedWangSet(
    super.class_,
    super.colors,
    super.name,
    super.properties,
    super.tile,
    super.type,
    super.wangTiles,
  );
  factory MixedWangSet.fromJson(Map<String, dynamic> json) =>
      _$MixedWangSetFromJson(json);
}

@JsonSerializable()
class ObjectGroupLayer extends Layer {
  ObjectGroupLayer(
    super.class_,
    super.id,
    super.isLocked,
    super.isVisible,
    super.name,
    super.offsetX,
    super.offsetY,
    super.opacity,
    super.parallaxx,
    super.parallaxy,
    super.properties,
    super.startX,
    super.startY,
    super.tintcolor,
    super.type,
    super.x,
    super.y,
    this.drawOrder,
    this.objects,
  );
  factory ObjectGroupLayer.fromJson(Map<String, dynamic> json) =>
      _$ObjectGroupLayerFromJson(json);

  /// topdown (default) or index. objectgroup only.
  @JsonKey(name: 'draworder', defaultValue: LayerDrawOrder.topDown)
  LayerDrawOrder? drawOrder;

  /// Array of :ref:`objects <json-object>`. objectgroup only.
  List<MapObject>? objects;
}

@JsonSerializable()
class ObjectProperty extends Property {
  ObjectProperty(
    super.name,
    super.propertytype,
    super.type,
    this.value,
  );
  factory ObjectProperty.fromJson(Map<String, dynamic> json) =>
      _$ObjectPropertyFromJson(json);

  dynamic value;
}

@JsonSerializable()
class ObjectTemplate {
  ObjectTemplate(
    this.mapObject,
    this.tileset,
    this.type,
  );
  factory ObjectTemplate.fromJson(Map<String, dynamic> json) =>
      _$ObjectTemplateFromJson(json);

  /// The object instantiated by this template
  @JsonKey(name: 'object')
  MapObject mapObject;

  /// External tileset used by the template (optional)
  Tileset? tileset;

  /// template
  String type;
}

@JsonSerializable()
class ObjectText {
  ObjectText(
    this.color,
    this.fontfamily,
    this.horizontalAlign,
    this.isBold,
    this.isItalic,
    this.isKerning,
    this.isStrikeout,
    this.isUnderline,
    this.isWrap,
    this.pixelsize,
    this.text,
    this.verticalAlign,
  );
  factory ObjectText.fromJson(Map<String, dynamic> json) =>
      _$ObjectTextFromJson(json);

  /// Hex-formatted color (#RRGGBB or #AARRGGBB) (default: ``#000000``)
  String? color;

  /// Font family (default: ``sans-serif``)
  @JsonKey(defaultValue: 'sans-serif')
  String? fontfamily;

  /// Horizontal alignment (center, right, justify or left (default))
  @JsonKey(name: 'halign', defaultValue: ObjectTextHorizontalAlign.left)
  ObjectTextHorizontalAlign horizontalAlign;

  /// Whether to use a bold font (default: false)
  @JsonKey(name: 'bold', defaultValue: false)
  bool? isBold;

  /// Whether to use an italic font (default: false)
  @JsonKey(name: 'italic', defaultValue: false)
  bool? isItalic;

  /// Whether to use kerning when placing characters (default: true)
  @JsonKey(name: 'kerning', defaultValue: true)
  bool? isKerning;

  /// Whether to strike out the text (default: false)
  @JsonKey(name: 'strikeout', defaultValue: false)
  bool? isStrikeout;

  /// Whether to underline the text (default: false)
  @JsonKey(name: 'underline', defaultValue: false)
  bool? isUnderline;

  /// Whether the text is wrapped within the object bounds (default: false)
  @JsonKey(name: 'wrap', defaultValue: false)
  bool? isWrap;

  /// Pixel size of font (default: 16)
  @JsonKey(defaultValue: 16)
  int? pixelsize;

  /// Text
  String text;

  /// Vertical alignment (center, bottom or top (default))
  @JsonKey(name: 'valign', defaultValue: ObjectTextVerticalAlign.top)
  ObjectTextVerticalAlign verticalAlign;
}

enum ObjectTextHorizontalAlign {
  center,
  right,
  justify,
  left,
}

enum ObjectTextVerticalAlign {
  center,
  bottom,
  top,
}

@JsonSerializable()
class Point {
  Point(
    this.x,
    this.y,
  );
  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);

  /// X coordinate in pixels
  double x;

  /// Y coordinate in pixels
  double y;
}

abstract class Property {
  Property(
    this.name,
    this.propertytype,
    this.type,
  );
  factory Property.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'string':
        return StringProperty.fromJson(json);
      case 'int':
        return IntProperty.fromJson(json);
      case 'float':
        return FloatProperty.fromJson(json);
      case 'bool':
        return BoolProperty.fromJson(json);
      case 'color':
        return ColorProperty.fromJson(json);
      case 'file':
        return FileProperty.fromJson(json);
      case 'object':
        return ObjectProperty.fromJson(json);
      case 'class':
        return ClassProperty.fromJson(json);
      default:
        throw Exception('Unknown Property type: ${json['type']}');
    }
  }

  /// Name of the property
  String name;

  /// Name of the :ref:`custom property type <custom-property-types>`, when applicable (since 1.8)
  String? propertytype;

  /// Type of the property (string (default), int, float, bool, color, file, object or class (since 0.16, with color and file added in 0.17, object added in 1.4 and class added in 1.8))
  @JsonKey(defaultValue: PropertyType.string)
  PropertyType? type;
}

enum PropertyType {
  string,
  int,
  float,
  bool,
  color,
  file,
  @JsonValue('object')
  mapObject,
  @JsonValue('class')
  class_,
}

@JsonSerializable()
class StringProperty extends Property {
  StringProperty(
    super.name,
    super.propertytype,
    super.type,
    this.value,
  );
  factory StringProperty.fromJson(Map<String, dynamic> json) =>
      _$StringPropertyFromJson(json);

  String value;
}

@JsonSerializable()
class Terrain {
  Terrain(
    this.name,
    this.properties,
    this.tile,
  );
  factory Terrain.fromJson(Map<String, dynamic> json) =>
      _$TerrainFromJson(json);

  /// Name of terrain
  String name;

  /// Array of :ref:`Properties <json-property>`
  List<Property>? properties;

  /// Local ID of tile representing terrain
  int tile;
}

@JsonSerializable()
class Tile {
  Tile(
    this.animation,
    this.class_,
    this.height,
    this.id,
    this.image,
    this.imageHeight,
    this.imageWidth,
    this.objectGroup,
    this.probability,
    this.properties,
    this.terrain,
    this.width,
    this.x,
    this.y,
  );
  factory Tile.fromJson(Map<String, dynamic> json) => _$TileFromJson(json);

  /// Array of :ref:`Frames <json-frame>`
  List<Frame>? animation;

  /// The class of the tile (renamed from type since 1.9, optional)
  @JsonKey(name: 'class')
  String? class_;

  /// The height of the sub-rectangle representing this tile (defaults to the image height)
  int? height;

  /// Local ID of the tile
  int id;

  /// Image representing this tile (optional, used for image collection tilesets)
  String? image;

  /// Height of the tile image in pixels
  @JsonKey(name: 'imageheight')
  int imageHeight;

  /// Width of the tile image in pixels
  @JsonKey(name: 'imagewidth')
  int imageWidth;

  /// Layer with type objectgroup, when collision shapes are specified (optional)
  @JsonKey(name: 'objectgroup')
  ObjectGroupLayer? objectGroup;

  /// Percentage chance this tile is chosen when competing with others in the editor (optional)
  double? probability;

  /// Array of :ref:`Properties <json-property>`
  List<Property>? properties;

  /// Index of terrain for each corner of tile (optional)
  List<int>? terrain;

  /// The width of the sub-rectangle representing this tile (defaults to the image width)
  int? width;

  /// The X position of the sub-rectangle representing this tile (default: 0)
  @JsonKey(defaultValue: 0)
  int? x;

  /// The Y position of the sub-rectangle representing this tile (default: 0)
  @JsonKey(defaultValue: 0)
  int? y;
}

@JsonSerializable()
class TileLayer extends Layer {
  TileLayer(
    super.class_,
    super.id,
    super.isLocked,
    super.isVisible,
    super.name,
    super.offsetX,
    super.offsetY,
    super.opacity,
    super.parallaxx,
    super.parallaxy,
    super.properties,
    super.startX,
    super.startY,
    super.tintcolor,
    super.type,
    super.x,
    super.y,
    this.chunks,
    this.compression,
    this.data,
    this.encoding,
    this.height,
    this.width,
  );
  factory TileLayer.fromJson(Map<String, dynamic> json) =>
      _$TileLayerFromJson(json);

  /// Array of :ref:`chunks <json-chunk>` (optional). tilelayer only.
  List<Chunk>? chunks;

  /// zlib, gzip, zstd (since Tiled 1.3) or empty (default). tilelayer only.
  @JsonKey(defaultValue: 'empty')
  String? compression;

  /// Array of unsigned int (GIDs) or base64-encoded data. tilelayer only.
  @JsonKey(fromJson: decodeDataNullable)
  List<int>? data;

  /// csv (default) or base64. tilelayer only.
  @JsonKey(defaultValue: LayerEncoding.csv)
  LayerEncoding? encoding;

  /// Row count. Same as map height for fixed-size maps. tilelayer only.
  int? height;

  /// Column count. Same as map width for fixed-size maps. tilelayer only.
  int? width;
}

@JsonSerializable()
class TileMap {
  TileMap(
    this.backgroundColor,
    this.class_,
    this.compressionlevel,
    this.height,
    this.hexSideLength,
    this.isInfinite,
    this.layers,
    this.nextLayerId,
    this.nextObjectId,
    this.orientation,
    this.parallaxoriginx,
    this.parallaxoriginy,
    this.properties,
    this.renderOrder,
    this.staggerAxis,
    this.staggerIndex,
    this.tileHeight,
    this.tileWidth,
    this.tiledVersion,
    this.tilesets,
    this.type,
    this.version,
    this.width,
  );
  factory TileMap.fromJson(Map<String, dynamic> json) =>
      _$TileMapFromJson(json);

  /// Hex-formatted color (#RRGGBB or #AARRGGBB) (optional)
  @JsonKey(name: 'backgroundcolor')
  String? backgroundColor;

  /// The class of the map (since 1.9, optional)
  @JsonKey(name: 'class')
  String? class_;

  /// The compression level to use for tile layer data (defaults to -1, which means to use the algorithm default)
  int? compressionlevel;

  /// Number of tile rows
  int height;

  /// Length of the side of a hex tile in pixels (hexagonal maps only)
  @JsonKey(name: 'hexsidelength')
  int? hexSideLength;

  /// Whether the map has infinite dimensions
  @JsonKey(name: 'infinite')
  bool isInfinite;

  /// Array of :ref:`Layers <json-layer>`
  List<Layer> layers;

  /// Auto-increments for each layer
  @JsonKey(name: 'nextlayerid')
  int nextLayerId;

  /// Auto-increments for each placed object
  @JsonKey(name: 'nextobjectid')
  int nextObjectId;

  /// orthogonal, isometric, staggered or hexagonal
  TileMapOrientation orientation;

  /// X coordinate of the parallax origin in pixels (since 1.8, default: 0)
  double? parallaxoriginx;

  /// Y coordinate of the parallax origin in pixels (since 1.8, default: 0)
  double? parallaxoriginy;

  /// Array of :ref:`Properties <json-property>`
  List<Property>? properties;

  /// ``right-down`` (the default), ``right-up``, ``left-down or left-up`` (currently only supported for orthogonal maps)
  @JsonKey(name: 'renderorder')
  TileMapRenderOrder? renderOrder;

  /// x or y (staggered / hexagonal maps only)
  @JsonKey(name: 'staggeraxis')
  TileMapStaggerAxis? staggerAxis;

  /// odd or even (staggered / hexagonal maps only)
  @JsonKey(name: 'staggerindex')
  TileMapStaggerIndex? staggerIndex;

  /// Map grid height
  @JsonKey(name: 'tileheight')
  int tileHeight;

  /// Map grid width
  @JsonKey(name: 'tilewidth')
  int tileWidth;

  /// The Tiled version used to save the file
  @JsonKey(name: 'tiledversion')
  String? tiledVersion;

  /// Array of :ref:`Tilesets <json-tileset>`
  List<Tileset> tilesets;

  /// map (since 1.0)
  String? type;

  /// The JSON format version (previously a number, saved as string since 1.6)
  Object? version;

  /// Number of tile columns
  int width;
}

enum TileMapOrientation {
  orthogonal,
  isometric,
  staggered,
  hexagonal,
}

enum TileMapRenderOrder {
  @JsonValue('right-down')
  rightDown,
  @JsonValue('right-up')
  rightUp,
  @JsonValue('left-down')
  leftDown,
  @JsonValue('left-up')
  leftUp,
}

enum TileMapStaggerAxis {
  x,
  y,
}

enum TileMapStaggerIndex {
  odd,
  even,
}

@JsonSerializable()
class TileOffset {
  TileOffset(
    this.x,
    this.y,
  );
  factory TileOffset.fromJson(Map<String, dynamic> json) =>
      _$TileOffsetFromJson(json);

  /// Horizontal offset in pixels
  int x;

  /// Vertical offset in pixels (positive is down)
  int y;
}

@JsonSerializable()
class TileSetGrid {
  TileSetGrid(
    this.height,
    this.orientation,
    this.width,
  );
  factory TileSetGrid.fromJson(Map<String, dynamic> json) =>
      _$TileSetGridFromJson(json);

  /// Cell height of tile grid
  int height;

  /// orthogonal (default) or isometric
  @JsonKey(defaultValue: TileSetGridOrientation.orthogonal)
  TileSetGridOrientation orientation;

  /// Cell width of tile grid
  int width;
}

enum TileSetGridOrientation {
  orthogonal,
  isometric,
}

@JsonSerializable()
class Tileset {
  Tileset(
    this.backgroundColor,
    this.class_,
    this.columns,
    this.fillmode,
    this.firstGid,
    this.grid,
    this.image,
    this.imageHeight,
    this.imageWidth,
    this.margin,
    this.name,
    this.objectalignment,
    this.properties,
    this.source,
    this.spacing,
    this.terrains,
    this.tileCount,
    this.tileHeight,
    this.tileOffset,
    this.tileWidth,
    this.tiledVersion,
    this.tilerendersize,
    this.tiles,
    this.transformations,
    this.transparentColor,
    this.type,
    this.version,
    this.wangSets,
  );
  factory Tileset.fromJson(Map<String, dynamic> json) =>
      _$TilesetFromJson(json);

  /// Hex-formatted color (#RRGGBB or #AARRGGBB) (optional)
  @JsonKey(name: 'backgroundcolor')
  String? backgroundColor;

  /// The class of the tileset (since 1.9, optional)
  @JsonKey(name: 'class')
  String? class_;

  /// The number of tile columns in the tileset
  int? columns;

  /// The fill mode to use when rendering tiles from this tileset (stretch (default) or ``preserve-aspect-fit``) (since 1.9)
  @JsonKey(defaultValue: TilesetFillmode.stretch)
  TilesetFillmode? fillmode;

  /// GID corresponding to the first tile in the set
  @JsonKey(name: 'firstgid')
  int? firstGid;

  /// (optional)
  TileSetGrid? grid;

  /// Image used for tiles in this set
  String? image;

  /// Height of source image in pixels
  @JsonKey(name: 'imageheight')
  int? imageHeight;

  /// Width of source image in pixels
  @JsonKey(name: 'imagewidth')
  int? imageWidth;

  /// Buffer between image edge and first tile (pixels)
  int? margin;

  /// Name given to this tileset
  String? name;

  /// Alignment to use for tile objects (unspecified (default), topleft, top, topright, left, center, right, bottomleft, bottom or bottomright) (since 1.4)
  @JsonKey(defaultValue: TilesetObjectalignment.unspecified)
  TilesetObjectalignment? objectalignment;

  /// Array of :ref:`Properties <json-property>`
  List<Property>? properties;

  /// The external file that contains this tilesets data
  String? source;

  /// Spacing between adjacent tiles in image (pixels)
  int? spacing;

  /// Array of :ref:`Terrains <json-terrain>` (optional)
  List<Terrain>? terrains;

  /// The number of tiles in this tileset
  @JsonKey(name: 'tilecount')
  int? tileCount;

  /// Maximum height of tiles in this set
  @JsonKey(name: 'tileheight')
  int? tileHeight;

  /// (optional)
  @JsonKey(name: 'tileoffset')
  TileOffset? tileOffset;

  /// Maximum width of tiles in this set
  @JsonKey(name: 'tilewidth')
  int? tileWidth;

  /// The Tiled version used to save the file
  @JsonKey(name: 'tiledversion')
  String? tiledVersion;

  /// The size to use when rendering tiles from this tileset on a tile layer (tile (default) or grid) (since 1.9)
  @JsonKey(defaultValue: TilesetTilerendersize.tile)
  TilesetTilerendersize? tilerendersize;

  /// Array of :ref:`Tiles <json-tile>` (optional)
  List<Tile>? tiles;

  /// Allowed transformations (optional)
  TilesetTransformations? transformations;

  /// Hex-formatted color (#RRGGBB) (optional)
  @JsonKey(name: 'transparentcolor')
  String? transparentColor;

  /// tileset (for tileset files, since 1.0)
  String? type;

  /// The JSON format version (previously a number, saved as string since 1.6)
  Object? version;

  /// Array of :ref:`Wang sets <json-wangset>` (since 1.1.5)
  @JsonKey(name: 'wangsets')
  List<WangSet>? wangSets;
}

enum TilesetFillmode {
  stretch,
  @JsonValue('preserve-aspect-fit')
  preserveAspectFit,
}

enum TilesetObjectalignment {
  unspecified,
  topleft,
  top,
  topright,
  left,
  center,
  right,
  bottomleft,
  bottom,
  bottomright,
}

enum TilesetTilerendersize {
  tile,
  grid,
}

@JsonSerializable()
class TilesetTransformations {
  TilesetTransformations(
    this.isFlippedHorizontally,
    this.isFlippedVertically,
    this.isPreferuntransformed,
    this.isRotate,
  );
  factory TilesetTransformations.fromJson(Map<String, dynamic> json) =>
      _$TilesetTransformationsFromJson(json);

  /// Tiles can be flipped horizontally
  @JsonKey(name: 'hflip')
  bool isFlippedHorizontally;

  /// Tiles can be flipped vertically
  @JsonKey(name: 'vflip')
  bool isFlippedVertically;

  /// Whether untransformed tiles remain preferred, otherwise transformed tiles are used to produce more variations
  @JsonKey(name: 'preferuntransformed')
  bool isPreferuntransformed;

  /// Tiles can be rotated in 90-degree increments
  @JsonKey(name: 'rotate')
  bool isRotate;
}

@JsonSerializable()
class WangColor {
  WangColor(
    this.class_,
    this.color,
    this.name,
    this.probability,
    this.properties,
    this.tile,
  );
  factory WangColor.fromJson(Map<String, dynamic> json) =>
      _$WangColorFromJson(json);

  /// The class of the Wang color (since 1.9, optional)
  @JsonKey(name: 'class')
  String? class_;

  /// Hex-formatted color (#RRGGBB or #AARRGGBB)
  String color;

  /// Name of the Wang color
  String name;

  /// Probability used when randomizing
  double probability;

  /// Array of :ref:`Properties <json-property>` (since 1.5)
  List<Property>? properties;

  /// Local ID of tile representing the Wang color
  int tile;
}

abstract class WangSet {
  WangSet(
    this.class_,
    this.colors,
    this.name,
    this.properties,
    this.tile,
    this.type,
    this.wangTiles,
  );
  factory WangSet.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'corner':
        return CornerWangSet.fromJson(json);
      case 'edge':
        return EdgeWangSet.fromJson(json);
      case 'mixed':
        return MixedWangSet.fromJson(json);
      default:
        throw Exception('Unknown WangSet type: ${json['type']}');
    }
  }

  /// The class of the Wang set (since 1.9, optional)
  @JsonKey(name: 'class')
  String? class_;

  /// Array of :ref:`Wang colors <json-wangcolor>` (since 1.5)
  List<WangColor>? colors;

  /// Name of the Wang set
  String name;

  /// Array of :ref:`Properties <json-property>`
  List<Property>? properties;

  /// Local ID of tile representing the Wang set
  int tile;

  /// corner, edge or mixed (since 1.5)
  WangSetType? type;

  /// Array of :ref:`Wang tiles <json-wangtile>`
  @JsonKey(name: 'wangtiles')
  List<WangTile> wangTiles;
}

enum WangSetType {
  corner,
  edge,
  mixed,
}

@JsonSerializable()
class WangTile {
  WangTile(
    this.tileId,
    this.wangId,
  );
  factory WangTile.fromJson(Map<String, dynamic> json) =>
      _$WangTileFromJson(json);

  /// Local ID of tile
  @JsonKey(name: 'tileid')
  int tileId;

  /// Array of Wang color indexes (``uchar[8]``)
  @JsonKey(name: 'wangid')
  List<int> wangId;
}
