import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';

abstract class Block extends Node {
  List<Node> children = [];

  Block({required super.rawText});

  @override
  RenderInstruction render();
}
