import 'package:flutter/widgets.dart';

abstract class Node {
  BuildContext context;
  String rawText;
  String text;
  TextStyle style;
  late TextEditingController controller;
  FocusNode focusNode = FocusNode();
  bool _initializing = true;
  bool isEditing = false;

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
}
