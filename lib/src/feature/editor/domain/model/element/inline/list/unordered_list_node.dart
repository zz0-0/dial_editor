/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A base class representing an unordered list node in the inline elements of
/// the editor domain.
///
/// This class extends the [Inline] class and is used to model unordered list
/// items within the editor.
///
/// Example usage:
/// ```dart
/// UnorderedListNode node = UnorderedListNode();
/// ```
base class UnorderedListNode extends Inline {
  /// Represents a node in an unordered list within the editor domain model.
  ///
  /// This class is used to define the structure and behavior of an unordered
  /// list node, which is a part of the inline elements in the editor.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// UnorderedListNode(
  ///   // initialization parameters
  /// );
  /// ```
  ///
  /// Properties:
  /// - Add properties here as needed.
  ///
  /// Methods:
  /// - Add methods here as needed.
  UnorderedListNode({
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
    type = MarkdownElement.unorderedListNode.type;
  }

  /// Creates an instance of [UnorderedListNode] from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize an [UnorderedListNode] object.
  ///
  /// Returns an [UnorderedListNode] instance.
  factory UnorderedListNode.fromMap(Map<String, dynamic> map) {
    return UnorderedListNode(
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
    return TextRenderInstruction(rawText, MarkdownElement.unorderedListNode);
  }

  @override
  Inline createNewLine() {
    return UnorderedListNode(
      key: super.key,
      rawText: '- ',
    );
  }
}
