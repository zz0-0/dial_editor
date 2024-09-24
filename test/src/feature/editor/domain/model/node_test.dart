import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Node', () {
    test('should create Node from map with type headingBlock', () {
      final key = GlobalKey<EditableTextState>();

      final map = {
        'type': MarkdownElement.headingBlock.type,
        'key': key.toString(),
        'parentKey': 'testParentKey',
      };

      final node = Node.fromMap(map);

      expect(node, isA<HeadingBlock>());
      expect(node.key.toString(), equals(key.toString()));
      expect(node.parentKey.toString(), equals('testParentKey'));
    });

    test('should throw exception for unknown node type', () {
      final key = GlobalKey<EditableTextState>();

      final map = {
        'type': 'unknownType',
        'key': key,
        'parentKey': 'testParentKey',
      };

      expect(() => Node.fromMap(map), throwsException);
    });

    test('should convert Node to map', () {
      final node = Node(
        key: GlobalKey<EditableTextState>(),
        parentKey: GlobalKey<EditableTextState>(),
      );

      final map = node.toMap();

      expect(map['key'], equals(node.key.toString()));
      expect(map['parentKey'], equals(node.parentKey.toString()));
      expect(map['type'], equals(node.type));
    });
  });
}
