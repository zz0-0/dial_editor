/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class HorizontalRule extends Inline {
  HorizontalRule({
    required super.rawText,
    required super.key,
  }) {
    type = MarkdownElement.horizontalRule.type;
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.horizontalRule);
  }

  factory HorizontalRule.fromMap(Map<String, dynamic> map) {
    return HorizontalRule(
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
