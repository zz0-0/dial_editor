import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';

abstract class NodeRepository {
  List<Node> convertDocument(List<String> lines);
  Inline convert(String input);
}
