import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/file_meta_repository.dart';

class GetFileMetadataUseCase {
  final FileMetaRepository repository;

  GetFileMetadataUseCase(this.repository);

  Future<FileMetadata> call(String uuid) {
    return repository.fetchFileMetadataFromDatabase(uuid);
  }
}
