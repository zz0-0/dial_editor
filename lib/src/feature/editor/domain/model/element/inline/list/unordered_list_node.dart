import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';

class UnorderedListNode extends Inline {
  UnorderedListNode({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.unorderedListNode);
  }

  @override
  Node createNewLine() {
    return UnorderedListNode(
      rawText: "- ",
    );
  }
}
