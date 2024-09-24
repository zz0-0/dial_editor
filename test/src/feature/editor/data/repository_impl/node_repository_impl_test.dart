import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/node_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NodeRepositoryImpl', () {
    final repository = NodeRepositoryImpl();

    test('convertDocument should return empty lists for empty input', () {
      final (nodeKeyList, nodeMap) = repository.convertDocument([]);
      expect(nodeKeyList, isEmpty);
      expect(nodeMap, isEmpty);
    });

    test('convertDocument should correctly convert a heading', () {
      final lines = ['# Heading 1'];
      final (nodeKeyList, nodeMap) = repository.convertDocument(lines);

      expect(nodeKeyList, isNotEmpty);
      expect(nodeMap, isNotEmpty);

      final headingBlock = nodeMap[nodeKeyList.first]! as HeadingBlock;
      expect(headingBlock.children.first, isA<Heading>());
      expect((headingBlock.children.first as Heading).rawText, '# Heading 1');
    });

    test('convertDocument should correctly convert an ordered list', () {
      final lines = ['1. Item 1', '2. Item 2'];
      final (nodeKeyList, nodeMap) = repository.convertDocument(lines);

      expect(nodeKeyList, isNotEmpty);
      expect(nodeMap, isNotEmpty);

      final orderedListBlock = nodeMap[nodeKeyList.first]! as OrderedListBlock;
      expect(orderedListBlock.children.length, 2);
      expect(
        (orderedListBlock.children.first as OrderedListNode).rawText,
        '1. Item 1',
      );
      expect(
        (orderedListBlock.children.last as OrderedListNode).rawText,
        '2. Item 2',
      );
    });

    test('convertDocument should correctly convert a code block', () {
      final lines = ['```dart', 'print("Hello, World!");', '```'];
      final (nodeKeyList, nodeMap) = repository.convertDocument(lines);

      expect(nodeKeyList, isNotEmpty);
      expect(nodeMap, isNotEmpty);

      final codeBlock = nodeMap[nodeKeyList.first]! as CodeBlock;
      expect(codeBlock.children.length, 3);
      expect(
        (codeBlock.children[1] as CodeLine).rawText,
        'print("Hello, World!");',
      );
    });

    test('convertDocument should correctly convert a task list', () {
      final lines = ['- [ ] Task 1', '- [x] Task 2'];
      final (nodeKeyList, nodeMap) = repository.convertDocument(lines);

      expect(nodeKeyList, isNotEmpty);
      expect(nodeMap, isNotEmpty);

      final taskListBlock = nodeMap[nodeKeyList.first]! as TaskListBlock;
      expect(taskListBlock.children.length, 2);
      expect(
        (taskListBlock.children.first as TaskListNode).rawText,
        '- [ ] Task 1',
      );
      expect(
        (taskListBlock.children.last as TaskListNode).rawText,
        '- [x] Task 2',
      );
    });

    test('convertDocument should correctly convert a quote block', () {
      final lines = ['> Quote'];
      final (nodeKeyList, nodeMap) = repository.convertDocument(lines);

      expect(nodeKeyList, isNotEmpty);
      expect(nodeMap, isNotEmpty);

      final quoteBlock = nodeMap[nodeKeyList.first]! as QuoteBlock;
      expect(quoteBlock.children.first, isA<Quote>());
      expect((quoteBlock.children.first as Quote).rawText, '> Quote');
    });

    test('convertDocument should correctly convert a math block', () {
      final lines = [r'$$', 'E = mc^2', r'$$'];
      final (nodeKeyList, nodeMap) = repository.convertDocument(lines);

      expect(nodeKeyList, isNotEmpty);
      expect(nodeMap, isNotEmpty);

      final mathBlock = nodeMap[nodeKeyList.first]! as MathBlock;
      expect(mathBlock.children.length, 3);
      expect((mathBlock.children[1] as Math).rawText, 'E = mc^2');
    });
  });
}
