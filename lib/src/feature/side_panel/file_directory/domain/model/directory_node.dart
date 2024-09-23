import 'package:flutter/material.dart';

/// Represents a node in a directory structure.
///
/// This class is used to model the hierarchical structure of directories
/// and files. Each node can represent either a directory or a file, and
/// it can contain child nodes if it is a directory.
class DirectoryNode {
  /// Constructs a [DirectoryNode] with the given parameters.
  DirectoryNode({
    this.key,
    this.isDirectory = false,
    this.dy = 0,
    this.path,
    this.content,
    this.children = const [],
  });

  /// A global key for the directory node.
  GlobalKey? key;

  /// A boolean value indicating whether the node is a directory.
  bool isDirectory;

  /// A double value representing the vertical offset of the node.
  double dy;

  /// A string representing the path of the node.
  String? path;

  /// A string representing the content of the node.
  String? content;

  /// A list of child nodes for the directory node.
  List<DirectoryNode> children;

  /// Creates a copy of the current `DirectoryNode` instance with the specified
  /// properties replaced with the new values.
  ///
  /// The [dy] parameter is optional and, if provided, will replace the current
  /// value of `dy` in the copied instance.
  ///
  /// Returns a new `DirectoryNode` instance with the updated properties.
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
    return 'DirectoryNode, key:$key, isDirectory:$isDirectory, '
        'path:$path, content:$content, children:$children';
  }
}
