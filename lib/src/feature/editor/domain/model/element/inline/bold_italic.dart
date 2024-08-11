import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/text.dart';

class BoldItalic extends Inline {
  BoldItalic({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.boldItalic);
  }

  @override
  Inline createNewLine() {
    return TextNode(rawText: '');
  }
}
