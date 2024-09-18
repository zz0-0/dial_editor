import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentListStateNotifier extends StateNotifier<List<Document>> {
  Ref ref;

  DocumentListStateNotifier(this.ref) : super([]) {
    getList();
  }

  Future<void> getList() async {
    final getAllDocumentElementUseCase =
        await ref.read(getAllDocumentElementUseCaseProvider.future);
    final documents = await getAllDocumentElementUseCase();
    state = documents;
  }
}
