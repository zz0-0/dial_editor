/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a strikethrough element in the inline editor domain.
///
/// This class extends the [Inline] class and is used to denote text that
/// should be displayed with a strikethrough effect.
///
/// Example usage:
///
/// ```dart
/// Strikethrough strikethrough = Strikethrough();
/// // Use the strikethrough instance as needed
/// ```
///
/// This can be useful for indicating deleted or irrelevant text in the editor.
base class Strikethrough extends Inline {
  /// Represents a strikethrough element in the editor.
  ///
  /// This class is used to create and manage strikethrough text within the
  /// editor.
  ///
  /// Example usage:
  /// ```dart
  /// Strikethrough(
  ///   // parameters
  /// );
  /// ```
  Strikethrough({
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
    type = MarkdownElement.strikethrough.type;
  }

  /// Creates a [Strikethrough] instance from a map.
  ///
  /// The [map] parameter is a `Map<String, dynamic>` that contains the data
  /// necessary to instantiate a [Strikethrough] object.
  ///
  /// Returns a [Strikethrough] object populated with the values from the map.
  factory Strikethrough.fromMap(Map<String, dynamic> map) {
    return Strikethrough(
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
    return TextRenderInstruction(rawText, MarkdownElement.strikethrough);
  }
}
