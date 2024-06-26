import 'package:dial_editor/src/feature/editor/domain/entity/element/heading.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';

class MarkdownParser {
  MarkdownParser() {
    registerParsers();
  }

  Node parseMarkdownLine(String line) {
    return Node.parse(line);
  }
}
