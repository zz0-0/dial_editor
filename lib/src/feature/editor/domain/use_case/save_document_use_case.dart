import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/document_repository.dart';

/// A use case class responsible for saving a document to a file.
///
/// This class provides the functionality to persist a document's content
/// to a specified file path. It ensures that the document is saved correctly
/// and handles any necessary file operations.
///
/// Example usage:
/// ```dart
/// final saveDocumentUseCase = SaveDocumentToFileUseCase();
/// saveDocumentUseCase.execute(documentContent, filePath);
/// ```
///
/// Note: Ensure that the file path provided is valid and accessible.
class SaveDocumentToFileUseCase {
  /// A use case for saving a document to a file.
  ///
  /// This use case interacts with the repository to persist the document data.
  ///
  /// Parameters:
  /// - `repository`: The repository that handles the document saving logic.
  SaveDocumentToFileUseCase(this.repository);

  /// A string variable to hold the input data.
  ///
  /// This variable is used to store the input text that will be processed
  /// or saved by the save document use case.
  String input = '';

  /// A use case for saving a document.
  ///
  /// This class interacts with the [DocumentRepository] to save documents.
  ///
  /// The [repository] is used to perform the save operation.
  final DocumentRepository repository;

  /// Saves the provided document content to a file.
  ///
  /// This method takes a string input representing the document content
  /// and saves it to a file. The file path and other details are managed
  /// within the method.
  ///
  /// [input] The content of the document to be saved.
  void saveDocumentToFile(String input) {
    repository.saveDocumentToFile(input);
  }

  /// Saves the provided list of nodes.
  ///
  /// This method takes a list of [Node] objects and performs the necessary
  /// operations to save them. The exact saving mechanism is not detailed
  /// here and should be implemented according to the specific requirements
  /// of the application.
  ///
  /// - Parameter nodeList: A list of [Node] objects to be saved.
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
