import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';
import 'package:flutter/material.dart';

class NodeRepositoryImpl implements NodeRepository {
  @override
  List<Node> convertDocument(GlobalKey key, List<String> lines) {
    final List<Node> children = [];
    OrderedListBlock? currentOrderedListBlock;
    TaskListBlock? currentTaskListBlock;
    UnorderedListBlock? currentUnorderedListBlock;
    CodeBlock? currentCodeBlock;
    HeadingBlock? currentHeadingBlock;
    MathBlock? currentMathBlock;
    QuoteBlock? currentQuoteBlock;
    bool isCodeBlock = false;

    for (final line in lines) {
      final Node node;
      if (isCodeBlock) {
        node = CodeLine(rawText: line);
      } else {
        node = convert(line);
      }
      node.documentKey = key;
      if (node is Heading) {
        if (currentHeadingBlock != null) {
          if (node.level >= currentHeadingBlock.level) {
            children.add(currentHeadingBlock);
            currentHeadingBlock = HeadingBlock(level: node.level);
            currentHeadingBlock.key = GlobalKey();
            node.isBlockStart = true;
            node.parentKey = currentHeadingBlock.key;
            currentHeadingBlock.children.add(node);
          } else {
            node.parentKey = currentHeadingBlock.key;
            currentHeadingBlock.children.add(node);
          }
        } else {
          currentHeadingBlock = HeadingBlock(level: node.level);
          currentHeadingBlock.key = GlobalKey();
          node.isBlockStart = true;
          node.parentKey = currentHeadingBlock.key;
          currentHeadingBlock.children.add(node);
        }
      } else if (currentHeadingBlock != null) {
        if (node is OrderedListNode) {
          if (currentOrderedListBlock != null) {
            node.parentKey = currentOrderedListBlock.key;
            currentOrderedListBlock.children.add(node);
          } else {
            currentOrderedListBlock = OrderedListBlock();
            currentOrderedListBlock.key = GlobalKey();
            node.isBlockStart = true;
            node.parentKey = currentOrderedListBlock.key;
            currentOrderedListBlock.children.add(node);
            currentHeadingBlock.children.add(currentOrderedListBlock);
          }
        } else if (node is TaskListNode) {
          if (currentTaskListBlock != null) {
            node.parentKey = currentTaskListBlock.key;
            currentTaskListBlock.children.add(node);
          } else {
            currentTaskListBlock = TaskListBlock();
            currentTaskListBlock.key = GlobalKey();
            node.isBlockStart = true;
            node.parentKey = currentTaskListBlock.key;
            currentTaskListBlock.children.add(node);
            currentHeadingBlock.children.add(currentTaskListBlock);
          }
        } else if (node is UnorderedListNode) {
          if (currentUnorderedListBlock != null) {
            node.parentKey = currentUnorderedListBlock.key;
            currentUnorderedListBlock.children.add(node);
          } else {
            currentUnorderedListBlock = UnorderedListBlock();
            currentUnorderedListBlock.key = GlobalKey();
            node.isBlockStart = true;
            node.parentKey = currentUnorderedListBlock.key;
            currentUnorderedListBlock.children.add(node);
            currentHeadingBlock.children.add(currentUnorderedListBlock);
          }
        } else if (node is Math) {
          if (currentMathBlock != null) {
            node.parentKey = currentMathBlock.key;
            currentMathBlock.children.add(node);
          } else {
            currentMathBlock = MathBlock();
            currentMathBlock.key = GlobalKey();
            node.isBlockStart = true;
            node.parentKey = currentMathBlock.key;
            currentMathBlock.children.add(node);
            currentHeadingBlock.children.add(currentMathBlock);
          }
        } else if (node is Quote) {
          if (currentQuoteBlock != null) {
            node.parentKey = currentQuoteBlock.key;
            currentQuoteBlock.children.add(node);
          } else {
            currentQuoteBlock = QuoteBlock();
            currentQuoteBlock.key = GlobalKey();
            node.isBlockStart = true;
            node.parentKey = currentQuoteBlock.key;
            currentQuoteBlock.children.add(node);
            currentHeadingBlock.children.add(currentQuoteBlock);
          }
        } else if (node is CodeBlockMarker) {
          if (isCodeBlock == false) {
            isCodeBlock = true;
            final match = codeBlockRegex.firstMatch(line);
            final String language =
                match!.groupCount >= 1 && match.group(1) != null
                    ? match.group(1)!
                    : 'c';
            currentCodeBlock = CodeBlock();
            currentCodeBlock.key = GlobalKey();
            currentCodeBlock.language = language;
            node.language = language;
            node.isBlockStart = true;
            node.parentKey = currentCodeBlock.key;
            currentCodeBlock.children.add(node);
          } else {
            isCodeBlock = false;
            currentHeadingBlock.children.add(node);
            children.add(currentCodeBlock!);
            currentCodeBlock = null;
          }
        } else if (node is CodeLine) {
          if (currentCodeBlock != null) {
            node.parentKey = currentCodeBlock.key;
            currentCodeBlock.children.add(node);
          }
        } else if (node is CodeBlockMarker && currentCodeBlock != null) {
          children.add(currentCodeBlock);
          currentCodeBlock = null;
        } else {
          (node as Inline).parentKey = currentHeadingBlock.key;
          currentHeadingBlock.children.add(node);
        }
      } else {
        children.add(node);
      }
    }
    if (currentHeadingBlock != null) {
      children.add(currentHeadingBlock);
    }
    // if (currentTaskListBlock != null) {
    //   children.add(currentTaskListBlock);
    // }
    // if (currentUnorderedListBlock != null) {
    //   children.add(currentUnorderedListBlock);
    // }
    // if (currentCodeBlock != null) {
    //   children.add(currentCodeBlock);
    // }
    // if (currentMathBlock != null) {
    //   children.add(currentMathBlock);
    // }
    // if (currentQuoteBlock != null) {
    //   children.add(currentQuoteBlock);
    // }
    return children;
  }

  @override
  Inline convert(String input) {
    if (codeBlockRegex.hasMatch(input)) {
      return CodeBlockMarker(rawText: input);
    } else if (taskListRegex.hasMatch(input)) {
      return TaskListNode(rawText: input);
    } else if (orderListRegex.hasMatch(input)) {
      return OrderedListNode(rawText: input);
    } else if (unorderedListRegex.hasMatch(input)) {
      return UnorderedListNode(rawText: input);
    } else if (headingRegex.hasMatch(input)) {
      return Heading(rawText: input);
    } else if (inlineMathRegex.hasMatch(input)) {
      return Math(rawText: input);
    } else if (quoteRegex.hasMatch(input)) {
      return Quote(rawText: input);
    } else if (boldItalicRegex.hasMatch(input)) {
      return BoldItalic(rawText: input);
    } else if (boldRegex.hasMatch(input)) {
      return Bold(rawText: input);
    } else if (italicRegex.hasMatch(input)) {
      return Italic(rawText: input);
    } else if (highlightRegex.hasMatch(input)) {
      return Highlight(rawText: input);
    } else if (strikethroughRegex.hasMatch(input)) {
      return Strikethrough(rawText: input);
    } else if (imageRegex.hasMatch(input) || imageUrlRegex.hasMatch(input)) {
      return ImageNode(rawText: input);
    } else if (linkRegex.hasMatch(input) || urlRegex.hasMatch(input)) {
      return Link(rawText: input);
    } else if (subscriptRegex.hasMatch(input)) {
      return Subscript(rawText: input);
    } else if (superscriptRegex.hasMatch(input)) {
      return Superscript(rawText: input);
    } else if (horizontalRuleRegex.hasMatch(input)) {
      return HorizontalRule(rawText: input);
    } else if (emojiRegex.hasMatch(input)) {
      return Emoji(rawText: input);
    } else {
      return TextNode(rawText: input);
    }
  }
}
