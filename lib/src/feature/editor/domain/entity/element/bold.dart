import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class Bold extends Node {
  Bold(super.context, super.rawText, [super.text]);

  @override
  Widget render() {
    return Text(
      rawText,
      style: style,
    );
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    final regex = RegExp(r'(\*\*|__)(.*?)\1');
    text = newText.replaceAll(regex, '').trim();
    updateStyle();
  }

  @override
  void updateStyle() {
    style = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  String toString() {
    return rawText;
  }
}
