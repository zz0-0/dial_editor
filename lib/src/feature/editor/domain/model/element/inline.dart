/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/attribute.dart';
import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class Inline extends Node {
  String rawText;
  String text = '';
  TextEditingController controller = TextEditingController();
  TextStyle style = const TextStyle();
  double? textHeight;
  FocusNode focusNode = FocusNode();
  bool isEditing = false;
  bool isExpanded = true;
  bool isBlockStart = false;
  int depth = 0;
  List<Attribute> attributes = [];
  List<Connection> outgoingConnections = [];
  List<Connection> incomingConnections = [];

  Inline({required this.rawText}) {
    controller.text = rawText;
    attributes.add(
      Attribute(
        key: GlobalKey(),
        value: key
            .toString()
            .substring(key.toString().length - 7, key.toString().length - 1),
      ),
    );
    attributes.add(
      Attribute(key: GlobalKey(), value: outgoingConnections.length.toString()),
    );
    attributes.add(
      Attribute(key: GlobalKey(), value: incomingConnections.length.toString()),
    );
  }

  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.inlne);
  }

  Inline createNewLine() {
    return TextNode(rawText: '');
  }

  @override
  String toString() {
    return "$rawText\n";
  }
}
