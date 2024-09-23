/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a bold inline element in the editor.
///
/// This class extends the [Inline] class and is used to denote text that
/// should be displayed in bold within the editor.
base class Bold extends Inline {
  /// A class representing a bold text element in the editor.
  ///
  /// This class is used to define and manage bold text within the editor's
  /// domain model. It provides the necessary properties and methods to
  /// handle bold text formatting.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Bold(
  ///   // properties and methods
  /// );
  /// ```
  Bold({
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
    type = MarkdownElement.bold.type;
  }

  /// Creates a [Bold] instance from a map.
  ///
  /// The [map] parameter is a [Map] containing key-value pairs that represent
  /// the properties of the [Bold] instance.
  ///
  /// Returns a [Bold] instance populated with the values from the [map].
  factory Bold.fromMap(Map<String, dynamic> map) {
    return Bold(
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
    return TextRenderInstruction(rawText, MarkdownElement.bold);
  }
}
