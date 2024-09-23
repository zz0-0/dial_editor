/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a horizontal rule element in the inline context of the 
/// editor.
/// 
/// This class extends the [Inline] class and is used to denote a horizontal 
/// rule
/// within the editor's domain model.
base class HorizontalRule extends Inline {
  /// Represents a horizontal rule element in the editor.
  /// 
  /// This class is used to create a horizontal rule, which is a 
  /// horizontal line that can be used to separate content in the editor.
  HorizontalRule({
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
    type = MarkdownElement.horizontalRule.type;
  }
  /// Creates a [HorizontalRule] instance from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize a [HorizontalRule] object.
  ///
  /// Returns a [HorizontalRule] object.
  factory HorizontalRule.fromMap(Map<String, dynamic> map) {
    return HorizontalRule(
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
    return TextRenderInstruction(rawText, MarkdownElement.horizontalRule);
  }
}
