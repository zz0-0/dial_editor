/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

/// A class representing a line of code within an inline element.
/// 
/// This class extends the `Inline` class and is used to model a single line
/// of code in the context of a larger document or editor.
/// 
/// Example usage:
/// 
/// ```dart
/// CodeLine codeLine = CodeLine();
/// ```
/// 
/// This class can be extended or used as-is to represent code lines in
/// various text processing or editor applications.
base class CodeLine extends Inline {
  /// Represents a line of code within a code block in the editor.
  /// 
  /// This class is used to encapsulate the properties and behaviors
  /// of a single line of code, which can be part of a larger code
  /// block element in the editor.
  /// 
  /// Example usage:
  /// 
  /// ```dart
  /// CodeLine(
  ///   // initialization parameters
  /// );
  /// ```
  /// 
  /// Properties:
  /// - Add relevant properties here
  /// 
  /// Methods:
  /// - Add relevant methods here
  CodeLine({
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
    type = MarkdownElement.codeLine.type;
  }
  /// Creates a `CodeLine` instance from a map.
  ///
  /// The [map] parameter should contain the necessary key-value pairs
  /// to initialize the `CodeLine` object.
  ///
  /// Returns a `CodeLine` object.
  factory CodeLine.fromMap(Map<String, dynamic> map) {
    return CodeLine(
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
  Inline createNewLine() {
    return CodeLine(
      key: super.key,
      rawText: '',
    );
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.codeLine);
  }
}
