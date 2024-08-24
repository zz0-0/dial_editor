import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

abstract class DocumentRepository {
  Document encode();
  String decode(Document input);
  void saveDocumentToFile(String input);
  Future<Document> fetchDocumentFromDatabase();
  Future<void> saveDocumentToDatabase(Document input);
}
