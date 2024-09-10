/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class CodeBlock extends Block {
  String? language;

  CodeBlock({
    required super.key,
    super.parentKey,
    this.language,
  }) {
    type = MarkdownElement.codeBlock.type;
  }

  factory CodeBlock.fromMap(Map<String, dynamic> map) {
    final block = CodeBlock(
      key: GlobalKey(debugLabel: map['key'] as String),
      parentKey: map['parentKey'] != null
          ? GlobalKey(debugLabel: map['parentKey'] as String)
          : null,
      language: map['language'] as String?,
    );
    block.children = map['children'] != null
        ? (map['children'] as List)
            .map((child) => Node.fromMap(child as Map<String, dynamic>))
            .toList()
        : [];
    return block;
  }
}
