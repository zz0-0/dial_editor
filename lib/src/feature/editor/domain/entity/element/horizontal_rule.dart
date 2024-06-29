import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class HorizontalRule extends Node {
  HorizontalRule(super.context, super.rawText);

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
  }

  @override
  String toString() {
    return rawText;
  }
}
