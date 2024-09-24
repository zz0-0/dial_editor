import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UnorderedListBlock', () {
    test('should create an instance with the correct type', () {
      final block = UnorderedListBlock(key: GlobalKey());
      expect(block.type, equals(MarkdownElement.unorderedListBlock.type));
    });

    test('should create an instance from a map', () {
      final map = {
        'key': 'testKey',
        'parentKey': 'parentTestKey',
        'children': [
          {'key': 'childKey1'},
          {'key': 'childKey2'},
        ],
      };

      final block = UnorderedListBlock.fromMap(map);

      expect(block.key.toString(), contains('testKey'));
      expect(block.parentKey.toString(), contains('parentTestKey'));
      expect(block.children.length, equals(2));
      expect(block.children[0].key.toString(), contains('childKey1'));
      expect(block.children[1].key.toString(), contains('childKey2'));
    });

    test('should handle null parentKey and children in the map', () {
      final map = {
        'key': 'testKey',
      };

      final block = UnorderedListBlock.fromMap(map);

      expect(block.key.toString(), contains('testKey'));
      expect(block.parentKey, isNull);
      expect(block.children, isEmpty);
    });
  });
}
