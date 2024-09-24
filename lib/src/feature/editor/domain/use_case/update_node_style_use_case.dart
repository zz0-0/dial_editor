import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:flutter/material.dart';

class UpdateNodeStyleUseCase {
  UpdateNodeStyleUseCase();
  void call(Inline node, TextStyle newStyle) {
    node.style = newStyle;
  }
}
