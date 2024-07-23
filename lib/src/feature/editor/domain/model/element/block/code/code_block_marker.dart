import 'package:dial_editor/src/feature/editor/domain/model/element/block/code/code_block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/block/code/code_line.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';

class CodeBlockMarker extends Node {
  final bool isStart;

  CodeBlockMarker({
    required super.context,
    required super.rawText,
    required this.isStart,
    required super.parentKey,
    super.regex,
  }) {
    controller.text = rawText;
  }

  @override
  Node createNewLine() {
    return isStart
        ? CodeLine(
            context: super.context,
            language: "c",
            rawText: "",
            parentKey: parentKey,
          )
        : TextNode(
            context: super.context,
            rawText: "",
            parentKey: super.parentKey,
          );
  }

  @override
  Widget render() {
    updateStyle();
    updateTextHeight();
    return Text(rawText, style: style);
  }

  @override
  void updateStyle() {
    style = const TextStyle();
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    text = newText;
    updateStyle();
    updateTextHeight();
  }

  @override
  String toString() {
    return rawText;
  }

  CodeBlock? get parent => null;

  set parent(CodeBlock? parent) {
    this.parent = parent;
  }

  CodeBlockMarker copyWith({
    BuildContext? context,
    bool? isStart,
    String? rawText,
  }) {
    return CodeBlockMarker(
      context: super.context,
      isStart: isStart ?? this.isStart,
      rawText: rawText ?? this.rawText,
      parentKey: parentKey,
    );
  }
}
