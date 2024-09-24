import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileMetadataStateNotifer extends StateNotifier<List<FileMetadata>> {
  FileMetadataStateNotifer(this.ref, this.uuid) : super([]) {
    getFileMetadata();
  }
  Ref ref;
  String uuid;
  Future<void> getFileMetadata() async {
    final metadata = <FileMetadata>[];
    final getFileMetadataUseCase =
        await ref.read(getFileMetadataUseCaseProvider.future);
    final data = await getFileMetadataUseCase(uuid);
    metadata.add(data);
    state = metadata;
  }
}
