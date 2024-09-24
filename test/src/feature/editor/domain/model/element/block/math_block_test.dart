import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MathBlock', () {
    test('should create a MathBlock with the correct type', () {
      final mathBlock = MathBlock(key: GlobalKey());

      expect(mathBlock.type, MarkdownElement.mathBlock.type);
    });

    test('should create a MathBlock from a map', () {
      final map = {
        'key': 'testKey',
        'parentKey': 'parentTestKey',
        'children': [
          {
            'key': 'childKey',
            'type': 'childType',
          },
        ],
      };

      final mathBlock = MathBlock.fromMap(map);

      expect(mathBlock.key.toString(), contains('testKey'));
      expect(mathBlock.parentKey.toString(), contains('parentTestKey'));
      expect(mathBlock.children.length, 1);
      expect(mathBlock.children.first.key.toString(), contains('childKey'));
    });

    test('should create a MathBlock from a map without children', () {
      final map = {
        'key': 'testKey',
        'parentKey': 'parentTestKey',
      };

      final mathBlock = MathBlock.fromMap(map);

      expect(mathBlock.key.toString(), contains('testKey'));
      expect(mathBlock.parentKey.toString(), contains('parentTestKey'));
      expect(mathBlock.children, isEmpty);
    });

    test('should create a MathBlock from a map without parentKey', () {
      final map = {
        'key': 'testKey',
        'children': [
          {
            'key': 'childKey',
            'type': 'childType',
          },
        ],
      };

      final mathBlock = MathBlock.fromMap(map);

      expect(mathBlock.key.toString(), contains('testKey'));
      expect(mathBlock.parentKey, isNull);
      expect(mathBlock.children.length, 1);
      expect(mathBlock.children.first.key.toString(), contains('childKey'));
    });
  });
}
