import 'package:dial_editor/src/feature/editor/data/repository_impl/regex.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/block/heading.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/bold.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/bold_italic.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/emoji.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/highlight.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/horizontal_rule.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/image.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/italic.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/link.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/list/ordered_list_node.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/list/task_list_node.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/list/unordered_list_node.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/math.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/strikethrough.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/subscript.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/superscript.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/text.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';

class NodeRepositoryImpl implements NodeRepository {
  @override
  List<Node> convertDocument(List<String> lines) {
    final List<Node> children = [];
    Heading? currentHeading;

    for (final line in lines) {
      final Node node = convert(line);
      if (node is Heading) {
        if (currentHeading != null) {
          if (node.level >= currentHeading.level) {
            currentHeading = node;
            children.add(node);
          } else {
            node.parentKey = currentHeading.key;
            currentHeading.children.add(node);
          }
        } else {
          currentHeading = node;
          children.add(node);
        }
      } else if (currentHeading != null) {
        node.parentKey = currentHeading.key;
        currentHeading.children.add(node);
      } else {
        children.add(node);
      }
    }
    return children;
  }

  @override
  Node convert(String input) {
    if (taskListRegex.hasMatch(input)) {
      return TaskListNode(rawText: input);
    } else if (orderListRegex.hasMatch(input)) {
      return OrderedListNode(rawText: input);
    } else if (unorderedListRegex.hasMatch(input)) {
      return UnorderedListNode(rawText: input);
    } else if (headingRegex.hasMatch(input)) {
      return Heading(rawText: input);
    } else if (inlineMathRegex.hasMatch(input)) {
      return Math(rawText: input);
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
