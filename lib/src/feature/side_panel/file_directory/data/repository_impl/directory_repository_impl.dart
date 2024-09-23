import 'dart:io';

import 'package:dial_editor/src/feature/side_panel/file_directory/data/data_source/directory_local_data_source.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/repository/directory_repository.dart';
import 'package:flutter/material.dart';

/// Implementation of the [DirectoryRepository] interface.
///
/// This class provides the concrete implementation for the methods defined
/// in the [DirectoryRepository] interface, handling the data operations
/// related to the file directory.
///
/// The implementation details include interactions with the underlying
/// data sources, such as local file systems or remote storage, to manage
/// directory-related data.
///
/// This class is part of the side panel feature in the application.
class DirectoryRepositoryImpl implements DirectoryRepository {
  /// Implementation of the DirectoryRepository interface.
  ///
  /// This class provides the concrete implementation for managing directory
  /// operations such as reading, writing, and manipulating directory
  /// structures.
  ///
  /// The [DirectoryRepositoryImpl] constructor initializes the repository with
  /// necessary dependencies and configurations.
  DirectoryRepositoryImpl({
    this.localDataSource,
  });

  /// A local data source for directory-related operations.
  ///
  /// This data source is used to interact with the local storage
  /// for directory-related data. It can be `null` if no local
  /// data source is provided.
  final DirectoryLocalDataSource? localDataSource;

  @override
  Future<List<DirectoryNode>> getDirectory() async {
    final entities = await localDataSource!.getFileSystemEntityDirectory();

    return parseFileSystemEntity(entities);
  }

  @override
  Future<List<FileSystemEntity>> getFileSystemEntityDirectory() async {
    return localDataSource!.getFileSystemEntityDirectory();
  }

  @override
  Future<FileSystemEntity> getFileSystemEntity() async {
    return localDataSource!.getFileSystemEntity();
  }

  @override
  Future<void> createNewFile() async {
    return localDataSource!.createNewFile();
  }

  /// A set to store unique file paths as strings.
  ///
  /// This set ensures that each file path is stored only once, preventing
  /// duplicates.
  final uniquePaths = <String>{};

  /// Parses a list of [FileSystemEntity] objects and converts them into a list
  /// of [DirectoryNode] objects.
  ///
  /// This method takes a list of file system entities, which can include files
  /// and directories,
  /// and processes them to create a corresponding list of directory nodes.
  /// Each directory node
  /// represents a file or directory in the file system.
  ///
  /// - Parameter entities: A list of [FileSystemEntity] objects to be parsed.
  /// - Returns: A list of [DirectoryNode] objects representing the parsed file
  /// system entities.
  List<DirectoryNode> parseFileSystemEntity(List<FileSystemEntity> entities) {
    final rootNode = <DirectoryNode>[];

    for (final entity in entities) {
      if (entity is Directory) {
        final children = parseFileSystemEntity(entity.listSync());
        final segments = entity.uri.pathSegments;
        final content = segments[segments.length - 2];
        final currentNode = DirectoryNode(
          key: GlobalKey(),
          isDirectory: true,
          path: entity.path,
          content: content,
          children: children,
        );
        uniquePaths.add(entity.path);
        rootNode.add(currentNode);
      } else {
        if (!uniquePaths.contains(entity.path)) {
          uniquePaths.add(entity.path);
          final segments = entity.uri.pathSegments;
          final content = segments.last;
          final currentNode = DirectoryNode(
            key: GlobalKey(),
            path: entity.path,
            content: content,
          );
          rootNode.add(currentNode);
        }
      }
    }

    return rootNode;
  }
}
