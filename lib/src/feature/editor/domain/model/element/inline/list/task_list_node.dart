import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';

class TaskListNode extends Inline {
  TaskListNode({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.taskListNode);
  }

  @override
  Node createNewLine() {
    return TaskListNode(
      rawText: "- [ ] ",
    );
  }
}
