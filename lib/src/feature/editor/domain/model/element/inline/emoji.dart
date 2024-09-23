/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// Represents an emoji element within an inline context in the editor domain.
///
/// This class extends the [Inline] class, indicating that it is a type of
/// inline element that can be used within the editor.
///
/// Example usage:
///
/// ```dart
/// Emoji emoji = Emoji();
/// ```
base class Emoji extends Inline {
  /// Represents an emoji element within the editor.
  ///
  /// This class is used to define and manage emoji elements that can be
  /// included in the editor content.
  ///
  /// Example usage:
  /// ```dart
  /// Emoji(emojiCode: '😊');
  /// ```
  ///
  /// Parameters:
  /// - `emojiCode`: The Unicode representation of the emoji.
  ///
  Emoji({
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
    type = MarkdownElement.emoji.type;
  }

  /// Creates an instance of [Emoji] from a given map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize an [Emoji] object.
  ///
  /// Returns an [Emoji] object initialized with the values from the map.
  factory Emoji.fromMap(Map<String, dynamic> map) {
    return Emoji(
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
    return TextRenderInstruction(rawText, MarkdownElement.emoji);
  }
}
