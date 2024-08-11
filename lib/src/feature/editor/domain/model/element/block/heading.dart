import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';

class Heading extends Block {
  int level = 1;

  Heading({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.heading);
  }

  @override
  Node createNewLine() {
    return TextNode(rawText: '');
  }
}
