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
    required this.rawText,
    this.text = '',
    this.textHeight,
    this.isBlockStart = false,
    this.isEditing = false,
    this.isExpanded = true,
    this.depth = 0,
  }) {
    controller.text = rawText;
    type = MarkdownElement.inlne.type;
  }

  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.inlne);
  }

  Inline createNewLine() {
    return TextNode(key: key, rawText: '');
  }

  @override
  String toString() {
    return "$rawText\n";
  }

  factory Inline.fromMap(Map<String, dynamic> map) => Inline(
        key: map['key'] as GlobalKey<EditableTextState>,
        rawText: map['rawText'] as String,
        text: map['text'] as String,
        textHeight: map['textHeight'] as double?,
        isBlockStart: map['isBlockStart'] as bool,
        isEditing: map['isEditing'] as bool,
        isExpanded: map['isExpanded'] as bool,
        depth: map['depth'] as int,
      );

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        'type': type,
        'rawText': rawText,
        'text': text,
        'textHeight': textHeight,
        'isBlockStart': isBlockStart,
        'isEditing': isEditing,
        'isExpanded': isExpanded,
        'depth': depth,
      };
}
