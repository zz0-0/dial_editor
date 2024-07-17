import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';

class OrderedList extends Node {
  OrderedList({
    required super.context,
    required super.rawText,
    required super.parentKey,
  }) {
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
  void updateStyle() {
    final theme = Theme.of(super.context);
    style = TextStyle(
      fontSize: theme.textTheme.titleSmall!.fontSize,
    );
  }

  @override
  String toString() {
    return rawText;
  }

  @override
  Node createNewLine() {
    final regex = orderListRegex;
    final match = regex.firstMatch(rawText);
    if (match != null) {
      final currentNumber =
          int.tryParse(match.group(0)!.trim().replaceFirst('.', '')) ?? 0;
      final newNumber = currentNumber + 1;
      return OrderedList(
        context: super.context,
        rawText: "$newNumber. ",
        parentKey: super.parentKey,
      );
    }
    return OrderedList(
      context: super.context,
      rawText: "1. ",
      parentKey: super.parentKey,
    );
  }

  Widget _buildRichText() {
    return Text(
      rawText,
      style: style,
    );
  }
}
