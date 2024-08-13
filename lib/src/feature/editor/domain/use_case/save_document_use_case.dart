import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

class SaveDocumentUseCase {
  String input = '';
  final DocumentRepository _documentRepository;

  SaveDocumentUseCase(this._documentRepository);

  void saveDocument(String input) {
    _documentRepository.save(input);
  }

  void saveNodeList(List<Node> nodeList) {
    _flattenString(nodeList, input);
    saveDocument(input);
  }

  void _flattenString(List<Node> nodeList, String input) {
    String temp = input;
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
