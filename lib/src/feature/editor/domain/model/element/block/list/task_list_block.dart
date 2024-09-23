/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A base class representing a task list block in the editor domain.
///
/// This class extends the [Block] class and is used to model a list of tasks
/// within the editor. Each task in the list can be represented as an item
/// within this block.
base class TaskListBlock extends Block {
  /// A class representing a task list block element in the editor.
  ///
  /// The `TaskListBlock` class is used to define a block element that
  /// contains a list of tasks. This can be used to represent checklists
  /// or to-do lists within the editor.
  ///
  /// Example usage:
  /// ```dart
  /// TaskListBlock(
  ///   // initialization parameters
  /// );
  /// ```
  ///
  /// Properties:
  /// - Add properties here as needed.
  ///
  /// Methods:
  /// - Add methods here as needed.
  TaskListBlock({
    required super.key,
    super.parentKey,
  }) {
    type = MarkdownElement.taskListBlock.type;
  }

  /// Creates a new instance of [TaskListBlock] from a given map.
  ///
  /// The [map] parameter is a `Map<String, dynamic>` that contains the data
  /// necessary to instantiate a [TaskListBlock].
  ///
  /// Returns a [TaskListBlock] object populated with the values from the map.
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
