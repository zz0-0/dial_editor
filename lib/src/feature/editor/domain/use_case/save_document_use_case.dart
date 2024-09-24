import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class SaveDocumentToFileUseCase {
  SaveDocumentToFileUseCase(this.repository);
  String input = '';
  final DocumentRepository repository;
  void saveDocumentToFile(String input) {
    repository.saveDocumentToFile(input);
  }

  void saveNodeList(List<Node> nodeList) {
    _flattenString(nodeList, input);
    saveDocumentToFile(input);
  }

  void _flattenString(List<Node> nodeList, String input) {
    var temp = input;
    for (final node in nodeList) {
      if (node is Block) {
        if (node.children.isNotEmpty) {
          _flattenString(node.children, temp);
        }
      } else if (node is Inline) {
        temp += '${node.rawText}\n';
      }
    }
  }
}
