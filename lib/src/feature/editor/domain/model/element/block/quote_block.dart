/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class QuoteBlock extends Block {
  QuoteBlock({required super.key}) {
    type = MarkdownElement.quoteBlock.type;
  }

  factory QuoteBlock.fromMap(Map<String, dynamic> map) {
    return QuoteBlock(key: map['key'] as GlobalKey<EditableTextState>);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'type': type,
    };
  }
}
