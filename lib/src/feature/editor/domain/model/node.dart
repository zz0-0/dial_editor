import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:flutter/material.dart';

abstract class Node {
  GlobalKey<EditableTextState> key = GlobalKey<EditableTextState>();
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

  Node({required this.rawText}) {
    controller.text = rawText;
  }

  RenderInstruction render();

  Node createNewLine();
}
