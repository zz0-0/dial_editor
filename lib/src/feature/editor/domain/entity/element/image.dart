import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';

class ImageNode extends Node {
  String url = "";
  String linkText = "Link";

  ImageNode(super.context, super.rawText) {
    _parseMarkdownLink(rawText);
    controller.text = rawText;
  }

  @override
  Widget render() {
    return _buildImage();
  }

  @override
  void updateText(String newText) {}

  @override
  void updateStyle() {}

  @override
  Node createNewLine() {
    return ImageNode(context, "");
  }

  @override
  String toString() {
    return rawText;
  }

  void _parseMarkdownLink(String text) {
    final match = imageUrlRegex.firstMatch(text);
    if (match != null) {
      linkText = match.group(1) ?? '';
      url = match.group(2) ?? '';
    } else {
      url = text.trim();
    }
  }

  Widget _buildImage() {
    return Image.network(
      url,
      errorBuilder: (context, error, stackTrace) {
        return const Text(
          'Image not found',
          style: TextStyle(color: Colors.red),
        );
      },
    );
  }
}
