import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';

class UpdateNodeStyleUseCase {
  UpdateNodeStyleUseCase();

  void update(Node node, TextStyle newStyle) {
    node.style = newStyle;
  }
}
