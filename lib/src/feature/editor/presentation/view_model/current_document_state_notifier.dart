import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/document.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentDocumentStateNotifier extends StateNotifier<Document?> {
  Ref ref;
  CurrentDocumentStateNotifier(this.ref) : super(null) {
    getDocument();
  }

  Future<void> getDocument() async {
    final getDocumentUseCase =
        await ref.read(getDocumentUseCaseProvider.future);
    final document = await getDocumentUseCase();
    state = document;
  }
}
