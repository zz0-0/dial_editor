import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';

abstract class Inline extends Node {
  Inline({required super.rawText});

  @override
  RenderInstruction render();
}
