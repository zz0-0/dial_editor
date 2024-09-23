import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/attribute_button.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/expand.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/line_number.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/recursive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Recursive Widget', () {
    testWidgets('renders Block node and displays children recursively',
        (WidgetTester tester) async {
      // Arrange: Create a Block node with children
      final blockNode = Block(
        key: GlobalKey(),
      );
      blockNode.children.add(Inline(key: GlobalKey(), rawText: 'Child 1'));
      blockNode.children.add(Inline(key: GlobalKey(), rawText: 'Child 2'));

      // Act: Build the Recursive widget with a Block node
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Material(child: Recursive(blockNode, 0)),
          ),
        ),
      );

      // Assert: Verify that the block and its children are rendered
      expect(find.text('Child 1'), findsOneWidget);
      expect(find.text('Child 2'), findsOneWidget);
    });

    testWidgets('renders Inline node and displays content',
        (WidgetTester tester) async {
      // Arrange: Create an Inline node
      final inlineNode = Inline(key: GlobalKey(), rawText: 'Inline Content');

      // Act: Build the Recursive widget with an Inline node
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Material(child: Recursive(inlineNode, 0)),
          ),
        ),
      );

      // Assert: Verify that the inline content is rendered
      expect(find.text('Inline Content'), findsOneWidget);
    });

    testWidgets('displays AttributeButton when tapping inside block',
        (WidgetTester tester) async {
      // Arrange: Create a Block node
      final blockNode = Block(
        key: GlobalKey(),
      );

      blockNode.children.add(Inline(key: GlobalKey(), rawText: 'Block Child'));

      // Act: Build the Recursive widget
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Material(child: Recursive(blockNode, 0)),
          ),
        ),
      );

      // Assert: Tap inside the block and verify AttributeButton shows
      expect(find.byType(AttributeButton), findsNothing);
      await tester.tap(find.text('Block Child'));
      await tester.pump(); // Trigger re-render
      expect(find.byType(AttributeButton), findsExactly(2));
    });

    testWidgets('displays LineNumber and Expand widget for Inline nodes',
        (WidgetTester tester) async {
      // Arrange: Create an Inline node
      final inlineNode = Inline(key: GlobalKey(), rawText: 'Inline Node');

      // Act: Build the Recursive widget
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Material(child: Recursive(inlineNode, 0)),
          ),
        ),
      );

      // Assert: Verify that LineNumber and Expand widgets are present
      expect(find.byType(LineNumber), findsOneWidget);
      expect(find.byType(Expand), findsOneWidget);
    });
  });
}
