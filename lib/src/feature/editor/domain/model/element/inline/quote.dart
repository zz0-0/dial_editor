/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a quote element within an inline context.
///
/// The `Quote` class extends the `Inline` class, indicating that it is a type
/// of inline element. This can be used to represent quoted text within a larger
/// body of text.
///
/// Example usage:
///
/// ```dart
/// Quote myQuote = Quote();
/// ```
///
/// This class can be further extended or used as is to handle specific
/// requirements for inline quotes in the text editor domain.
base class Quote extends Inline {
  /// A class representing a quote element in the editor domain model.
  ///
  /// This class is used to define a quote element which can be used inline
  /// within the editor. It encapsulates the properties and behaviors
  /// associated with a quote element.
  Quote({
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
    type = MarkdownElement.quote.type;
  }

  /// Creates a [Quote] instance from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize a [Quote] object.
  ///
  /// Returns a [Quote] object.
  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
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
    return TextRenderInstruction(rawText, MarkdownElement.quote);
  }

  @override
  Inline createNewLine() {
    return Quote(key: super.key, rawText: '> ');
  }
}
