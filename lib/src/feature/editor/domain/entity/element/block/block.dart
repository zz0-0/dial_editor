import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';

abstract class Block extends Node {
  List<Node>? children;

  Block({
    required super.context,
    required super.rawText,
    this.children,
    super.style,
    super.text,
  });
}
