import 'dart:io';

import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class FileLocalDataSource {
  File getFile();
  void saveFile(String content);
}

class FileLocalDataSourceImpl implements FileLocalDataSource {
  Ref ref;

  FileLocalDataSourceImpl(this.ref);

  @override
  File getFile() {
    return ref.read(fileProvider)!;
  }

  @override
  void saveFile(String content) {
    ref.read(fileProvider)!.writeAsStringSync(content);
  }
}
