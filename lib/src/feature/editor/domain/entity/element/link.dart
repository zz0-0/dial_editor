import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Link extends Node {
  Link(super.context, super.rawText) {
    controller.text = _convertToMarkdownLink(rawText);
  }

  @override
  Widget render() {
    updateStyle();
    updateTextHeight();
    return _buildLink();
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    text = _convertToMarkdownLink(newText);
    updateStyle();
    updateTextHeight();
  }

  @override
  void updateStyle() {
    final theme = Theme.of(context);
    style = TextStyle(
      fontSize: theme.textTheme.bodyMedium!.fontSize,
      color: Colors.blue,
      decoration: TextDecoration.underline,
    );
  }

  @override
  Node createNewLine() {
    return Link(context, "");
  }

  Widget _buildLink() {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrlString(text)) {
          await launchUrlString(text);
        }
      },
      child: Text(
        rawText,
        style: style,
      ),
    );
  }

  String _convertToMarkdownLink(String text) {
    final linkRegex = RegExp(r'https?:\/\/[^\s\)]+');
    return text.replaceAllMapped(linkRegex, (match) {
      final url = match.group(0)!;
      return '[]($url)';
    });
  }

  @override
  String toString() {
    return '[]($text)';
  }
}
