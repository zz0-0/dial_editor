import 'dart:io';
import 'package:dial_editor/src/feature/side_panel/file_directory/data/data_source/directory_local_data_source.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/repository/directory_repository.dart';
import 'package:flutter/material.dart';

class DirectoryRepositoryImpl implements DirectoryRepository {
  DirectoryRepositoryImpl({
    this.localDataSource,
  });
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

  final uniquePaths = <String>{};
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
