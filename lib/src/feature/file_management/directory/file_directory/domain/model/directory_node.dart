import 'package:flutter/material.dart';

class DirectoryNode {
  Key? key;
  bool isDirectory;
  String? path;
  String? content;
  List<DirectoryNode> children;

  DirectoryNode({
    this.key,
    this.isDirectory = false,
    this.path,
    this.content,
    this.children = const [],
  });

  @override
  String toString() {
    return "DirectoryNode, key:$key, isDirectory:$isDirectory, path:$path, content:$content, children:$children";
  }
}
