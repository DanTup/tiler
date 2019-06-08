part of 'entities.dart';

@JsonSerializable()
class BoolProperty extends Property {
  BoolProperty(
    String name,
    PropertyType type,
    this.value,
  ) : super(
          name,
          type,
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
class ColorProperty extends Property {
  ColorProperty(
    String name,
    PropertyType type,
    this.value,
  ) : super(
          name,
          type,
        );
  factory ColorProperty.fromJson(Map<String, dynamic> json) =>
      _$ColorPropertyFromJson(json);

  String value;
}

@JsonSerializable()
class FileProperty extends Property {
  FileProperty(
    String name,
    PropertyType type,
    this.value,
  ) : super(
          name,
          type,
        );
  factory FileProperty.fromJson(Map<String, dynamic> json) =>
      _$FilePropertyFromJson(json);

  String value;
}

@JsonSerializable()
class FloatProperty extends Property {
  FloatProperty(
    String name,
    PropertyType type,
    this.value,
  ) : super(
          name,
          type,
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
    int height,
    int id,
    bool isVisible,
    String name,
    double offsetX,
    double offsetY,
    double opacity,
    List<Property> properties,
    int startX,
    int startY,
    LayerType type,
    int width,
    int x,
    int y,
    this.layers,
  ) : super(
          height,
          id,
          isVisible,
          name,
          offsetX,
          offsetY,
          opacity,
          properties,
          startX,
          startY,
          type,
          width,
          x,
          y,
        );
  factory GroupLayer.fromJson(Map<String, dynamic> json) =>
      _$GroupLayerFromJson(json);

  /// Array of :ref:`layers <json-layer>`. group only.
  List<Layer> layers;
}

@JsonSerializable()
class ImageLayer extends Layer {
  ImageLayer(
    int height,
    int id,
    bool isVisible,
    String name,
    double offsetX,
    double offsetY,
    double opacity,
    List<Property> properties,
    int startX,
    int startY,
    LayerType type,
    int width,
    int x,
    int y,
    this.image,
    this.transparentColor,
  ) : super(
          height,
          id,
          isVisible,
          name,
          offsetX,
          offsetY,
          opacity,
          properties,
          startX,
          startY,
          type,
          width,
          x,
          y,
        );
  factory ImageLayer.fromJson(Map<String, dynamic> json) =>
      _$ImageLayerFromJson(json);

  /// Image used by this layer. imagelayer only.
  String image;

  /// Hex-formatted color (#RRGGBB) (optional). imagelayer only.
  @JsonKey(name: 'transparentcolor')
  String transparentColor;
}

@JsonSerializable()
class IntProperty extends Property {
  IntProperty(
    String name,
    PropertyType type,
    this.value,
  ) : super(
          name,
          type,
        );
  factory IntProperty.fromJson(Map<String, dynamic> json) =>
      _$IntPropertyFromJson(json);

  int value;
}

abstract class Layer {
  Layer(
    this.height,
    this.id,
    this.isVisible,
    this.name,
    this.offsetX,
    this.offsetY,
    this.opacity,
    this.properties,
    this.startX,
    this.startY,
    this.type,
    this.width,
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

  /// Row count. Same as map height for fixed-size maps.
  int height;

  /// Incremental id - unique across all layers
  int id;

  /// Whether layer is shown or hidden in editor
  @JsonKey(name: 'visible')
  bool isVisible;

  /// Name assigned to this layer
  String name;

  /// Horizontal layer offset in pixels (default: 0)
  @JsonKey(name: 'offsetx', defaultValue: 0)
  double offsetX;

  /// Vertical layer offset in pixels (default: 0)
  @JsonKey(name: 'offsety', defaultValue: 0)
  double offsetY;

  /// Value between 0 and 1
  double opacity;

  /// Array of :ref:`Properties <json-property>`
  List<Property> properties;

  /// X coordinate where layer content starts (for infinite maps)
  @JsonKey(name: 'startx')
  int startX;

  /// Y coordinate where layer content starts (for infinite maps)
  @JsonKey(name: 'starty')
  int startY;

  /// tilelayer, objectgroup, imagelayer or group
  LayerType type;

  /// Column count. Same as map width for fixed-size maps.
  int width;

  /// Horizontal layer offset in tiles. Always 0.
  int x;

  /// Vertical layer offset in tiles. Always 0.
  int y;
}

enum LayerCompression {
  zlib,
  gzip,
  none,
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
    this.type,
    this.width,
    this.x,
    this.y,
  );
  factory MapObject.fromJson(Map<String, dynamic> json) =>
      _$MapObjectFromJson(json);

  /// Global tile ID, only if object represents a tile
  int gid;

  /// Height in pixels.
  double height;

  /// Incremental id, unique across all objects
  int id;

  /// Used to mark an object as an ellipse
  @JsonKey(name: 'ellipse')
  bool isEllipse;

  /// Used to mark an object as a point
  @JsonKey(name: 'point')
  bool isPoint;

  /// Whether object is shown in editor.
  @JsonKey(name: 'visible')
  bool isVisible;

  /// String assigned to name field in editor
  String name;

  /// Array of :ref:`Points <json-point>`, in case the object is a polygon
  List<Point> polygon;

  /// Array of :ref:`Points <json-point>`, in case the object is a polyline
  List<Point> polyline;

  /// Array of :ref:`Properties <json-property>`
  List<Property> properties;

  /// Angle in degrees clockwise
  double rotation;

  /// Reference to a template file, in case object is a :doc:`template instance </manual/using-templates>`
  String template;

  /// Only used for text objects
  ObjectText text;

  /// String assigned to type field in editor
  String type;

  /// Width in pixels.
  double width;

  /// X coordinate in pixels
  double x;

  /// Y coordinate in pixels
  double y;
}

@JsonSerializable()
class ObjectGroupLayer extends Layer {
  ObjectGroupLayer(
    int height,
    int id,
    bool isVisible,
    String name,
    double offsetX,
    double offsetY,
    double opacity,
    List<Property> properties,
    int startX,
    int startY,
    LayerType type,
    int width,
    int x,
    int y,
    this.drawOrder,
    this.objects,
  ) : super(
          height,
          id,
          isVisible,
          name,
          offsetX,
          offsetY,
          opacity,
          properties,
          startX,
          startY,
          type,
          width,
          x,
          y,
        );
  factory ObjectGroupLayer.fromJson(Map<String, dynamic> json) =>
      _$ObjectGroupLayerFromJson(json);

  /// topdown (default) or index. objectgroup only.
  @JsonKey(name: 'draworder', defaultValue: LayerDrawOrder.topDown)
  LayerDrawOrder drawOrder;

  /// Array of :ref:`objects <json-object>`. objectgroup only.
  List<MapObject> objects;
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
  Tileset tileset;

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
  String color;

  /// Font family (default: ``sans-serif``)
  @JsonKey(defaultValue: 'sans-serif')
  String fontfamily;

  /// Horizontal alignment (center, right, justify or left (default))
  @JsonKey(name: 'halign', defaultValue: ObjectTextHorizontalAlign.left)
  ObjectTextHorizontalAlign horizontalAlign;

  /// Whether to use a bold font (default: false)
  @JsonKey(name: 'bold', defaultValue: false)
  bool isBold;

  /// Whether to use an italic font (default: false)
  @JsonKey(name: 'italic', defaultValue: false)
  bool isItalic;

  /// Whether to use kerning when placing characters (default: true)
  @JsonKey(name: 'kerning', defaultValue: true)
  bool isKerning;

  /// Whether to strike out the text (default: false)
  @JsonKey(name: 'strikeout', defaultValue: false)
  bool isStrikeout;

  /// Whether to underline the text (default: false)
  @JsonKey(name: 'underline', defaultValue: false)
  bool isUnderline;

  /// Whether the text is wrapped within the object bounds (default: false)
  @JsonKey(name: 'wrap', defaultValue: false)
  bool isWrap;

  /// Pixel size of font (default: 16)
  @JsonKey(defaultValue: 16)
  int pixelsize;

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
      default:
        throw Exception('Unknown Property type: ${json['type']}');
    }
  }

  /// Name of the property
  String name;

  /// Type of the property (string (default), int, float, bool, color or file (since 0.16, with color and file added in 0.17))
  @JsonKey(defaultValue: PropertyType.string)
  PropertyType type;
}

enum PropertyType {
  string,
  int,
  float,
  bool,
  color,
  file,
}

@JsonSerializable()
class StringProperty extends Property {
  StringProperty(
    String name,
    PropertyType type,
    this.value,
  ) : super(
          name,
          type,
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
  List<Property> properties;

  /// Local ID of tile representing terrain
  int tile;
}

@JsonSerializable()
class Tile {
  Tile(
    this.animation,
    this.id,
    this.image,
    this.imageHeight,
    this.imageWidth,
    this.objectGroup,
    this.probability,
    this.properties,
    this.terrain,
    this.type,
  );
  factory Tile.fromJson(Map<String, dynamic> json) => _$TileFromJson(json);

  /// Array of :ref:`Frames <json-frame>`
  List<Frame> animation;

  /// Local ID of the tile
  int id;

  /// Image representing this tile (optional)
  String image;

  /// Height of the tile image in pixels
  @JsonKey(name: 'imageheight')
  int imageHeight;

  /// Width of the tile image in pixels
  @JsonKey(name: 'imagewidth')
  int imageWidth;

  /// Layer with type objectgroup, when collision shapes are specified (optional)
  @JsonKey(name: 'objectgroup')
  ObjectGroupLayer objectGroup;

  /// Percentage chance this tile is chosen when competing with others in the editor (optional)
  double probability;

  /// Array of :ref:`Properties <json-property>`
  List<Property> properties;

  /// Index of terrain for each corner of tile (optional)
  List<int> terrain;

  /// The type of the tile (optional)
  String type;
}

@JsonSerializable()
class TileLayer extends Layer {
  TileLayer(
    int height,
    int id,
    bool isVisible,
    String name,
    double offsetX,
    double offsetY,
    double opacity,
    List<Property> properties,
    int startX,
    int startY,
    LayerType type,
    int width,
    int x,
    int y,
    this.chunks,
    this.compression,
    this.data,
    this.encoding,
  ) : super(
          height,
          id,
          isVisible,
          name,
          offsetX,
          offsetY,
          opacity,
          properties,
          startX,
          startY,
          type,
          width,
          x,
          y,
        );
  factory TileLayer.fromJson(Map<String, dynamic> json) =>
      _$TileLayerFromJson(json);

  /// Array of :ref:`chunks <json-chunk>` (optional). tilelayer only.
  List<Chunk> chunks;

  /// zlib, gzip or empty (default). tilelayer only.
  @JsonKey(defaultValue: LayerCompression.none)
  LayerCompression compression;

  /// Array of unsigned int (GIDs) or base64-encoded data. tilelayer only.
  @JsonKey(fromJson: decodeData)
  List<int> data;

  /// csv (default) or base64. tilelayer only.
  @JsonKey(defaultValue: LayerEncoding.csv)
  LayerEncoding encoding;
}

@JsonSerializable()
class TileMap {
  TileMap(
    this.backgroundColor,
    this.height,
    this.hexSideLength,
    this.isInfinite,
    this.layers,
    this.nextLayerId,
    this.nextObjectId,
    this.orientation,
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
  String backgroundColor;

  /// Number of tile rows
  int height;

  /// Length of the side of a hex tile in pixels (hexagonal maps only)
  @JsonKey(name: 'hexsidelength')
  int hexSideLength;

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

  /// Array of :ref:`Properties <json-property>`
  List<Property> properties;

  /// ``right-down`` (the default), ``right-up``, ``left-down or left-up`` (orthogonal maps only)
  @JsonKey(name: 'renderorder')
  TileMapRenderOrder renderOrder;

  /// x or y (staggered / hexagonal maps only)
  @JsonKey(name: 'staggeraxis')
  TileMapStaggerAxis staggerAxis;

  /// odd or even (staggered / hexagonal maps only)
  @JsonKey(name: 'staggerindex')
  TileMapStaggerIndex staggerIndex;

  /// Map grid height
  @JsonKey(name: 'tileheight')
  int tileHeight;

  /// Map grid width
  @JsonKey(name: 'tilewidth')
  int tileWidth;

  /// The Tiled version used to save the file
  @JsonKey(name: 'tiledversion')
  String tiledVersion;

  /// Array of :ref:`Tilesets <json-tileset>`
  List<Tileset> tilesets;

  /// map (since 1.0)
  String type;

  /// The JSON format version
  num version;

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
    this.columns,
    this.firstGid,
    this.grid,
    this.image,
    this.imageHeight,
    this.imageWidth,
    this.margin,
    this.name,
    this.properties,
    this.source,
    this.spacing,
    this.terrains,
    this.tileCount,
    this.tileHeight,
    this.tileOffset,
    this.tileWidth,
    this.tiledVersion,
    this.tiles,
    this.transparentColor,
    this.type,
    this.version,
    this.wangSets,
  );
  factory Tileset.fromJson(Map<String, dynamic> json) =>
      _$TilesetFromJson(json);

  /// Hex-formatted color (#RRGGBB or #AARRGGBB) (optional)
  @JsonKey(name: 'backgroundcolor')
  String backgroundColor;

  /// The number of tile columns in the tileset
  int columns;

  /// GID corresponding to the first tile in the set
  @JsonKey(name: 'firstgid')
  int firstGid;

  /// (optional)
  TileSetGrid grid;

  /// Image used for tiles in this set
  String image;

  /// Height of source image in pixels
  @JsonKey(name: 'imageheight')
  int imageHeight;

  /// Width of source image in pixels
  @JsonKey(name: 'imagewidth')
  int imageWidth;

  /// Buffer between image edge and first tile (pixels)
  int margin;

  /// Name given to this tileset
  String name;

  /// Array of :ref:`Properties <json-property>`
  List<Property> properties;

  /// The external file that contains this tilesets data
  String source;

  /// Spacing between adjacent tiles in image (pixels)
  int spacing;

  /// Array of :ref:`Terrains <json-terrain>` (optional)
  List<Terrain> terrains;

  /// The number of tiles in this tileset
  @JsonKey(name: 'tilecount')
  int tileCount;

  /// Maximum height of tiles in this set
  @JsonKey(name: 'tileheight')
  int tileHeight;

  /// (optional)
  @JsonKey(name: 'tileoffset')
  TileOffset tileOffset;

  /// Maximum width of tiles in this set
  @JsonKey(name: 'tilewidth')
  int tileWidth;

  /// The Tiled version used to save the file
  @JsonKey(name: 'tiledversion')
  String tiledVersion;

  /// Array of :ref:`Tiles <json-tile>` (optional)
  List<Tile> tiles;

  /// Hex-formatted color (#RRGGBB) (optional)
  @JsonKey(name: 'transparentcolor')
  String transparentColor;

  /// tileset (for tileset files, since 1.0)
  String type;

  /// The JSON format version
  num version;

  /// Array of :ref:`Wang sets <json-wangset>` (since 1.1.5)
  @JsonKey(name: 'wangsets')
  List<WangSet> wangSets;
}

@JsonSerializable()
class WangColor {
  WangColor(
    this.color,
    this.name,
    this.probability,
    this.tile,
  );
  factory WangColor.fromJson(Map<String, dynamic> json) =>
      _$WangColorFromJson(json);

  /// Hex-formatted color (#RRGGBB or #AARRGGBB)
  String color;

  /// Name of the Wang color
  String name;

  /// Probability used when randomizing
  double probability;

  /// Local ID of tile representing the Wang color
  int tile;
}

@JsonSerializable()
class WangSet {
  WangSet(
    this.cornerColors,
    this.edgeColors,
    this.name,
    this.properties,
    this.tile,
    this.wangTiles,
  );
  factory WangSet.fromJson(Map<String, dynamic> json) =>
      _$WangSetFromJson(json);

  /// Array of :ref:`Wang colors <json-wangcolor>`
  @JsonKey(name: 'cornercolors')
  List<WangColor> cornerColors;

  /// Array of :ref:`Wang colors <json-wangcolor>`
  @JsonKey(name: 'edgecolors')
  List<WangColor> edgeColors;

  /// Name of the Wang set
  String name;

  /// Array of :ref:`Properties <json-property>`
  List<Property> properties;

  /// Local ID of tile representing the Wang set
  int tile;

  /// Array of :ref:`Wang tiles <json-wangtile>`
  @JsonKey(name: 'wangtiles')
  List<WangTile> wangTiles;
}

@JsonSerializable()
class WangTile {
  WangTile(
    this.isFlippedDiagonally,
    this.isFlippedHorizontally,
    this.isFlippedVertically,
    this.tileId,
    this.wangId,
  );
  factory WangTile.fromJson(Map<String, dynamic> json) =>
      _$WangTileFromJson(json);

  /// Tile is flipped diagonally (default: false)
  @JsonKey(name: 'dflip', defaultValue: false)
  bool isFlippedDiagonally;

  /// Tile is flipped horizontally (default: false)
  @JsonKey(name: 'hflip', defaultValue: false)
  bool isFlippedHorizontally;

  /// Tile is flipped vertically (default: false)
  @JsonKey(name: 'vflip', defaultValue: false)
  bool isFlippedVertically;

  /// Local ID of tile
  @JsonKey(name: 'tileid')
  int tileId;

  /// Array of Wang color indexes (``uchar[8]``)
  @JsonKey(name: 'wangid')
  List<int> wangId;
}
