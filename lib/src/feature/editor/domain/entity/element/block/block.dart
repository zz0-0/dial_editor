import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';

abstract class Block extends Node {
  Block(super.context, super.rawText, [super.style, super.text]);
}
