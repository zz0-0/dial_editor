import 'package:flutter/material.dart';

class Connection {
  GlobalKey sourceDocumentKey;
  GlobalKey targetDocumentKey;
  GlobalKey connectionKey;
  GlobalKey sourceFileNodeKey;
  GlobalKey targetFileNodeKey;

  Connection({
    required this.sourceDocumentKey,
    required this.targetDocumentKey,
    required this.connectionKey,
    required this.sourceFileNodeKey,
    required this.targetFileNodeKey,
  });
}
