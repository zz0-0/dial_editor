/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// Represents a task list node in the inline elements of the editor.
///
/// This class extends the `Inline` class and is used to model a task list
/// item within the editor's domain model. Task list nodes are typically
/// used to represent items in a checklist or to-do list.
///
/// Example usage:
/// ```dart
/// TaskListNode task = TaskListNode();
/// ```
base class TaskListNode extends Inline {
  /// Represents a node in a task list within the editor.
  ///
  /// This class is used to model a task list item, which can be checked or
  /// unchecked.
  /// It is part of the inline elements in the editor's domain model.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// TaskListNode(
  ///   // initialization parameters
  /// );
  /// ```
  ///
  /// Properties:
  /// - [property1]: Description of property1.
  /// - [property2]: Description of property2.
  ///
  /// Methods:
  /// - [method1]: Description of method1.
  /// - [method2]: Description of method2.
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

  /// Creates a [TaskListNode] instance from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize a [TaskListNode] object.
  ///
  /// Returns a [TaskListNode] object.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> taskListNodeMap = {
  ///   'key1': 'value1',
  ///   'key2': 'value2',
  ///   // Add other necessary key-value pairs
  /// };
  /// TaskListNode taskListNode = TaskListNode.fromMap(taskListNodeMap);
  /// ```
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
