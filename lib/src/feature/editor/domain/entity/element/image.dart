import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class ImageNode extends Node {
  final String altText;
  final String url;

  ImageNode(super.context, super.rawText, this.url, this.altText);

  @override
  Widget render() {
    return _buildImage();
  }

  @override
  void updateText(String newText) {
    // Image nodes do not have text to update in the same way as other nodes.
    // Implement any necessary logic here if you want to change the image URL or alt text.
  }

  @override
  void updateStyle() {
    // No specific style for image nodes, but you can implement custom styles if needed.
  }

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
