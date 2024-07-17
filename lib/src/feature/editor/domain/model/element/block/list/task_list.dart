import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';

class TaskList extends Node {
  TaskList({
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
    final bool isCompleted =
        rawText.startsWith('- [x]') || rawText.startsWith('- [X]');
    style = TextStyle(
      fontSize: theme.textTheme.bodyMedium!.fontSize,
      decoration:
          isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  @override
  String toString() {
    return rawText;
  }

  @override
  Node createNewLine() {
    return TaskList(
      context: super.context,
      rawText: "- [ ] ",
      parentKey: super.parentKey,
    );
  }

  Widget _buildRichText() {
    final regex = taskListRegex;
    final matches = regex.firstMatch(rawText);
    if (matches == null) {
      return Text(
        rawText,
        style: style,
      );
    }

    return Text(
      rawText,
      style: style,
    );
  }
}