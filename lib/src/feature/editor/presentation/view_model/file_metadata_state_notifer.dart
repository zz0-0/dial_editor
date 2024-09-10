import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_file_metadata_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileMetadataStateNotifer extends StateNotifier<List<FileMetadata>> {
  Ref ref;
  String uuid;

  FileMetadataStateNotifer(this.ref, this.uuid) : super([]) {
    getFileMetadata();
  }

  void getFileMetadata() {
    final List<FileMetadata> metadata = [];
    GetFileMetadataUseCase getFileMetadataUseCase;
    ref.watch(getFileMetadataUseCaseProvider).whenData((value) {
      getFileMetadataUseCase = value;
      getFileMetadataUseCase(uuid).then((value) {
        metadata.add(value);
        state = metadata;
      });
    });
  }
}
