import 'package:flutter/material.dart';

class Connection {
  GlobalKey sourceDocumentKey;
  GlobalKey targetDocumentKey;
  GlobalKey connectionKey;
  GlobalKey sourceNodeKey;
  GlobalKey targetNodeKey;

  Connection({
    required this.sourceDocumentKey,
    required this.targetDocumentKey,
    required this.connectionKey,
    required this.sourceNodeKey,
    required this.targetNodeKey,
  });
}
