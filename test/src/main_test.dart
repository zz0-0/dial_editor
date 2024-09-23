// import 'package:dial_editor/main.dart'; // Adjust this to your main app entry point
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   group('Markdown Editor Integration Test', () {
//     testWidgets('Entering and formatting markdown text',
//         (WidgetTester tester) async {
//       // Arrange: Load the app
//       await tester.pumpWidget(
//         const ProviderScope(
//           child: MyApp(), // Replace with your app's entry point
//         ),
//       );

//       // Act: Simulate user typing some markdown
//       final textFieldFinder = find.byType(TextField);
//       expect(textFieldFinder, findsOneWidget);

//       // Enter text into the editor
//       await tester.enterText(textFieldFinder, '# Heading 1\nSome text here');

//       // Simulate formatting actions (e.g., bolding text)
//       final boldButtonFinder =
//           find.text('B'); // Adjust based on your button labels
//       await tester.tap(boldButtonFinder);
//       await tester.pumpAndSettle();

//       // Simulate entering more text after formatting
//       await tester.enterText(textFieldFinder, '**bold text**');
//       await tester.pumpAndSettle();

//       // Assert: Check if the formatted text appears correctly
//       expect(find.textContaining('Heading 1'), findsOneWidget);
//       expect(find.textContaining('bold text'), findsOneWidget);
//     });
//   });
// }

import 'package:dial_editor/main.dart'; // Adjust this to your main app entry point
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Markdown Editor Integration Test', () {
    testWidgets('Entering and formatting markdown text',
        (WidgetTester tester) async {
      // Arrange: Load the app
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(), // Replace with your app's entry point
        ),
      );

      // Act: Simulate user typing some markdown
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);

      // Enter text into the editor
      await tester.enterText(textFieldFinder, '# Heading 1\nSome text here');

      // Simulate formatting actions (e.g., bolding text)
      final boldButtonFinder =
          find.text('B'); // Adjust based on your button labels
      await tester.tap(boldButtonFinder);
      await tester.pumpAndSettle();

      // Simulate entering more text after formatting
      await tester.enterText(textFieldFinder, '**bold text**');
      await tester.pumpAndSettle();

      // Assert: Check if the formatted text appears correctly
      expect(find.textContaining('Heading 1'), findsOneWidget);
      expect(find.textContaining('bold text'), findsOneWidget);
    });

    testWidgets('Switching themes', (WidgetTester tester) async {
      // Arrange: Load the app
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(), // Replace with your app's entry point
        ),
      );

      // Act: Find the theme switch button and tap it
      final themeSwitchFinder = find.byIcon(Icons.brightness_6);
      expect(themeSwitchFinder, findsOneWidget);

      await tester.tap(themeSwitchFinder);
      await tester.pumpAndSettle();

      // Assert: Check if the theme has changed
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(
        appBar.backgroundColor,
        equals(Colors.black),
      ); // Assuming dark theme has black app bar
    });
  });
}
