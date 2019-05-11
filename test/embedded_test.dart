import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  testWidgets('tileset', (tester) async {
    await expectMapRender(tester, 'embedded/tileset');
  });
}
