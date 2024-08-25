/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class CodeBlockMarker extends Inline {
  String language = '';

  CodeBlockMarker({
    required super.rawText,
    required super.key,
  }) {
    type = MarkdownElement.codeBlockMarker.type;
  }

  @override
  Inline createNewLine() {
    if (language.isNotEmpty) {
      return CodeLine(
        key: super.key,
        rawText: '',
      );
    }
    return TextNode(
      key: super.key,
      rawText: '',
    );
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.codeBlockMarker);
  }

  factory CodeBlockMarker.fromMap(Map<String, dynamic> map) {
    return CodeBlockMarker(
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
