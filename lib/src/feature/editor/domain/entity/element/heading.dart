import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';

class Heading extends Node {
  int level;

  Heading(this.level, String text) : super(text);
}
