import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code_block.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/dark.dart';
import 'package:flutter_highlighter/themes/github.dart';

class CodeLine extends Node with ChangeNotifier {
  final String? language;
  final GlobalKey parentKey;

  CodeLine({
    required super.context,
    required this.language,
    required super.rawText,
    required this.parentKey,
  }) {
    controller.text = rawText;
  }

  @override
  Node createNewLine() {
    return CodeLine(
      context: super.context,
      language: language,
      rawText: "",
      parentKey: parentKey,
    );
  }

  @override
  Widget render() {
    updateStyle();
    updateTextHeight();
    final theme = Theme.of(super.context);

    return HighlightView(
      rawText,
      language: language,
      theme: theme.brightness == Brightness.dark ? darkTheme : githubTheme,
      textStyle: style,
    );
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

  CodeLine copyWith({
    BuildContext? context,
    String? language,
    String? rawText,
  }) {
    return CodeLine(
      context: super.context,
      language: language ?? this.language,
      rawText: rawText ?? this.rawText,
      parentKey: parentKey,
    );
  }
}
