import 'package:dial_editor/src/feature/editor/domain/model/element/block/code_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CodeBlock', () {
    test('should create a CodeBlock with the given parameters', () {
      final key = GlobalKey<EditableTextState>();
      final parentKey = GlobalKey<EditableTextState>();
      const language = 'dart';

      final codeBlock = CodeBlock(
        key: key,
        parentKey: parentKey,
        language: language,
      );

      expect(codeBlock.key, equals(key));
      expect(codeBlock.parentKey, equals(parentKey));
      expect(codeBlock.language, equals(language));
      expect(codeBlock.type, equals('codeBlock'));
    });

    test('should create a CodeBlock from a map', () {
      final map = {
        'key': 'testKey',
        'parentKey': 'testParentKey',
        'language': 'dart',
        'children': '[]',
      };

      final codeBlock = CodeBlock.fromMap(map);

      expect(codeBlock.key as GlobalKey, equals('testKey'));
      expect(
        codeBlock.parentKey as GlobalKey?,
        equals('testParentKey'),
      );
      expect(codeBlock.language, equals('dart'));
      expect(codeBlock.children, isEmpty);
    });

    test('should create a CodeBlock from a map with null parentKey', () {
      final map = {
        'key': 'testKey',
        'language': 'dart',
        'children': '[]',
      };

      final codeBlock = CodeBlock.fromMap(map);

      expect(codeBlock.key as GlobalKey, equals('testKey'));
      expect(codeBlock.parentKey, isNull);
      expect(codeBlock.language, equals('dart'));
      expect(codeBlock.children, isEmpty);
    });
  });
}
