/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class CodeLine extends Inline {
  CodeLine({
    required super.rawText,
    required super.key,
  }) {
    type = MarkdownElement.codeLine.type;
  }

  @override
  Inline createNewLine() {
    return CodeLine(
      key: super.key,
      rawText: '',
    );
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.codeLine);
  }

  factory CodeLine.fromMap(Map<String, dynamic> map) {
    return CodeLine(
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
