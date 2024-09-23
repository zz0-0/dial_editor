/// Enum representing the different types of markdown elements that can be used
/// within the markdown editor. Each value corresponds to a specific markdown
/// syntax or feature.
enum MarkdownElement {
  /// Enum representing various types of elements in the markdown editor domain.
  ///
  /// The elements include:
  /// - `document`: Represents the entire document.

  document,

  /// - `node`: A generic node element.
  node,

  /// - `block`: A block-level element.
  block,

  /// - `inline`: An inline-level element.
  inline,

  /// - `headingBlock`: A block-level heading.
  headingBlock,

  /// - `heading`: An inline heading.
  heading,

  /// - `orderedListBlock`: A block-level ordered list.
  orderedListBlock,

  /// - `orderedListNode`: A node within an ordered list.
  orderedListNode,

  /// - `taskListBlock`: A block-level task list.
  taskListBlock,

  /// - `taskListNode`: A node within a task list.
  taskListNode,

  /// - `unorderedListBlock`: A block-level unordered list.
  unorderedListBlock,

  /// - `unorderedListNode`: A node within an unordered list.
  unorderedListNode,

  /// - `boldItalic`: Text that is both bold and italic.
  boldItalic,

  /// - `bold`: Bold text.
  bold,

  /// - `emoji`: An emoji character.
  emoji,

  /// - `highlight`: Highlighted text.
  highlight,

  /// - `horizontalRule`: A horizontal rule.
  horizontalRule,

  /// - `image`: An image element.
  image,

  /// - `italic`: Italic text.
  italic,

  /// - `link`: A hyperlink.
  link,

  /// - `mathBlock`: A block-level mathematical expression.
  mathBlock,

  /// - `math`: An inline mathematical expression.
  math,

  /// - `strikethrough`: Text with a strikethrough.
  strikethrough,

  /// - `subscript`: Subscript text.
  subscript,

  /// - `text`: Plain text.
  text,

  /// - `quoteBlock`: A block-level quote.
  quoteBlock,

  /// - `quote`: An inline quote.
  quote,

  /// - `superscript`: Superscript text.
  superscript,

  /// - `codeBlock`: A block-level code snippet.
  codeBlock,

  /// - `codeBlockMarker`: A marker for a code block.
  codeBlockMarker,

  /// - `codeLine`: A single line of code.
  codeLine;
}

/// Extension on the `MarkdownElement` class to provide additional functionality
/// specific to Markdown elements. This extension can include methods, getters,
/// or other utilities that enhance the capabilities of `MarkdownElement`
/// instances.
extension MarkdownElementExtension on MarkdownElement {
  /// Returns the type of the element as a [String].
  String get type {
    switch (this) {
      case MarkdownElement.document:
        return 'document';
      case MarkdownElement.node:
        return 'node';
      case MarkdownElement.block:
        return 'block';
      case MarkdownElement.inline:
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
    }
  }
}

/// An abstract class representing a render instruction.
///
/// This class serves as a base for all render instructions that can be used
/// in the editor domain model. Subclasses should provide specific
/// implementations for different types of render instructions.
abstract class RenderInstruction {}

/// A class that represents the instructions for rendering text elements.
///
/// This class extends the [RenderInstruction] class and provides specific
/// instructions for rendering text within the editor domain.
///
/// Example usage:
///
/// ```dart
/// TextRenderInstruction instruction = TextRenderInstruction();
/// // Use the instruction object to render text elements
/// ```
///
/// See also:
/// - [RenderInstruction], which is the base class for rendering instructions.
class TextRenderInstruction extends RenderInstruction {
  /// Constructs a [TextRenderInstruction] with the given text and formatting.
  ///
  /// The [text] parameter specifies the text content to be rendered.
  /// The [formatting] parameter specifies the formatting to be applied to the 
  /// text.
  TextRenderInstruction(this.text, this.formatting);

  /// The text content of the element.
  final String text;

  /// Represents a Markdown element used for formatting within the editor.
  /// This element defines the specific formatting style to be applied.
  final MarkdownElement formatting;
}
