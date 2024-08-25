/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class TaskListBlock extends Block {
  TaskListBlock({required super.key}) {
    type = MarkdownElement.taskListBlock.type;
  }

  factory TaskListBlock.fromMap(Map<String, dynamic> map) {
    return TaskListBlock(key: map['key'] as GlobalKey<EditableTextState>);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'type': type,
    };
  }
}
