import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class Highlight extends Node {
  Highlight(super.rawText, [super.text]) {
    // Node.registerParser('highlight', Highlight.parse);
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

  // factory Highlight.parse(String line) {
  //   final regex = RegExp('==(.*?)==');

  //   if (regex.matchAsPrefix(line) != null) {
  //     final rawText = line;
  //     final text = line.replaceAll(regex, '').trim();
  //     return Highlight(rawText, text);
  //   }

  //   return Highlight("");
  // }

  @override
  void updateText(String newText) {
    rawText = newText;
    final regex = RegExp('==(.*?)==');
    text = newText.replaceAll(regex, '').trim();
  }

  @override
  String toString() {
    return rawText;
  }
}
