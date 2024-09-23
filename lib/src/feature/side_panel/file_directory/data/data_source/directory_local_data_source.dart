import 'dart:io';
import 'package:dial_editor/src/core/provider/ui/editor_provder.dart';
import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// An abstract class that defines the contract for local data source operations
/// related to directory management. Implementations of this class should
/// provide
/// concrete methods to handle directory-related data storage and retrieval
/// operations locally.
abstract class DirectoryLocalDataSource {
  /// Retrieves a list of file system entities from the directory.
  ///
  /// This method returns a [Future] that completes with a list of
  /// [FileSystemEntity] objects representing the contents of the directory.
  ///
  /// Returns:
  ///   A [Future] that completes with a list of [FileSystemEntity] objects.
  Future<List<FileSystemEntity>> getFileSystemEntityDirectory();

  /// Retrieves a [FileSystemEntity] from the local directory.
  ///
  /// This method is used to access a file or directory entity from the local
  /// file system. The returned [FileSystemEntity] can represent a file,
  /// directory, or link.
  ///
  /// Returns a [Future] that completes with the [FileSystemEntity].
  Future<FileSystemEntity> getFileSystemEntity();

  /// Creates a new file in the local directory.
  ///
  /// This method is responsible for creating a new file within the specified
  /// local directory. It does not take any parameters and returns a [Future]
  /// that completes when the file creation process is finished.
  ///
  /// Throws an [Exception] if the file creation fails.
  Future<void> createNewFile();
}

/// Implementation of the [DirectoryLocalDataSource] interface that provides
/// local data source functionalities for managing directories.
///
/// This class is responsible for handling all the local data operations
/// related to directories, such as reading, writing, and updating directory
/// information in the local storage.
class DirectoryLocalDataSourceImpl implements DirectoryLocalDataSource {
  /// Implementation of the local data source for directory operations.
  ///
  /// This class is responsible for handling local file system operations
  /// related to directories. It uses a reference to perform its tasks.
  ///
  /// [ref] - A reference used for directory operations.
  DirectoryLocalDataSourceImpl(this.ref);

  /// A reference to the [Ref] object used within the local data source.
  /// This is likely used to manage or access some form of state or dependency
  /// injection within the application.
  Ref ref;

  @override
  Future<List<FileSystemEntity>> getFileSystemEntityDirectory() async {
    final path = await Future.delayed(Duration.zero, getDirectoryPath);

    final dir = Directory(path!);
    final files = dir.listSync(recursive: true);

    return files;
  }

  @override
  Future<FileSystemEntity> getFileSystemEntity() async {
    final xfile = await Future.delayed(Duration.zero, openFile);
    return File(xfile!.path);
  }

  @override
  Future<void> createNewFile() async {
    final file =
        File('/data/user/0/com.example.dial_editor/app_flutter/test.md');
    await file.writeAsString('hello world!');

    ref.read(fileProvider.notifier).update((state) => file);
    ref.read(openedFilesProvider.notifier).addFile(file.path);
  }
}
