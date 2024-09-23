/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a text node within an inline element.
///
/// This class extends the [Inline] class and is used to handle text content
/// within inline elements in the editor domain model.
base class TextNode extends Inline {
  /// Creates an instance of [TextNode].
  ///
  /// The [TextNode] represents a piece of text within the editor.
  ///
  /// Example:
  /// ```dart
  /// TextNode(text: 'Hello, world!');
  /// ```
  TextNode({
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
    type = MarkdownElement.text.type;
  }

  /// Creates a [TextNode] instance from a given map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize a [TextNode] object.
  ///
  /// Returns a [TextNode] object.
  factory TextNode.fromMap(Map<String, dynamic> map) {
    return TextNode(
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
    return TextRenderInstruction(rawText, MarkdownElement.text);
  }
}
