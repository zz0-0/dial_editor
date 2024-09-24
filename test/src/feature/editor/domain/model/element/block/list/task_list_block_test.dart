import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskListBlock', () {
    test('should set the correct type', () {
      final taskListBlock = TaskListBlock(key: GlobalKey());
      expect(taskListBlock.type, MarkdownElement.taskListBlock.type);
    });

    test('should create from map correctly', () {
      final map = {
        'key': 'testKey',
        'parentKey': 'parentTestKey',
        'children': '[]',
      };

      final taskListBlock = TaskListBlock.fromMap(map);

      expect(taskListBlock.key.toString(), contains('testKey'));
      expect(taskListBlock.parentKey.toString(), contains('parentTestKey'));
      expect(taskListBlock.children, isEmpty);
    });

    test('should handle null parentKey and children in map', () {
      final map = {
        'key': 'testKey',
        'parentKey': null,
        'children': null,
      };

      final taskListBlock = TaskListBlock.fromMap(map);

      expect(taskListBlock.key.toString(), contains('testKey'));
      expect(taskListBlock.parentKey, isNull);
      expect(taskListBlock.children, isEmpty);
    });
  });
}
