import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:flutter/material.dart';

class UpdateNodeStyleUseCase {
  UpdateNodeStyleUseCase();

  void update(Inline node, TextStyle newStyle) {
    node.style = newStyle;
  }
}
