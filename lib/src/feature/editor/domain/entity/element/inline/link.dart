import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Link extends Inline {
  String url = "";
  String linkText = "Link";

  Link({required super.context, required super.rawText}) {
    _parseMarkdownLink(rawText);
    controller.text = rawText;
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
    _parseMarkdownLink(newText);
    updateStyle();
    updateTextHeight();
  }

  @override
  void updateStyle() {
    final theme = Theme.of(context);
    style = TextStyle(
      fontSize: theme.textTheme.bodyMedium!.fontSize,
      color: Colors.blue,
    );
  }

  @override
  Node createNewLine() {
    return TextNode(context: context, rawText: "");
  }

  @override
  String toString() {
    return rawText;
  }

  Widget _buildLink() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '[$linkText]',
            style: style,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                }
              },
          ),
        ],
      ),
    );
  }

  void _parseMarkdownLink(String text) {
    final match = linkRegex.firstMatch(text);
    if (match != null) {
      linkText = match.group(1) ?? '';
      url = match.group(2) ?? '';
    } else {
      url = text.trim();
    }
  }
}
