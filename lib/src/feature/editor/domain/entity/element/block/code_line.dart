import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/dark.dart';
import 'package:flutter_highlighter/themes/github.dart';

class CodeLine extends Node {
  final String? language;

  CodeLine({
    required super.context,
    required this.language,
    required super.rawText,
  }) {
    controller.text = rawText;
  }

  @override
  Node createNewLine() {
    return CodeLine(
      context: context,
      language: language,
      rawText: "",
    );
  }

  @override
  Widget render() {
    updateStyle();
    updateTextHeight();
    final theme = Theme.of(context);

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
}
