import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';

abstract class Block extends Node {
  List<Node>? children;
  GlobalKey blockKey;

  Block({
    required super.context,
    required super.rawText,
    required this.blockKey,
    this.children,
    super.style,
    super.text,
    super.parentKey,
    super.regex,
  }) {
    controller.text = rawText;
  }
}
