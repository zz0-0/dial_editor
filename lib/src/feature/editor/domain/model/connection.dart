import 'package:flutter/material.dart';

class Connection {
  String sourceFilePath;
  String targetFilePath;
  GlobalKey sourceFileNodeKey;
  GlobalKey targetFileNodeKey;

  Connection({
    required this.sourceFilePath,
    required this.targetFilePath,
    required this.sourceFileNodeKey,
    required this.targetFileNodeKey,
  });
}
