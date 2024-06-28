import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class Italic extends Node {
  Italic(super.rawText, [super.text]) {
    // Node.registerParser('italic', Italic.parse);
  }

  @override
  Widget render() {
    style = const TextStyle(
      fontSize: 20,
      fontStyle: FontStyle.italic,
    );
    return Text(
      text,
      style: style,
    );
  }

  // factory Italic.parse(String line) {
  //   final regex = RegExp(r'(\*|_)(.*?)\1');

  //   if (regex.matchAsPrefix(line) != null) {
  //     final rawText = line;
  //     final text = line.replaceAll(regex, '').trim();
  //     return Italic(rawText, text);
  //   }

  //   return Italic("");
  // }

  @override
  void updateText(String newText) {
    rawText = newText;
    final regex = RegExp(r'(\*|_)(.*?)\1');
    text = newText.replaceAll(regex, '').trim();
  }

  @override
  String toString() {
    return rawText;
  }
}
