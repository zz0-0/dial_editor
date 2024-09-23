/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// Represents an ordered list node in the inline element structure.
///
/// This class extends the `Inline` class and is used to define
/// an ordered list within the editor's domain model.
base class OrderedListNode extends Inline {
  /// Represents a node in an ordered list within the editor domain model.
  ///
  /// This class is used to define the structure and behavior of an ordered list
  /// element in the editor. It contains properties and methods that allow for
  /// the manipulation and rendering of ordered list items.
  ///
  /// Example usage:
  /// ```dart
  /// OrderedListNode(
  ///   // initialization parameters
  /// );
  /// ```
  ///
  /// Properties:
  /// - Add a brief description of each property here.
  ///
  /// Methods:
  /// - Add a brief description of each method here.
  OrderedListNode({
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
    type = MarkdownElement.orderedListNode.type;
  }

  /// Creates an instance of [OrderedListNode] from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize an [OrderedListNode] object.
  ///
  /// Returns an [OrderedListNode] instance.
  factory OrderedListNode.fromMap(Map<String, dynamic> map) {
    return OrderedListNode(
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
    return TextRenderInstruction(rawText, MarkdownElement.orderedListNode);
  }

  @override
  Inline createNewLine() {
    final match = orderListRegex.firstMatch(rawText);
    if (match != null) {
      final currentNumber =
          int.tryParse(match.group(0)!.trim().replaceFirst('.', '')) ?? 0;
      final newNumber = currentNumber + 1;
      return OrderedListNode(
        key: super.key,
        rawText: '$newNumber. ',
      );
    }
    return OrderedListNode(
      key: super.key,
      rawText: '1. ',
    );
  }
}
