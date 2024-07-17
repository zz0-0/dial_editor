import 'package:dial_editor/src/feature/editor/domain/model/node.dart';

abstract class Inline extends Node {
  Inline({
    required super.context,
    required super.rawText,
    super.style,
    super.text,
    required super.parentKey,
  });
}
