import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class UnorderedList extends Node {
  UnorderedList(super.context, super.rawText);

  @override
  Widget render() {
    // TODO: implement render
    throw UnimplementedError();
  }

  @override
  void updateText(String newText) {
    // TODO: implement updateText
    updateStyle();
  }

  @override
  void updateStyle() {
    // TODO: implement updateStyle
  }

  @override
  Node createNewLine() {
    // TODO: implement createNewLine
    throw UnimplementedError();
  }
}
