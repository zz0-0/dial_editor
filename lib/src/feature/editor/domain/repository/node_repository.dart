import 'package:dial_editor/src/feature/editor/domain/model/node.dart';

abstract class NodeRepository {
  List<Node> convertDocument(List<String> lines);
  Node convert(String input);
}
