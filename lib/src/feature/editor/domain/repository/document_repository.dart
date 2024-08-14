import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

abstract class DocumentRepository {
  Document encode();
  String decode(Document input);
  void save(String input);
}
