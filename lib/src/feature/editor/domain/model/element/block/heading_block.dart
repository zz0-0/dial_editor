/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class HeadingBlock extends Block {
  int level;

  HeadingBlock({
    required super.key,
    super.parentKey,
    required this.level,
  }) {
    type = MarkdownElement.headingBlock.type;
  }

  factory HeadingBlock.fromMap(Map<String, dynamic> map) {
    final block = HeadingBlock(
      key: GlobalKey(debugLabel: map['key'] as String),
      parentKey: map['parentKey'] != null
          ? GlobalKey(debugLabel: map['parentKey'] as String)
          : null,
      level: map['level'] as int? ?? 1,
    );
    block.children = map['children'] != null
        ? (map['children'] as List)
            .map((child) => Node.fromMap(child as Map<String, dynamic>))
            .toList()
        : [];
    return block;
  }
}
