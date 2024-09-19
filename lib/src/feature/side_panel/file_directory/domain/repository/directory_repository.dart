import 'dart:io';

import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';

abstract class DirectoryRepository {
  Future<List<DirectoryNode>> getDirectory();
  Future<List<FileSystemEntity>> getFileSystemEntityDirectory();
  Future<FileSystemEntity> getFileSystemEntity();
  Future<void> createNewFile();
}
