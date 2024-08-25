/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class Subscript extends Inline {
  Subscript({
    required super.rawText,
    required super.key,
  }) {
    type = MarkdownElement.subscript.type;
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.subscript);
  }

  factory Subscript.fromMap(Map<String, dynamic> map) {
    return Subscript(
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
