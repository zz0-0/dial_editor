import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';

class OrderedList extends Block {
  OrderedList({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.boldItalic);
  }
}
