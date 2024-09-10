import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_all_document_element_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentListStateNotifier extends StateNotifier<List<Document>> {
  Ref ref;

  DocumentListStateNotifier(this.ref) : super([]) {
    getList();
  }

  void getList() {
    GetAllDocumentElementUseCase getAllDocumentElementUseCase;
    ref.watch(getAllDocumentElementUseCaseProvider).whenData((value) {
      getAllDocumentElementUseCase = value;
      getAllDocumentElementUseCase().then((value) {
        state = value;
      });
    });
  }
}
