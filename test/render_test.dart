import 'utils.dart';

void main() {
  testMapRender('embedded/tileset');
  testMapRender('encoding/base64_uncompressed', 'encoding/output');
  testMapRender('encoding/base64_zlib', 'encoding/output');
  testMapRender('encoding/csv', 'encoding/output');
  testMapRender('offsets/layers');
  testMapRender('translations/mirrored');
  testMapRender('translations/rotated_and_mirrored');
  testMapRender('translations/rotated');
}
