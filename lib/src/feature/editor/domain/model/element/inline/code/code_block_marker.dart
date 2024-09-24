import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class CodeBlockMarker extends Inline {
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
