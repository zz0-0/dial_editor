/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing italicized text within an inline element.
/// 
/// This class extends the [Inline] class and is used to denote text that 
/// should be displayed in an italic style. It is part of the domain model 
/// for the editor feature.
/// 
/// Example usage:
/// 
/// ```dart
/// Italic italicText = Italic();
/// ```
base class Italic extends Inline {
  /// A class representing an italic text element in the editor.
  /// 
  /// This class is used to define and manage italicized text within the editor.
  /// It provides the necessary properties and methods to handle the specific
  /// behavior and rendering of italic text.
  Italic({
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
    type = MarkdownElement.italic.type;
  }
  /// Creates an instance of [Italic] from a map.
  ///
  /// The [map] parameter is a `Map<String, dynamic>` that contains the data
  /// necessary to instantiate an [Italic] object.
  ///
  /// Returns an [Italic] object populated with the data from the map.
  factory Italic.fromMap(Map<String, dynamic> map) {
    return Italic(
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
    return TextRenderInstruction(rawText, MarkdownElement.italic);
  }
}
