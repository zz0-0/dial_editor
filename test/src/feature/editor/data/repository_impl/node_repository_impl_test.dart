import 'package:dial_editor/src/feature/editor/data/repository_impl/node_repository_impl.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NodeRepositoryImpl nodeRepository;

  setUp(() {
    nodeRepository = NodeRepositoryImpl();
  });

  group('NodeRepositoryImpl', () {
    test('convertDocument should convert lines to nodes and blocks', () {
      final lines = [
        '# Heading 1',
        '## Heading 2',
        '- Unordered list item',
        '1. Ordered list item',
        '> Quote',
        '```',
        'Code block line',
        '```',
        'Normal text',
      ];

      final (nodeKeyList, nodeMap) = nodeRepository.convertDocument(lines);
      expect(nodeKeyList, isNotEmpty);
      expect(nodeMap, isNotEmpty);

      expect(nodeMap.values.whereType<HeadingBlock>().length, 2);
      var node = nodeMap.values.first;
      expect(node, isA<HeadingBlock>());
      node = node.next!;
      expect(node.next, isA<UnorderedListNode>());
      node = node.next!;
      expect(node.next, isA<OrderedListNode>());
      node = node.next!;
      expect(node.next, isA<Quote>());
      node = node.next!;
      expect(node.next, isA<CodeBlockMarker>());
      node = node.next!;
      expect(node.next, isA<CodeLine>());
      node = node.next!;
      expect(node.next, isA<CodeBlockMarker>());
      node = node.next!;
      expect(node.next, isA<TextNode>());
      node = node.next!;
      expect(node.next, isNull);
    });

    test('convert should convert input string to appropriate Inline node', () {
      const headingInput = '# Heading';
      const unorderedListInput = '- Unordered list item';
      const orderedListInput = '1. Ordered list item';
      const quoteInput = '> Quote';
      const codeBlockInput = '```';
      const textInput = 'Normal text';

      final headingNode = nodeRepository.convert(headingInput);
      final unorderedListNode = nodeRepository.convert(unorderedListInput);
      final orderedListNode = nodeRepository.convert(orderedListInput);
      final quoteNode = nodeRepository.convert(quoteInput);
      final codeBlockNode = nodeRepository.convert(codeBlockInput);
      final textNode = nodeRepository.convert(textInput);

      expect(headingNode, isA<Heading>());
      expect(unorderedListNode, isA<UnorderedListNode>());
      expect(orderedListNode, isA<OrderedListNode>());
      expect(quoteNode, isA<Quote>());
      expect(codeBlockNode, isA<CodeBlockMarker>());
      expect(textNode, isA<TextNode>());
    });
  });
}
