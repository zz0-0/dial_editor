import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code_line.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class CodeBlockMarker extends Node {
  final String language;
  final bool isStart;

  CodeBlockMarker({
    required super.context,
    required this.language,
    required this.isStart,
  }) : super(
          rawText: isStart ? '```$language' : '```',
        );

  @override
  Node createNewLine() {
    return isStart
        ? CodeLine(context: context, rawText: "")
        : TextNode(context: context, rawText: "");
  }

  @override
  Widget render() {
    updateStyle();
    updateTextHeight();
    return Text(rawText, style: style);
  }

  @override
  void updateStyle() {
    style = const TextStyle();
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    text = newText;
    updateStyle();
    updateTextHeight();
  }
}
