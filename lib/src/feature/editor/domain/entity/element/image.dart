import 'package:dial_editor/src/feature/editor/domain/entity/element/text.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class Image extends Node {
  Image(super.context, super.rawText, String s);

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
    return TextNode(context, "");
  }
}
