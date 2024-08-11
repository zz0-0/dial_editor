import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';

class TaskList extends Block {
  TaskList({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.boldItalic);
  }
}
