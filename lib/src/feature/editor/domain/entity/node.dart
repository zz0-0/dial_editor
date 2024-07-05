import 'package:flutter/widgets.dart';

typedef SelectionCallback = void Function(Node node, bool moveUp);

abstract class Node {
  BuildContext context;
  String rawText;
  String text;
  TextStyle style;
  late TextEditingController controller;
  FocusNode focusNode = FocusNode();
  bool _initializing = true;
  bool isSelected = false;

  Node(
    this.context,
    this.rawText, [
    this.style = const TextStyle(),
    this.text = "",
  ]) {
    controller = TextEditingController(text: rawText);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(_onTextChanged);
      _initializing = false;
    });
  }

  void updateText(String newText);

  void updateStyle();

  Widget render();

  Node createNewLine();

  void _onTextChanged() {
    if (!_initializing && controller.text.isNotEmpty) {
      rawText = controller.text;
      updateText(rawText);
    }
  }

  void dispose() {
    controller.removeListener(_onTextChanged);
    controller.dispose();
    focusNode.dispose();
  }

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
