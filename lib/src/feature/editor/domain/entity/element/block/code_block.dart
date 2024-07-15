import 'package:dial_editor/src/feature/editor/domain/entity/element/block/block.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class CodeBlock extends Block with ChangeNotifier {
  final String? language;
  GlobalKey blockKey;

  CodeBlock({
    required super.context,
    required this.blockKey,
    this.language,
    super.children,
  }) : super(rawText: '') {
    if (children!.isNotEmpty) {
      super.rawText = children!.map((code) => code).join("\n");
      controller.text = rawText;
    }
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
    final theme = Theme.of(super.context);
    style = TextStyle(
      fontSize: theme.textTheme.titleSmall!.fontSize,
    );
  }

  @override
  Node createNewLine() {
    return TextNode(context: super.context, rawText: '');
  }

  Widget _buildRichText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children!.map((code) => code.render()).toList(),
    );
  }

  CodeBlock copyWith({
    String? language,
    List<Node>? children,
  }) {
    return CodeBlock(
      context: super.context,
      blockKey: key,
      language: language ?? this.language,
      children: children ?? this.children,
    );
  }
}
