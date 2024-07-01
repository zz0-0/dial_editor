import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class TextNode extends Node {
  TextNode(BuildContext context, String rawText)
      : super(context, rawText, rawText);

  @override
  void updateText(String newText) {
    rawText = newText;
    text = newText;
    updateStyle();
  }

  @override
  Widget render() {
    updateStyle();
    return Text(text, style: style);
  }

  @override
  String toString() {
    return rawText;
  }

  @override
  void updateStyle() {
    style = const TextStyle();
  }

  @override
  Node createNewLine() {
    return TextNode(context, "");
  }
}
