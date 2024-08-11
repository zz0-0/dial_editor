import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';

class UnorderedList extends Block {
  UnorderedList({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.boldItalic);
  }
}
