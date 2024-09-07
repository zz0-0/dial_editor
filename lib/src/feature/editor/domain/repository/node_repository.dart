import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

abstract class NodeRepository {
  (List<String>, Map<String, Node>) convertDocument(List<String> lines);
  Inline convert(String input);
}
