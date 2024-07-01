import 'package:flutter/widgets.dart';

abstract class Node {
  BuildContext context;
  String rawText;
  String text;
  TextStyle? style;

  Node(this.context, this.rawText, [this.text = ""]);

  void updateText(String newText);

  void updateStyle();

  Widget render();

  Node createNewLine();

  @override
  String toString();

  // static final Map<String, Node Function(String)> _parsers = {};

  // static void registerParser(String type, Node Function(String) parser) {
  //   _parsers[type] = parser;
  // }

  // factory Node.parse(String line) {
  //   for (final type in _parsers.keys) {
  //     final node = _parsers[type]!(line);
  //     return node;
  //   }
  //   return TextNode(line);
  // }
}
