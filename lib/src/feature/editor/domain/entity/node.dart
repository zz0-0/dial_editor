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
  GlobalKey<EditableTextState> key = GlobalKey<EditableTextState>();
  double textHeight;
  late Widget widget;

  Node(
    this.context,
    this.rawText, [
    this.style = const TextStyle(),
    this.text = "",
    this.textHeight = 0,
  ]) {
    controller = TextEditingController(text: rawText);
    widget = render();
    textHeight = updateTextHeight();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(_onTextChanged);
      _initializing = false;
    });
  }

  void updateText(String newText);

  void updateStyle();

  double updateTextHeight() {
    final textPainter = TextPainter(
      text: TextSpan(text: rawText, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.height;
  }

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
