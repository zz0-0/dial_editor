import 'dart:io';
import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class FileLocalDataSource {
  Future<File> readFile();
  Future<void> writeFile(String content);
}

class FileLocalDataSourceImpl implements FileLocalDataSource {
  FileLocalDataSourceImpl(this.ref);
  Ref ref;
  @override
  Future<File> readFile() async {
    return await ref.read(fileProvider)!;
  }

  @override
  Future<void> writeFile(String content) async {
    return ref.read(fileProvider)!.writeAsStringSync(content);
  }
}
