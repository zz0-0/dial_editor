import 'dart:io';

import 'package:flutter_driver/driver_extension.dart'; // For integration testing
import 'package:flutter_test/flutter_test.dart';

void main() {
  enableFlutterDriverExtension();

  testWidgets('Markdown file parsing and rendering performance',
      (WidgetTester tester) async {
    // Initialize the Stopwatch for benchmarking
    final stopwatch = Stopwatch();

    // Load the markdown file content for the test
    const filePath = 'assets/markdown/sample.md';
    final markdownContent = await File(filePath).readAsString();

    // Step 1: Benchmark parsing time
    stopwatch.start();
    // Simulate parsing (if you have a parser function, use it here)
    final parsedContent =
        markdownContent; // Assume it's parsed (this is just a placeholder)
    stopwatch.stop();
    final parsingTime = stopwatch.elapsedMilliseconds;
    print('Markdown Parsing Time: $parsingTime ms');

    // Step 2: Reset Stopwatch and render the markdown in the test environment
    stopwatch
      ..reset()
      ..start();

    // Build the widget to render the markdown
    // await tester.pumpWidget(
    //   MaterialApp(
    //     home: Scaffold(
    //       body: Markdown(data: parsedContent),
    //     ),
    //   ),
    // );

    // Wait for the rendering to finish
    await tester.pumpAndSettle();

    stopwatch.stop();
    final renderingTime = stopwatch.elapsedMilliseconds;
    print('Markdown Rendering Time: $renderingTime ms');

    // Optional: Check if the performance is within an acceptable range
    expect(parsingTime < 100, true, reason: 'Markdown parsing took too long!');
    expect(
      renderingTime < 500,
      true,
      reason: 'Markdown rendering took too long!',
    );
  });
}
