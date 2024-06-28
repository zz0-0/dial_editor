import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class Code extends Node {
  Code(super.rawText, [super.text]) {
    // Node.registerParser('code', Code.parse);
  }

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

  // factory Code.parse(String line) {
  //   final regex = RegExp('```(.*?)```', dotAll: true);

  //   if (regex.matchAsPrefix(line) != null) {
  //     final rawText = line;
  //     final text = line.replaceAll(regex, '').trim();
  //     return Code(rawText, text);
  //   }

  //   return Code("");
  // }

  @override
  void updateText(String newText) {
    rawText = newText;
    final regex = RegExp('```(.*?)```', dotAll: true);
    text = newText.replaceAll(regex, '').trim();
  }

  @override
  String toString() {
    return rawText;
  }
}
