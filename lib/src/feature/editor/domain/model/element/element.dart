enum MarkdownElement {
  heading,
  orderedListNode,
  taskListNode,
  unorderedListNode,
  boldItalic,
  bold,
  emoji,
  highlight,
  horizontalRule,
  image,
  italic,
  link,
  math,
  strikethrough,
  subscipt,
  superscipt,
  text
}

abstract class RenderInstruction {}

class TextRenderInstruction extends RenderInstruction {
  final String text;
  final MarkdownElement formatting;
  TextRenderInstruction(this.text, this.formatting);
}
