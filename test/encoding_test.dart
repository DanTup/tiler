import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
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
