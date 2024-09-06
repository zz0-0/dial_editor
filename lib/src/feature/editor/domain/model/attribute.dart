import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:flutter/material.dart';

class Attribute {
  final key = GlobalKey<EditableTextState>();
  Map<GlobalKey, Connection> connections = {};
}
