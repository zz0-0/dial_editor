/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A base class representing an inline element in the editor's domain model.
///
/// This class extends the [Node] class and serves as a foundation for all
/// inline elements within the editor. Inline elements are typically parts
/// of text that are styled or behave differently from the surrounding text,
/// such as bold, italic, or links.
base class Inline extends Node {
  /// Represents an inline element within the editor domain model.
  ///
  /// This class is used to define and manage inline elements, which are
  /// typically smaller pieces of content that are part of a larger text
  /// structure, such as a span of text with a specific style or a link.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Inline(
  ///   // parameters
  /// );
  /// ```
  ///
  /// Parameters:
  /// - Add relevant parameters here.
  ///
  /// Note: Provide additional details about the usage and behavior of
  /// the inline elements if necessary.
  Inline({
    required super.key,
    required this.rawText,
    super.parentKey,
    this.text = '',
    this.textHeight,
    this.isBlockStart = false,
    this.isEditing = false,
    this.isExpanded = true,
    this.depth = 0,
  }) {
    controller.text = rawText;
    type = MarkdownElement.inline.type;
  }

  /// The raw text content of the inline element.
  String rawText;

  /// The text content of the inline element.
  String text;

  /// A [TextEditingController] used to control and manage the text being 
  /// edited.
  /// This controller can be used to retrieve the current value of the text 
  /// field,
  /// listen to changes in the text, and manipulate the text programmatically.
  TextEditingController controller = TextEditingController();

  /// A `TextStyle` object that defines the style for text elements.
  ///
  /// This is initialized with a default `TextStyle` instance.
  TextStyle style = const TextStyle();

  /// The height of the text. This value can be null, indicating that the height
  /// is not explicitly set.
  double? textHeight;

  /// A [FocusNode] that is used to manage the focus state of a widget.
  /// This node can be attached to a text field or any other focusable widget
  /// to handle focus events and keyboard interactions.
  FocusNode focusNode = FocusNode();

  /// A flag indicating whether the inline element is currently being edited.
  ///
  /// When `true`, the element is in editing mode; otherwise, it is not.
  bool isEditing = false;

  /// A boolean flag indicating whether the element is expanded or not.
  ///
  /// When `true`, the element is considered to be in an expanded state.
  /// When `false`, the element is not expanded.
  bool isExpanded = true;

  /// Indicates whether the current element is the start of a block.
  ///
  /// This boolean flag is used to determine if the element marks the beginning
  /// of a block-level element in the markdown editor.
  bool isBlockStart = false;

  /// Represents the depth level of an inline element in the editor.
  ///
  /// This value is used to determine the nesting level of the element.
  /// A depth of 0 indicates that the element is at the top level.
  int depth = 0;

  /// Renders the inline element according to its specific instructions.
  ///
  /// This method is responsible for generating the visual representation
  /// of the inline element. The exact rendering logic depends on the type
  /// of the inline element and its associated data.
  ///
  /// Returns a [RenderInstruction] object that contains the necessary
  /// instructions for rendering the element.
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.inline);
  }

  /// Creates a new line element.
  ///
  /// This method is responsible for generating a new instance of an
  /// inline element that represents a new line in the editor.
  ///
  /// Returns:
  ///   An [Inline] object representing the new line.
  Inline createNewLine() {
    return TextNode(key: GlobalKey(), rawText: '');
  }

  @override
  String toString() {
    return '$rawText\n';
  }

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        'rawText': rawText,
        'text': text,
        'textHeight': textHeight,
        'isBlockStart': isBlockStart,
        'isEditing': isEditing,
        'isExpanded': isExpanded,
        'depth': depth,
      };
}
