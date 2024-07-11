import 'dart:convert';

import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class ImageNode extends Node {
  final String altText;
  final String url;

  ImageNode(super.context, super.rawText, this.url, this.altText) {
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
    return ImageNode(context, "", "", "");
  }

  Widget _buildImage() {
    if (url.startsWith('data:image')) {
      // This is a base64 image
      final bytes = base64Decode(url.split(',')[1]);
      return Image.memory(
        bytes,
        errorBuilder: (context, error, stackTrace) {
          return const Text(
            'Image not found',
            style: TextStyle(color: Colors.red),
          );
        },
      );
    } else {
      // This is a regular URL
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

  @override
  String toString() {
    return '![$altText]($url)';
  }
}
