import 'dart:io';

import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class FileLocalDataSource {
  File readFile();
  void writeFile(String content);
}

class FileLocalDataSourceImpl implements FileLocalDataSource {
  Ref ref;

  FileLocalDataSourceImpl(this.ref);

  @override
  File readFile() {
    return ref.read(fileProvider)!;
  }

  @override
  void writeFile(String content) {
    ref.read(fileProvider)!.writeAsStringSync(content);
  }
}
