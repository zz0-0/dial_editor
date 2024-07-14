import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class TextNode extends Inline {
  TextNode(super.context, super.rawText) {
    controller.text = rawText;
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    text = newText;
    updateStyle();
    updateTextHeight();
  }

  @override
  Widget render() {
    updateStyle();
    updateTextHeight();
    return Text(rawText, style: style);
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
