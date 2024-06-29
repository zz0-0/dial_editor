import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class TextNode extends Node {
  TextNode(BuildContext context, String rawText)
      : super(context, rawText, rawText);

  @override
  void updateText(String newText) {
    rawText = newText;
    text = newText;
  }

  @override
  Widget render() {
    return Text(text, style: style);
  }
}
