/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A marker class representing a code block within an inline element.
///
/// This class is used to identify and handle code blocks that appear
/// within inline elements in the editor domain.
///
/// Extends the [Inline] class to inherit common inline element properties
/// and behaviors.
base class CodeBlockMarker extends Inline {
  /// A marker class used to represent the beginning or end of a code block
  /// within the editor's domain model. This class is typically used to
  /// identify and handle code block elements in the editor.
  ///
  /// Example usage:
  /// ```dart
  /// CodeBlockMarker();
  /// ```
  ///
  /// This class does not contain any properties or methods, and serves
  /// primarily as a type identifier for code block elements.
  CodeBlockMarker({
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
    type = MarkdownElement.codeBlockMarker.type;
  }

  /// Creates a [CodeBlockMarker] instance from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to properly initialize a [CodeBlockMarker] object.
  ///
  /// - [map]: A map containing the data to create a [CodeBlockMarker].
  ///
  /// Returns a [CodeBlockMarker] instance populated with the data from the map.
  factory CodeBlockMarker.fromMap(Map<String, dynamic> map) {
    return CodeBlockMarker(
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

  /// The programming language used in the code block.
  ///
  /// This variable holds the language identifier for syntax highlighting
  /// purposes. It is initialized to an empty string, indicating no specific
  /// language is set by default.
  String language = '';

  @override
  Inline createNewLine() {
    if (language.isNotEmpty) {
      return CodeLine(
        key: super.key,
        rawText: '',
      );
    }
    return TextNode(
      key: super.key,
      rawText: '',
    );
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.codeBlockMarker);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'language': language,
    };
  }
}
