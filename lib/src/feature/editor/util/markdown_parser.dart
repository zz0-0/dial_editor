import 'package:dial_editor/src/feature/editor/domain/entity/element/heading.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';

class MarkdownParser {
  Node parseMarkdownLine(String line) {
    if (RegExp("^#{1,6}").matchAsPrefix(line) != null) {
      final level = line.length - line.replaceAll("#", "").length;
      final text = line.substring(level).trim();
      return Heading(level, text);
    }

    return Heading(1, "");
  }
}
