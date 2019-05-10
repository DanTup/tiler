import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  testWidgets('layers', (tester) async {
    await expectMapRender(tester, 'offsets/layers', 'offsets/layers');
  });
}
