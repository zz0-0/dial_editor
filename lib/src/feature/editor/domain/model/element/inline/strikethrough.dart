/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class Strikethrough extends Inline {
  Strikethrough({
    required super.rawText,
    required super.key,
  }) {
    type = MarkdownElement.strikethrough.type;
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.strikethrough);
  }

  factory Strikethrough.fromMap(Map<String, dynamic> map) {
    return Strikethrough(
      key: map['key'] as GlobalKey<EditableTextState>,
      rawText: map['rawText'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'type': type,
    };
  }
}
