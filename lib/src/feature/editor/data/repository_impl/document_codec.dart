import 'dart:convert';

import 'package:dial_editor/src/feature/editor/data/repository_impl/document_to_string_converter.dart';
import 'package:dial_editor/src/feature/editor/data/repository_impl/string_to_document_converter.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

/// A codec for encoding and decoding `Document` objects to and from `String` 
/// representations.
///
/// This class extends the `Codec` class, providing the necessary methods to 
/// convert
/// `Document` instances into `String` format and vice versa. It is useful for 
/// scenarios
/// where documents need to be serialized for storage or transmission.
///
/// Example usage:
///
/// ```dart
/// final codec = DocumentCodec();
/// final document = Document(...);
/// final encoded = codec.encode(document);
/// final decoded = codec.decode(encoded);
/// ```
///
/// The `DocumentCodec` class ensures that the encoded string accurately 
/// represents the
/// original `Document` object, allowing for reliable serialization and 
/// deserialization.
class DocumentCodec extends Codec<String, Document> {
  /// Constructs a [DocumentCodec] instance with the given [uuid].
  ///
  /// The [uuid] parameter is used to uniquely identify the document codec.
  DocumentCodec(this.uuid);

  /// A universally unique identifier (UUID) for the document.
  /// This string is used to uniquely identify the document within the system.
  String uuid;

  @override
  Converter<Document, String> get decoder => DocumentToStringConverter();

  @override
  Converter<String, Document> get encoder => StringToDocumentConverter(uuid);
}
