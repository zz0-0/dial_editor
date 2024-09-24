import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuoteBlock', () {
    test('should create QuoteBlock with given key and parentKey', () {
      final key = GlobalKey<EditableTextState>();
      final parentKey = GlobalKey<EditableTextState>();
      final quoteBlock = QuoteBlock(key: key, parentKey: parentKey);

      expect(quoteBlock.key, equals(key));
      expect(quoteBlock.parentKey, equals(parentKey));
      expect(quoteBlock.type, equals(MarkdownElement.quoteBlock.type));
    });

    test('should create QuoteBlock from map', () {
      final map = {
        'key': 'testKey',
        'parentKey': 'testParentKey',
        'children': '[]',
      };

      final quoteBlock = QuoteBlock.fromMap(map);

      expect(quoteBlock.key as GlobalKey, equals('testKey'));
      expect(
        quoteBlock.parentKey! as GlobalKey,
        equals('testParentKey'),
      );
      expect(quoteBlock.children, isEmpty);
    });

    test('should create QuoteBlock from map with children', () {
      final map = {
        'key': 'testKey',
        'parentKey': 'testParentKey',
        'children': [
          {
            'key': 'childKey',
            'type': 'childType',
          },
        ],
      };

      final quoteBlock = QuoteBlock.fromMap(map);

      expect(quoteBlock.key as GlobalKey, equals('testKey'));
      expect(
        quoteBlock.parentKey! as GlobalKey,
        equals('testParentKey'),
      );
      expect(quoteBlock.children, isNotEmpty);
      expect(
        quoteBlock.children.first.key as GlobalKey,
        equals('childKey'),
      );
    });
  });
}
