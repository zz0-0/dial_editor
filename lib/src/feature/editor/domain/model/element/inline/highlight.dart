/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// Represents a highlighted inline element within the editor.
/// 
/// The `Highlight` class extends the `Inline` class to provide
/// functionality specific to highlighted text elements.
/// 
/// This can be used to apply special styling or behavior to
/// text that needs to be emphasized or marked as important.
base class Highlight extends Inline {
  /// Represents a highlighted text element within the editor.
  /// 
  /// The `Highlight` class is used to define a segment of text that should be
  /// visually distinguished from other text, typically by applying a background
  /// color or other styling.
  /// 
  /// Example usage:
  /// 
  /// ```dart
  /// Highlight(
  ///   // parameters
  /// );
  /// ```
  /// 
  /// This can be useful for emphasizing important information or marking
  /// sections of text for review.
  Highlight({
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
    type = MarkdownElement.highlight.type;
  }
  /// Creates a new instance of [Highlight] from a given map.
  ///
  /// The [map] parameter is a `Map<String, dynamic>` that contains the data
  /// needed to instantiate a [Highlight] object.
  ///
  /// Returns a [Highlight] object populated with the values from the map.
  factory Highlight.fromMap(Map<String, dynamic> map) {
    return Highlight(
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
    return TextRenderInstruction(rawText, MarkdownElement.highlight);
  }
}
