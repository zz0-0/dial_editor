import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OrderedListBlock', () {
    test('should create an OrderedListBlock with the correct type', () {
      final block = OrderedListBlock(key: GlobalKey());
      expect(block.type, MarkdownElement.orderedListBlock.type);
    });

    test('should create an OrderedListBlock from a map', () {
      final map = {
        'key': 'testKey',
        'parentKey': 'parentTestKey',
        'children': [
          {'key': 'childKey1'},
          {'key': 'childKey2'},
        ],
      };

      final block = OrderedListBlock.fromMap(map);

      expect(block.key, isA<GlobalKey>());
      expect(block.key as GlobalKey, 'testKey');
      expect(block.parentKey, isA<GlobalKey>());
      expect(block.parentKey as GlobalKey?, 'parentTestKey');
      expect(block.children.length, 2);
      expect(block.children[0].key, 'childKey1');
      expect(block.children[1].key, 'childKey2');
    });

    test('should handle null parentKey and children in map', () {
      final map = {
        'key': 'testKey',
      };

      final block = OrderedListBlock.fromMap(map);

      expect(block.key, isA<GlobalKey>());
      expect(block.key as GlobalKey, 'testKey');
      expect(block.parentKey, isNull);
      expect(block.children, isEmpty);
    });
  });
}
