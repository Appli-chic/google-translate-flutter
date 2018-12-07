import 'package:flutter_test/flutter_test.dart';

import 'package:google_translate/components/choose-language.dart';

void testChooseLanguage() {
  testWidgets('Test choose language building', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ChooseLanguage());
  });
}