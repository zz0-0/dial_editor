/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

base class TaskListNode extends Inline {
  TaskListNode({required super.rawText});

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.taskListNode);
  }

  @override
  Inline createNewLine() {
    return TaskListNode(rawText: "- [ ] ");
  }
}