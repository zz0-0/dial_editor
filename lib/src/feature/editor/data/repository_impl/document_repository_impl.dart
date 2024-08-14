import 'dart:io';

import 'package:dial_editor/src/feature/editor/data/data_source/file_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/document_codec.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final FileLocalDataSource fileLocalDataSource;

  DocumentRepositoryImpl({required this.fileLocalDataSource});

  @override
  String decode(Document input) {
    final String content = DocumentCodec().decode(input);
    return content;
  }

  @override
  Document encode() {
    final File file = fileLocalDataSource.getFile();
    final String input = file.readAsStringSync();
    return DocumentCodec().encode(input);
  }

  @override
  void save(String input) {
    fileLocalDataSource.saveFile(input);
  }
}
