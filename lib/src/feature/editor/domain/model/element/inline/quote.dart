/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class Quote extends Inline {
  Quote({
    required super.rawText,
    required super.key,
  }) {
    type = MarkdownElement.quote.type;
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.quote);
  }

  @override
  Inline createNewLine() {
    return Quote(key: super.key, rawText: '> ');
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
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
