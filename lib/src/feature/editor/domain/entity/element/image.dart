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

  @override
  String toString() {
    return '![$altText]($url)';
  }
}
