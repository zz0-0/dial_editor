import 'dart:convert';

import 'package:dial_editor/src/feature/editor/data/repository_impl/node_repository_impl.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';

/// A converter that transforms a [String] into a [Document].
///
/// This class extends the [Converter] class, providing the functionality
/// to convert a string representation of a document into a [Document] object.
/// It can be useful in scenarios where document data is stored or transmitted
/// as a string and needs to be converted back into a structured [Document] 
/// format.
class StringToDocumentConverter extends Converter<String, Document> {
  /// A converter class that transforms a string into a document format.
  ///
  /// This class utilizes a UUID for unique identification of the conversion 
  /// process.
  ///
  /// @param uuid A unique identifier for the conversion instance.
  StringToDocumentConverter(this.uuid);

  /// A unique identifier for the document.
  ///
  /// This UUID is used to uniquely identify each document within the system.
  final String uuid;

  @override
  Document convert(String input) {
    final NodeRepository nodeRepository = NodeRepositoryImpl();
    final lines = input.split('\n');
    final (nodeKeyList, nodeMap) = nodeRepository.convertDocument(lines);
    final document = Document(uuid: uuid)
      ..nodeKeyList = nodeKeyList
      ..nodeMap = nodeMap;
    return document;
  }
}
