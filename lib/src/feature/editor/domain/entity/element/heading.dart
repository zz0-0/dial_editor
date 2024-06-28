import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class Heading extends Node {
  int level;

  Heading(this.level, String rawText, [String text = ""])
      : super(rawText, text) {
    // Node.registerParser('heading', Heading.parse);
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    final regex = RegExp("^#{1,6}");
    text = newText.replaceAll(regex, '').trim();
  }

  // factory Heading.parse(String line) {
  //   final regex = RegExp("^#{1,6}");

  //   if (regex.matchAsPrefix(line) != null) {
  //     final level = regex.allMatches(line).length;
  //     final rawText = line;
  //     final text = line.replaceAll(regex, '').trim();
  //     return Heading(level, rawText, text);
  //   }

  //   return Heading(1, "");
  // }

  @override
  Widget render() {
    style = TextStyle(fontSize: 20 + level * 2, color: Colors.black);
    return Text(
      text,
      style: style,
    );
  }

  @override
  String toString() {
    return rawText;
  }
}
