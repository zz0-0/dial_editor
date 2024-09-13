import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_file_metadata_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileMetadataStateNotifer
    extends StateNotifier<AsyncValue<List<FileMetadata>>> {
  Ref ref;
  String uuid;

  FileMetadataStateNotifer(this.ref, this.uuid)
      : super(const AsyncValue.loading()) {
    getFileMetadata();
  }

  Future<void> getFileMetadata() async {
    final List<FileMetadata> metadata = [];
    GetFileMetadataUseCase getFileMetadataUseCase;
    ref.watch(getFileMetadataUseCaseProvider).when(
      data: (data) {
        getFileMetadataUseCase = data;
        getFileMetadataUseCase(uuid).then((value) {
          metadata.add(value);
          state = AsyncValue.data(metadata);
        });
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
      loading: () {
        state = const AsyncValue.loading();
      },
    );
  }
}
