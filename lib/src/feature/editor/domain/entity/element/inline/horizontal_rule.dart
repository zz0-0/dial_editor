import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class HorizontalRule extends Inline {
  HorizontalRule(super.context, super.rawText) {
    controller.text = rawText;
  }

  @override
  Widget render() {
    return _buildHorizontalRule();
  }

  @override
  void updateText(String newText) {}

  @override
  void updateStyle() {}

  @override
  Node createNewLine() {
    return TextNode(context, "");
  }

  @override
  String toString() {
    return '---';
  }

  Widget _buildHorizontalRule() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Theme.of(context).dividerColor,
    );
  }
}
