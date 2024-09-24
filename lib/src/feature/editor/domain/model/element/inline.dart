import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:flutter/material.dart';

base class Inline extends Node {
  Inline({
    required super.key,
    required this.rawText,
    super.parentKey,
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
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.inline);
  }

  Inline createNewLine() {
    return TextNode(key: GlobalKey(), rawText: '');
  }

  @override
  String toString() {
    return '$rawText\n';
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
