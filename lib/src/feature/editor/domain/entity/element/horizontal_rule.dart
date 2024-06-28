import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class HorizontalRule extends Node {
  HorizontalRule(super.rawText) {
    // Node.registerParser('horizontalrule', HorizontalRule.parse);
  }

  @override
  Widget render() {
    style = const TextStyle(
      fontSize: 20,
      backgroundColor: Colors.yellow,
      color: Colors.black,
    );
    return Text(
      text,
      style: style,
    );
  }

  // factory HorizontalRule.parse(String line) {
  //   final regex = RegExp(r'^\s*(---|\*\*\*|___)\s*$');

  //   if (regex.matchAsPrefix(line) != null) {
  //     final rawText = line;
  //     return HorizontalRule(rawText);
  //   }

  //   return HorizontalRule("");
  // }

  @override
  void updateText(String newText) {
    rawText = newText;
  }

  @override
  String toString() {
    return rawText;
  }
}
