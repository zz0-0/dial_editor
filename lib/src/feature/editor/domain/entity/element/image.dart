import 'dart:io';

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
    final match = imageRegex.firstMatch(text);
    if (match != null) {
      linkText = match.group(1) ?? '';
      url = match.group(2) ?? '';
    } else {
      url = text.trim();
    }
  }

  Widget _buildImage() {
    final match1 = imageUrlPathRegex.firstMatch(url);
    final match2 = imageFilePathRegex.firstMatch(url);

    if (match1 != null) {
      return Image.network(
        url,
        errorBuilder: (context, error, stackTrace) {
          return Text(
            stackTrace.toString(),
            style: const TextStyle(color: Colors.red),
          );
        },
      );
    } else if (match2 != null) {
      return Image.file(
        File(url),
        errorBuilder: (context, error, stackTrace) {
          return Text(
            stackTrace.toString(),
            style: const TextStyle(color: Colors.red),
          );
        },
      );
    }
    return Container();
  }
}
