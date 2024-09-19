import 'dart:io';
import 'package:dial_editor/src/core/provider/ui/editor_provder.dart';
import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DirectoryLocalDataSource {
  Future<List<FileSystemEntity>> getFileSystemEntityDirectory();
  Future<FileSystemEntity> getFileSystemEntity();
  Future<void> createNewFile();
}

class DirectoryLocalDataSourceImpl implements DirectoryLocalDataSource {
  Ref ref;

  DirectoryLocalDataSourceImpl(this.ref);

  @override
  Future<List<FileSystemEntity>> getFileSystemEntityDirectory() async {
    final path = await Future.delayed(Duration.zero, () {
      return getDirectoryPath();
    });

    final dir = Directory(path!);
    final files = dir.listSync(recursive: true);

    return files;
  }

  @override
  Future<FileSystemEntity> getFileSystemEntity() async {
    final xfile = await Future.delayed(Duration.zero, () {
      return openFile();
    });
    return File(xfile!.path);
  }

  @override
  Future<void> createNewFile() async {
    final File file =
        File('/data/user/0/com.example.dial_editor/app_flutter/test.md');
    await file.writeAsString('hello world!');

    ref.read(fileProvider.notifier).update((state) => file);
    ref.read(openedFilesProvider.notifier).addFile(file.path);
  }
}
