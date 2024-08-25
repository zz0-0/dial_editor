/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class Highlight extends Inline {
  Highlight({
    required super.rawText,
    required super.key,
  }) {
    type = MarkdownElement.highlight.type;
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.highlight);
  }

  factory Highlight.fromMap(Map<String, dynamic> map) {
    return Highlight(
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
