import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

abstract class DocumentRepository {
  Future<Document> getDocumentFromDatabase();
  Future<void> saveDocumentToDatabase(Document document);
  Document encode();
  String decode(Document input);
  void saveDocumentToFile(String input);
}
