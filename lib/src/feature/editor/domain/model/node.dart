/// library for markdown element
library node;

import 'dart:collection';

import 'package:dial_editor/src/feature/connection/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/attribute.dart';
import 'package:flutter/material.dart';

base class Node extends LinkedListEntry<Node> {
  late GlobalKey documentKey;
  GlobalKey<EditableTextState> key = GlobalKey<EditableTextState>();
  GlobalKey<EditableTextState>? parentKey;
  List<Attribute> attributes = [];
  List<Connection> outgoingConnections = [];
  List<Connection> incomingConnections = [];

  Node() {
    attributes.add(
      Attribute(
        key: GlobalKey(),
        value: key
            .toString()
            .substring(key.toString().length - 7, key.toString().length - 1),
      ),
    );
    attributes.add(
      Attribute(key: GlobalKey(), value: outgoingConnections.length.toString()),
    );
    attributes.add(
      Attribute(key: GlobalKey(), value: incomingConnections.length.toString()),
    );
  }
}
