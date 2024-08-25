/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class MathBlock extends Block {
  MathBlock({required super.key}) {
    type = MarkdownElement.mathBlock.type;
  }

  factory MathBlock.fromMap(Map<String, dynamic> map) {
    return MathBlock(key: map['key'] as GlobalKey<EditableTextState>);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'type': type,
    };
  }
}
