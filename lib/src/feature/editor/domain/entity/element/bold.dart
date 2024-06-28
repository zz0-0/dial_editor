import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class Bold extends Node {
  Bold(super.rawText, [super.text]) {
    // Node.registerParser('bold', Bold.parse);
  }

  @override
  Widget render() {
    style = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    return Text(
      text,
      style: style,
    );
  }

  // factory Bold.parse(String line) {
  //   final regex = RegExp(r'(\*\*|__)(.*?)\1');

  //   if (regex.matchAsPrefix(line) != null) {
  //     final rawText = line;
  //     final text = line.replaceAll(regex, '').trim();
  //     return Bold(rawText, text);
  //   }

  //   return Bold("");
  // }

  @override
  void updateText(String newText) {
    rawText = newText;
    final regex = RegExp(r'(\*\*|__)(.*?)\1');
    text = newText.replaceAll(regex, '').trim();
  }

  @override
  String toString() {
    return rawText;
  }
}
