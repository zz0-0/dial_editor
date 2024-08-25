/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class Superscript extends Inline {
  Superscript({
    required super.rawText,
    required super.key,
  }) {
    type = MarkdownElement.superscript.type;
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.superscript);
  }

  factory Superscript.fromMap(Map<String, dynamic> map) {
    return Superscript(
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
