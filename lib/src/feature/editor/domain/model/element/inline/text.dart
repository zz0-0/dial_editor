import 'package:dial_editor/src/feature/editor/domain/model/element/inline/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';

class TextNode extends Inline {
  TextNode({
    required super.context,
    required super.rawText,
    required super.parentKey,
    super.regex,
  }) {
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
    return TextNode(
      context: super.context,
      rawText: "",
      parentKey: super.parentKey,
    );
  }
}
