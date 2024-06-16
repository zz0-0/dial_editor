import 'dart:io';

import 'package:file_selector/file_selector.dart';

abstract class DirectoryLocalDataSource {
  Future<List<FileSystemEntity>> getFileSystemEntity();
}

class DirectoryLocalDataSourceImpl implements DirectoryLocalDataSource {
  @override
  Future<List<FileSystemEntity>> getFileSystemEntity() async {
    final path = await Future.delayed(Duration.zero, () {
      return getDirectoryPath();
    });

    final dir = Directory(path!);
    final files = dir.listSync(recursive: true);

    return files;
  }
}
