import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

/// An abstract class that defines the contract for a repository
/// responsible for managing nodes in the editor domain.
///
/// Implementations of this repository should provide methods to
/// perform CRUD operations on nodes, ensuring that the data
/// integrity and business rules are maintained.
abstract class NodeRepository {
  /// Converts a document represented as a list of strings into a tuple
  /// containing
  /// a list of strings and a map of nodes.
  ///
  /// The input is a list of strings where each string represents a line in
  /// the document.
  ///
  /// Returns a tuple where the first element is a list of strings and the
  /// second element
  /// is a map where the keys are strings and the values are `Node` objects.
  (List<String>, Map<String, Node>) convertDocument(List<String> lines);

  /// Converts the given input string into an `Inline` object.
  ///
  /// This method takes a string input and processes it to produce an
  /// `Inline` object, which represents a segment of text with specific
  /// formatting or attributes.
  ///
  /// - Parameter input: The string to be converted.
  /// - Returns: An `Inline` object representing the formatted text.
  Inline convert(String input);
}
