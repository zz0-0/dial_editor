import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';

abstract class Inline extends Node {
  GlobalKey<EditableTextState>? parentKey;
  String rawText;
  String text = '';
  TextEditingController controller = TextEditingController();
  TextStyle style = const TextStyle();
  double textHeight = 0;
  FocusNode focusNode = FocusNode();
  bool isEditing = false;
  Offset globalPosition = Offset.zero;
  Offset previousGlobalPosition = Offset.zero;
  bool isExpanded = true;
  bool isBlockStart = false;

  Inline({required this.rawText}) {
    controller.text = rawText;
  }

  RenderInstruction render();

  Inline createNewLine();

  @override
  String toString() {
    return "$rawText\n";
  }
}
