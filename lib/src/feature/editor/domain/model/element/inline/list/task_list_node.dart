import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class TaskListNode extends Inline {
  TaskListNode({
    required super.key,
    required super.rawText,
    super.parentKey,
    super.text,
    super.textHeight,
    super.isBlockStart,
    super.isEditing,
    super.isExpanded,
    super.depth,
  }) {
    type = MarkdownElement.taskListNode.type;
  }
  factory TaskListNode.fromMap(Map<String, dynamic> map) {
    return TaskListNode(
      key: GlobalKey(debugLabel: map['key'] as String),
      parentKey: map['parentKey'] != null
          ? GlobalKey(debugLabel: map['parentKey'] as String)
          : null,
      rawText: map['rawText'] as String,
      text: map['text'] as String,
      textHeight: map['textHeight'] as double?,
      isBlockStart: map['isBlockStart'] as bool,
      isEditing: map['isEditing'] as bool,
      isExpanded: map['isExpanded'] as bool,
      depth: map['depth'] as int,
    );
  }
  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.taskListNode);
  }

  @override
  Inline createNewLine() {
    return TaskListNode(
      key: super.key,
      rawText: '- [ ] ',
    );
  }
}
