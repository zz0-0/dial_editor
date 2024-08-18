/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

base class Quote extends Inline {
  Quote({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.quote);
  }

  @override
  Inline createNewLine() {
    return Quote(rawText: '> ');
  }
}