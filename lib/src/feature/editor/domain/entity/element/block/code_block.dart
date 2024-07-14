import 'package:dial_editor/src/feature/editor/domain/entity/element/block/block.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class CodeBlock extends Block {
  final String? language;

  CodeBlock({
    required super.context,
    required this.language,
    required super.children,
  }) : super(rawText: children!.map((code) => code).join("\n")) {
    controller.text = rawText;
  }

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
    return TextNode(context: context, rawText: '');
  }

  Widget _buildRichText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children!.map((code) => code.render()).toList(),
    );
  }
}
