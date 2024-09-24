import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class QuoteBlock extends Block {
  QuoteBlock({
    required super.key,
    super.parentKey,
  }) {
    type = MarkdownElement.quoteBlock.type;
  }
  factory QuoteBlock.fromMap(Map<String, dynamic> map) {
    final block = QuoteBlock(
      key: GlobalKey(debugLabel: map['key'] as String),
      parentKey: map['parentKey'] != null
          ? GlobalKey(debugLabel: map['parentKey'] as String)
          : null,
    )..children = map['children'] != null
        ? (map['children'] as List)
            .map((child) => Node.fromMap(child as Map<String, dynamic>))
            .toList()
        : [];
    return block;
  }
}
