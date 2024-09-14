import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileMetadataStateNotifer extends StateNotifier<List<FileMetadata>> {
  Ref ref;
  String uuid;

  FileMetadataStateNotifer(this.ref, this.uuid) : super([]) {
    getFileMetadata();
  }

  Future<void> getFileMetadata() async {
    final List<FileMetadata> metadata = [];
    final getFileMetadataUseCase =
        await ref.read(getFileMetadataUseCaseProvider.future);
    final data = await getFileMetadataUseCase(uuid);
    metadata.add(data);
    state = metadata;
  }
}
