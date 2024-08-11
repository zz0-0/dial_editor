import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class SaveDocumentUseCase {
  final DocumentRepository _documentRepository;

  SaveDocumentUseCase(this._documentRepository);

  void saveDocument(String input) {
    _documentRepository.save(input);
  }
}
