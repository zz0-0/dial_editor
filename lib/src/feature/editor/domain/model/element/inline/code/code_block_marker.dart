/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

base class CodeBlockMarker extends Inline {
  String language = '';

  CodeBlockMarker({required super.rawText});

  @override
  Inline createNewLine() {
    if (language.isNotEmpty) {
      return CodeLine(rawText: '');
    }
    return TextNode(rawText: '');
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.codeBlockMarker);
  }
}
