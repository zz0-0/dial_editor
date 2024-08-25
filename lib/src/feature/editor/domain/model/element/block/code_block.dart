/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class CodeBlock extends Block {
  String language = '';

  CodeBlock({required super.key}) {
    type = MarkdownElement.codeBlock.type;
  }

  factory CodeBlock.fromMap(Map<String, dynamic> map) {
    return CodeBlock(key: map['key'] as GlobalKey<EditableTextState>);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'type': type,
    };
  }
}
