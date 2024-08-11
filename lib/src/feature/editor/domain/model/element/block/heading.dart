import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';

class Heading extends Block {
  int level = 1;

  Heading({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.heading);
  }
}
