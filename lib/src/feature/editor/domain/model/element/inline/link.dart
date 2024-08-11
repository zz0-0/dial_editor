import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';

class Link extends Inline {
  Link({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.link);
  }
}
