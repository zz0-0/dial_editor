import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';

/// A use case class that provides functionality to convert a string into a
/// document line.
/// This class is part of the domain layer in the editor feature.
///
/// Example usage:
/// ```dart
/// final useCase = ConvertStringToLineUseCase();
/// final line = useCase.convert("Example string");
/// ```
///
/// Note: Ensure that the input string is properly formatted to avoid
/// unexpected results.
class ConvertStringToLineUseCase {
  /// A use case that converts a string to a document line.
  ///
  /// This use case interacts with the repository to perform the conversion.
  ///
  /// @param repository The repository used for the conversion.
  ConvertStringToLineUseCase(this.repository);

  /// A repository that provides access to nodes in the document.
  ///
  /// This repository is used to perform operations related to nodes,
  /// such as fetching, updating, or deleting nodes.
  ///
  /// Example usage:
  /// ```dart
  /// final node = repository.getNodeById('node-id');
  /// ```
  final NodeRepository repository;

  /// Converts a given string value into an [Inline] object.
  ///
  /// This method takes a string [value] and processes it to produce
  /// an [Inline] object, which represents a line in the document.
  ///
  /// - Parameter value: The string value to be converted.
  /// - Returns: An [Inline] object representing the processed line.
  Inline call(String value) {
    return repository.convert(value);
  }
}
