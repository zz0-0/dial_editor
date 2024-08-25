/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class Emoji extends Inline {
  Emoji({
    required super.rawText,
    required super.key,
  }) {
    type = MarkdownElement.emoji.type;
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.emoji);
  }

  factory Emoji.fromMap(Map<String, dynamic> map) {
    return Emoji(
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
