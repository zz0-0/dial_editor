enum MarkdownElement {
  document,
  node,
  block,
  inlne,
  headingBlock,
  heading,
  orderedListBlock,
  orderedListNode,
  taskListBlock,
  taskListNode,
  unorderedListBlock,
  unorderedListNode,
  boldItalic,
  bold,
  emoji,
  highlight,
  horizontalRule,
  image,
  italic,
  link,
  mathBlock,
  math,
  strikethrough,
  subscript,
  text,
  quoteBlock,
  quote,
  superscript,
  codeBlock,
  codeBlockMarker,
  codeLine;
}

extension MarkdownElementExtension on MarkdownElement {
  String get type {
    switch (this) {
      case MarkdownElement.document:
        return 'document';
      case MarkdownElement.node:
        return 'node';
      case MarkdownElement.block:
        return 'block';
      case MarkdownElement.inlne:
        return 'inline';
      case MarkdownElement.headingBlock:
        return 'heading_block';
      case MarkdownElement.heading:
        return 'heading';
      case MarkdownElement.orderedListBlock:
        return 'ordered_list_block';
      case MarkdownElement.orderedListNode:
        return 'ordered_list_node';
      case MarkdownElement.taskListBlock:
        return 'task_list_block';
      case MarkdownElement.taskListNode:
        return 'task_list_node';
      case MarkdownElement.unorderedListBlock:
        return 'unordered_list_block';
      case MarkdownElement.unorderedListNode:
        return 'unordered_list_node';
      case MarkdownElement.boldItalic:
        return 'bold_italic';
      case MarkdownElement.bold:
        return 'bold';
      case MarkdownElement.emoji:
        return 'emoji';
      case MarkdownElement.highlight:
        return 'highlight';
      case MarkdownElement.horizontalRule:
        return 'horizontal_rule';
      case MarkdownElement.image:
        return 'image';
      case MarkdownElement.italic:
        return 'italic';
      case MarkdownElement.link:
        return 'link';
      case MarkdownElement.mathBlock:
        return 'math_block';
      case MarkdownElement.math:
        return 'math';
      case MarkdownElement.strikethrough:
        return 'strikethrough';
      case MarkdownElement.subscript:
        return 'subscript';
      case MarkdownElement.text:
        return 'text';
      case MarkdownElement.quoteBlock:
        return 'quote_block';
      case MarkdownElement.quote:
        return 'quote';
      case MarkdownElement.superscript:
        return 'superscript';
      case MarkdownElement.codeBlock:
        return 'code_block';
      case MarkdownElement.codeBlockMarker:
        return 'code_block_marker';
      case MarkdownElement.codeLine:
        return 'code_line';
      default:
        return 'undefined';
    }
  }
}

abstract class RenderInstruction {}

class TextRenderInstruction extends RenderInstruction {
  final String text;
  final MarkdownElement formatting;
  TextRenderInstruction(this.text, this.formatting);
}
