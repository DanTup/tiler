import 'utils.dart';

void main() {
  testMapRender('embedded/tileset');
  testMapRender('encoding/base64_uncompressed', goldenName: 'encoding/output');
  testMapRender('encoding/base64_zlib', goldenName: 'encoding/output');
  testMapRender('encoding/csv', goldenName: 'encoding/output');
  testMapRender('offsets/layers');
  testMapRender('translations/mirrored');
  testMapRender('translations/rotated_and_mirrored');
  testMapRender('translations/rotated');
  testMapRender('orientation/isometric', scale: 0.25);
}
