import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HeadingBlock', () {
    test('should create HeadingBlock with correct properties', () {
      final key = GlobalKey<EditableTextState>();
      final parentKey = GlobalKey<EditableTextState>();
      const level = 2;

      final headingBlock = HeadingBlock(
        key: key,
        level: level,
        parentKey: parentKey,
      );

      expect(headingBlock.key, equals(key));
      expect(headingBlock.level, equals(level));
      expect(headingBlock.parentKey, equals(parentKey));
      expect(headingBlock.type, equals(MarkdownElement.headingBlock.type));
    });

    test('should create HeadingBlock from map', () {
      final map = {
        'key': 'testKey',
        'parentKey': 'testParentKey',
        'level': 3,
        'children': '[]',
      };

      final headingBlock = HeadingBlock.fromMap(map);

      expect(headingBlock.key, equals('testKey'));
      expect(headingBlock.parentKey, equals('testParentKey'));
      expect(headingBlock.level, equals(3));
      expect(headingBlock.children, isEmpty);
    });

    test('should create HeadingBlock from map with default level', () {
      final map = {
        'key': 'testKey',
        'parentKey': 'testParentKey',
        'children': '[]',
      };

      final headingBlock = HeadingBlock.fromMap(map);

      expect(headingBlock.key, equals('testKey'));
      expect(headingBlock.parentKey, equals('testParentKey'));
      expect(headingBlock.level, equals(1)); // default level
      expect(headingBlock.children, isEmpty);
    });

    test('should create HeadingBlock from map with children', () {
      final map = {
        'key': 'testKey',
        'parentKey': 'testParentKey',
        'level': 3,
        'children': [
          {
            'key': 'childKey',
            'type': 'childType',
          },
        ],
      };

      final headingBlock = HeadingBlock.fromMap(map);

      expect(headingBlock.key, equals('testKey'));
      expect(headingBlock.parentKey, equals('testParentKey'));
      expect(headingBlock.level, equals(3));
      expect(headingBlock.children, isNotEmpty);
      expect(headingBlock.children.first.key, equals('childKey'));
    });
  });
}
