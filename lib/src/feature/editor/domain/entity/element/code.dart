import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class Code extends Node {
  Code(super.context, super.rawText, [super.text]);

  @override
  Widget render() {
    style = const TextStyle(
      fontSize: 20,
    );
    return Text(
      text,
      style: style,
    );
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    final regex = RegExp('```(.*?)```', dotAll: true);
    text = newText.replaceAll(regex, '').trim();
    updateStyle();
  }

  @override
  String toString() {
    return rawText;
  }

  @override
  void updateStyle() {
    // TODO: implement updateStyle
  }
}
