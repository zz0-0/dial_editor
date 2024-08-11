import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/text.dart';

class Heading extends Inline {
  int level = 0;

  Heading({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.heading);
  }

  @override
  Inline createNewLine() {
    return TextNode(rawText: '');
  }
}
