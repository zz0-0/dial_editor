/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

base class OrderedListNode extends Inline {
  OrderedListNode({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.orderedListNode);
  }

  @override
  Inline createNewLine() {
    final match = orderListRegex.firstMatch(rawText);
    if (match != null) {
      final currentNumber =
          int.tryParse(match.group(0)!.trim().replaceFirst('.', '')) ?? 0;
      final newNumber = currentNumber + 1;
      return OrderedListNode(
        rawText: "$newNumber. ",
      );
    }
    return OrderedListNode(
      rawText: "1. ",
    );
  }
}
