import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class OrderedList extends Node {
  OrderedList(super.context, super.rawText);

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
}
