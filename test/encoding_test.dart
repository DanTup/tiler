import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  // TODO: Switch these to use external tileset to reduce duplication
  // + add tests for external vs internal
  testWidgets('csv', (tester) async {
    await expectMapRender(tester, 'encoding/csv', 'encoding/output');
  });
  testWidgets('base64_uncompressed', (tester) async {
    await expectMapRender(
        tester, 'encoding/base64_uncompressed', 'encoding/output');
  });
  testWidgets('base64_zlib', (tester) async {
    await expectMapRender(tester, 'encoding/base64_zlib', 'encoding/output');
  });
}
