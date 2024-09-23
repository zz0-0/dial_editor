/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a text element that is both bold and italic.
///
/// This class is used to style text with both bold and italic formatting.
///
/// Example usage:
/// ```dart
/// BoldItalic(
///   text: "This is bold and italic text",
/// );
/// ```
///
/// Properties:
/// - `text`: The text content to be styled as bold and italic.
/// This class extends the [Inline] class, indicating that it is an inline
/// text element. It is used to apply both bold and italic styling to a
/// segment of text within a document.
base class BoldItalic extends Inline {
  /// Creates a [BoldItalic] instance with the given parameters.
  BoldItalic({
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
    type = MarkdownElement.boldItalic.type;
  }

  /// Creates a new instance of [BoldItalic] from a given map.
  ///
  /// The [map] parameter is a `Map<String, dynamic>` that contains the data
  /// necessary to instantiate a [BoldItalic] object.
  ///
  /// Returns a [BoldItalic] object populated with the data from the map.
  factory BoldItalic.fromMap(Map<String, dynamic> map) {
    return BoldItalic(
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
    return TextRenderInstruction(rawText, MarkdownElement.boldItalic);
  }
}
