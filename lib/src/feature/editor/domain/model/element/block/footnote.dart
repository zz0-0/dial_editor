import 'package:dial_editor/src/feature/editor/domain/model/element/block/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';

class Footnote extends Block {
  Footnote({
    required super.context,
    required super.rawText,
    required super.children,
    required super.blockKey,
    required super.parentKey,
    required super.regex,
  }) {
    controller.text = rawText;
  }

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
