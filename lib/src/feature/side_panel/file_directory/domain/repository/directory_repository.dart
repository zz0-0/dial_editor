import 'dart:io';

import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';

/// An abstract class that defines the contract for a directory repository.
///
/// This repository is responsible for handling operations related to
/// directories within the file system. Implementations of this class
/// should provide concrete methods to manage directory-related tasks
/// such as creating, reading, updating, and deleting directories.
abstract class DirectoryRepository {
  /// Retrieves a list of directory nodes.
  ///
  /// This method fetches the directory structure and returns a list of
  /// [DirectoryNode] objects representing the nodes in the directory.
  ///
  /// Returns:
  ///   A [Future] that completes with a list of [DirectoryNode] objects.
  Future<List<DirectoryNode>> getDirectory();

  /// Retrieves a list of file system entities within a directory.
  ///
  /// This method returns a [Future] that completes with a list of
  /// [FileSystemEntity] objects representing the contents of a directory.
  ///
  /// Returns:
  ///   A [Future] that resolves to a [List] of [FileSystemEntity] objects.
  Future<List<FileSystemEntity>> getFileSystemEntityDirectory();

  /// Retrieves a file system entity.
  ///
  /// This method is responsible for fetching a [FileSystemEntity] which can be
  /// a file, directory, or link within the file system.
  ///
  /// Returns a [Future] that completes with the retrieved [FileSystemEntity].
  ///
  /// Throws an exception if the entity cannot be retrieved.
  Future<FileSystemEntity> getFileSystemEntity();

  /// Creates a new file in the directory repository.
  ///
  /// This method is asynchronous and returns a [Future] that completes
  /// when the file creation process is finished.
  ///
  /// Throws an exception if the file creation fails.
  Future<void> createNewFile();
}
