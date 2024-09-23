import 'dart:convert';

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

/// A converter that transforms a [Document] object into its string 
/// representation.
///
/// This class extends the [Converter] base class, specifically converting
/// [Document] instances to [String] format. It can be used to serialize
/// document data for storage or transmission.
///
/// Example usage:
///
/// ```dart
/// final converter = DocumentToStringConverter();
/// final documentString = converter.convert(document);
/// ```
///
/// See also:
/// - [Document], which represents the document data structure.
/// - [Converter], the base class for implementing custom converters.
class DocumentToStringConverter extends Converter<Document, String> {
  @override
  String convert(Document input) {
    return input.toString();
  }
}
