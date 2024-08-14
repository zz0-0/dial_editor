/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

base class UnorderedListNode extends Inline {
  UnorderedListNode({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.unorderedListNode);
  }

  @override
  Inline createNewLine() {
    return UnorderedListNode(
      rawText: "- ",
    );
  }
}
