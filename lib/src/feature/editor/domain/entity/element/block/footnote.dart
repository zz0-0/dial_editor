import 'package:dial_editor/src/feature/editor/domain/entity/element/block/block.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class Footnote extends Block {
  Footnote(super.context, super.rawText);

  @override
  Node createNewLine() {
    // TODO: implement createNewLine
    throw UnimplementedError();
  }

  @override
  Widget render() {
    // TODO: implement render
    throw UnimplementedError();
  }

  @override
  void updateStyle() {
    // TODO: implement updateStyle
  }

  @override
  void updateText(String newText) {
    // TODO: implement updateText
  }
}
