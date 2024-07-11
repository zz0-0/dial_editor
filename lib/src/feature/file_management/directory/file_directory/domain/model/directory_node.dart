import 'package:flutter/material.dart';

class DirectoryNode {
  GlobalKey? key;
  bool isDirectory;
  double dy;
  String? path;
  String? content;
  List<DirectoryNode> children;

  DirectoryNode({
    this.key,
    this.isDirectory = false,
    this.dy = 0,
    this.path,
    this.content,
    this.children = const [],
  });

  DirectoryNode copyWith({double? dy}) {
    return DirectoryNode(
      key: key,
      isDirectory: isDirectory,
      dy: dy ?? this.dy,
      path: path,
      content: content,
      children: children,
    );
  }

  @override
  String toString() {
    return "DirectoryNode, key:$key, isDirectory:$isDirectory, path:$path, content:$content, children:$children";
  }
}
