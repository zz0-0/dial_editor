import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:flutter/material.dart';

base class TaskListBlock extends Block {
  TaskListBlock({
    required super.key,
    super.parentKey,
  }) {
    type = MarkdownElement.taskListBlock.type;
  }
  factory TaskListBlock.fromMap(Map<String, dynamic> map) {
    final block = TaskListBlock(
      key: GlobalKey(debugLabel: map['key'] as String),
      parentKey: map['parentKey'] != null
          ? GlobalKey(debugLabel: map['parentKey'] as String)
          : null,
    )..children = map['children'] != null
        ? (map['children'] as List)
            .map((child) => Node.fromMap(child as Map<String, dynamic>))
            .toList()
        : [];
    return block;
  }
}
