import 'dart:io';

import 'package:dial_editor/src/feature/editor/data/datasource/local_file_data_source.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/file_repository.dart';

class FileRepositoryImpl implements FileRepository {
  final Localfiledatasource localfiledatasource;

  FileRepositoryImpl(this.localfiledatasource);

  @override
  File getFile() {
    return localfiledatasource.getFile();
  }
}
