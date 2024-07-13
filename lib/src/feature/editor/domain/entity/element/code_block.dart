import 'package:dial_editor/src/feature/editor/domain/entity/element/code_line.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighting/flutter_highlighting.dart';
import 'package:flutter_highlighting/themes/github.dart';

class CodeBlock extends Node {
  final String language;
  final List<CodeLine> lines;

  CodeBlock(BuildContext context, this.language, this.lines)
      : super(context, lines.map((line) => line.rawText).join('\n'));

  @override
  Widget render() {
    updateStyle();
    updateTextHeight();
    return _buildRichText();
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    updateStyle();
    updateTextHeight();
  }

  @override
  String toString() {
    return rawText;
  }

  @override
  void updateStyle() {
    final theme = Theme.of(context);
    style = TextStyle(
      fontSize: theme.textTheme.titleSmall!.fontSize,
    );
  }

  @override
  Node createNewLine() {
    return TextNode(context, '');
  }

  Widget _buildRichText() {
    return HighlightView(
      rawText,
      // languageId: dart.id,
      theme: githubTheme,
      padding: const EdgeInsets.all(12),
      textStyle: style,
    );
  }
}
