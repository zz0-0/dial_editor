/// library for markdown element
library node;

import 'dart:collection';

import 'package:flutter/material.dart';

base class Node extends LinkedListEntry<Node> {
  GlobalKey<EditableTextState> key = GlobalKey<EditableTextState>();
  GlobalKey<EditableTextState>? parentKey;
}
