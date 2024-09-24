import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentListStateNotifier extends StateNotifier<List<Document>> {
  DocumentListStateNotifier(this.ref) : super([]) {
    getList();
  }
  Ref ref;
  Future<void> getList() async {
    final getAllDocumentElementUseCase =
        await ref.read(getAllDocumentElementUseCaseProvider.future);
    final documents = await getAllDocumentElementUseCase();
    state = documents;
  }
}
