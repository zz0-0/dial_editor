import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';

class Document {
  List<Node> children;

  Document({required this.children});

  @override
  String toString() {
    return children.map((e) => e.toString()).toList().join("\n");
  }
}
