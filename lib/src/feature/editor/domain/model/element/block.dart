import 'package:dial_editor/src/feature/editor/domain/model/node.dart';

abstract class Block extends Node {
  List<Node> children = [];

  @override
  String toString() {
    return children.toString();
  }
}
