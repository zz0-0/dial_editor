/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class TaskListNode extends Inline {
  TaskListNode({
    required super.rawText,
    required super.key,
  }) {
    type = MarkdownElement.taskListNode.type;
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.taskListNode);
  }

  @override
  Inline createNewLine() {
    return TaskListNode(
      key: super.key,
      rawText: "- [ ] ",
    );
  }

  factory TaskListNode.fromMap(Map<String, dynamic> map) {
    return TaskListNode(
      key: map['key'] as GlobalKey<EditableTextState>,
      rawText: map['rawText'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'type': type,
    };
  }
}
