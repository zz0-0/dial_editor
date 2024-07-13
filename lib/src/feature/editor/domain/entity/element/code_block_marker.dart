import 'package:dial_editor/src/feature/editor/domain/entity/element/code_line.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class CodeBlockMarker extends Node {
  final String language;
  final bool isStart;

  CodeBlockMarker(BuildContext context, this.language, this.isStart)
      : super(context, isStart ? '```$language' : '```');

  @override
  Node createNewLine() {
    return isStart ? CodeLine(context, "") : TextNode(context, "");
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
