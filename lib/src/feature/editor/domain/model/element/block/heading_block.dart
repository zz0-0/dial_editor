/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class HeadingBlock extends Block {
  int level;

  HeadingBlock({required super.key, required this.level}) {
    type = MarkdownElement.headingBlock.type;
  }

  factory HeadingBlock.fromMap(Map<String, dynamic> map) {
    return HeadingBlock(
      key: map['key'] as GlobalKey<EditableTextState>,
      level: map['level'] as int,
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
