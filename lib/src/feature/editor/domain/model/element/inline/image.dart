/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing an inline image node in the editor.
/// 
/// This class extends the `Inline` class and is used to handle image elements
/// within the editor's content.
/// 
/// Example usage:
/// 
/// ```dart
/// ImageNode imageNode = ImageNode();
/// ```
/// 
/// Note: Ensure that the image source and other relevant properties are set
/// appropriately for the image to be rendered correctly.
base class ImageNode extends Inline {
  /// Represents an inline image node within the editor.
  ///
  /// This class is used to define an image element that can be embedded
  /// within the text content of the editor. It contains properties and
  /// methods to manage the image's attributes and behavior.
  ///
  /// Example usage:
  /// ```dart
  /// ImageNode(
  ///   url: 'https://example.com/image.png',
  ///   altText: 'Example Image',
  /// )
  /// ```
  ///
  /// Properties:
  /// - `url`: The URL of the image.
  /// - `altText`: The alternative text for the image.
  ///
  /// Methods:
  /// - `toJson()`: Converts the image node to a JSON representation.
  /// - `fromJson(Map<String, dynamic> json)`: Creates an image node from a 
  /// JSON 
  /// representation.
  ImageNode({
    required super.key,
    required super.rawText,
    super.parentKey,
    super.text,
    super.textHeight,
    super.isBlockStart,
    super.isEditing,
    super.isExpanded,
    super.depth,
  }) {
    type = MarkdownElement.image.type;
  }
  /// Creates an instance of [ImageNode] from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to initialize the properties of the [ImageNode].
  ///
  /// Returns an [ImageNode] object.
  factory ImageNode.fromMap(Map<String, dynamic> map) {
    return ImageNode(
      key: GlobalKey(debugLabel: map['key'] as String),
      parentKey: map['parentKey'] != null
          ? GlobalKey(debugLabel: map['parentKey'] as String)
          : null,
      rawText: map['rawText'] as String,
      text: map['text'] as String,
      textHeight: map['textHeight'] as double?,
      isBlockStart: map['isBlockStart'] as bool,
      isEditing: map['isEditing'] as bool,
      isExpanded: map['isExpanded'] as bool,
      depth: map['depth'] as int,
    );
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.image);
  }
}
