import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_all_document_element_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentListStateNotifier
    extends StateNotifier<AsyncValue<List<Document>>> {
  Ref ref;

  DocumentListStateNotifier(this.ref) : super(const AsyncValue.loading()) {
    getList();
  }

  Future<void> getList() async {
    GetAllDocumentElementUseCase getAllDocumentElementUseCase;
    ref.watch(getAllDocumentElementUseCaseProvider).when(
      data: (data) {
        getAllDocumentElementUseCase = data;
        getAllDocumentElementUseCase().then((value) {
          state = AsyncValue.data(value);
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
