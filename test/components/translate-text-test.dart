import 'package:flutter_test/flutter_test.dart';

import 'package:google_translate/components/translate_text.dart';

void testTranslateText() {
  testWidgets('Test translate text building', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TranslateText());
  });
}