import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:flutter/material.dart';

base class Math extends Inline {
  Math({
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
    type = MarkdownElement.math.type;
  }
  factory Math.fromMap(Map<String, dynamic> map) {
    return Math(
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
    return TextRenderInstruction(rawText, MarkdownElement.math);
  }
}
