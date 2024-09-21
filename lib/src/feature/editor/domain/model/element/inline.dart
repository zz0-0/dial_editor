/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class Inline extends Node {
  String rawText;
  String text;
  TextEditingController controller = TextEditingController();
  TextStyle style = const TextStyle();
  double? textHeight;
  FocusNode focusNode = FocusNode();
  bool isEditing = false;
  bool isExpanded = true;
  bool isBlockStart = false;
  int depth = 0;

  Inline({
    required super.key,
    super.parentKey,
    required this.rawText,
    this.text = '',
    this.textHeight,
    this.isBlockStart = false,
    this.isEditing = false,
    this.isExpanded = true,
    this.depth = 0,
  }) {
    controller.text = rawText;
    type = MarkdownElement.inline.type;
  }

  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.inline);
  }

  Inline createNewLine() {
    return TextNode(key: GlobalKey(), rawText: '');
  }

  @override
  String toString() {
    return "$rawText\n";
  }

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        'rawText': rawText,
        'text': text,
        'textHeight': textHeight,
        'isBlockStart': isBlockStart,
        'isEditing': isEditing,
        'isExpanded': isExpanded,
        'depth': depth,
      };
}
