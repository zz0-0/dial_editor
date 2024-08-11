import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';

class TaskListNode extends Inline {
  TaskListNode({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.taskListNode);
  }

  @override
  Inline createNewLine() {
    return TaskListNode(
      rawText: "- [ ] ",
    );
  }
}
