import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';

abstract class FileMetaRepository {
  Future<FileMetadata> fetchFileMetadataFromDatabase(String uuid);
}
