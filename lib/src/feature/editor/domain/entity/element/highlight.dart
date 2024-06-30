import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class Highlight extends Node {
  Highlight(super.context, super.rawText, [super.text]);

  @override
  Widget render() {
    style = const TextStyle(
      fontSize: 20,
      backgroundColor: Colors.yellow,
    );
    return Text(
      text,
      style: style,
    );
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    final regex = RegExp('==(.*?)==');
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
