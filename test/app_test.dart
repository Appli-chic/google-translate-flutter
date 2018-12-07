import 'package:flutter_test/flutter_test.dart';

import 'package:google_translate/main.dart';
import 'components/choose-language-test.dart';
import 'components/translate-text-test.dart';

void main() {
  testWidgets('Test app building', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
  });

  // Test components
  testChooseLanguage();
  testTranslateText();
}
