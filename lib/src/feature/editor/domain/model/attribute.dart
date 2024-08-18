import 'package:flutter/material.dart';

class Attribute {
  final GlobalKey key;
  final String value;

  Attribute({required this.key, required this.value});

  @override
  String toString() {
    return '$key="$value"';
  }
}
