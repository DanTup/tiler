import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  testWidgets('rotated', (tester) async {
    await expectMapRender(tester, 'translations/rotated');
  });
  testWidgets('mirrored', (tester) async {
    await expectMapRender(tester, 'translations/mirrored');
  });
  testWidgets('rotated_and_mirrored', (tester) async {
    await expectMapRender(tester, 'translations/rotated_and_mirrored');
  });
}
