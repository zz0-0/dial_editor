/// A class representing the metadata of a file.
///
/// This class contains information about a file, such as its name, size,
/// creation date, and other relevant metadata.
///
/// Example usage:
///
/// ```dart
/// FileMetadata metadata = FileMetadata(
///   name: 'example.txt',
///   size: 1024,
///   creationDate: DateTime.now(),
/// );
/// ```
///
/// Properties:
/// - `name`: The name of the file.
/// - `size`: The size of the file in bytes.
/// - `creationDate`: The date and time when the file was created.
/// - `lastModifiedDate`: The date and time when the file was last modified.
/// - `type`: The type or extension of the file.
class FileMetadata {
  /// Represents metadata information for a file.
  ///
  /// This class holds various attributes related to a file's metadata,
  /// such as its name, size, type, and other relevant details.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// final metadata = FileMetadata(
  ///   name: 'example.txt',
  ///   size: 1024,
  ///   type: 'text/plain',
  ///   // other attributes
  /// );
  /// ```
  ///
  /// Properties:
  /// - `name`: The name of the file.
  /// - `size`: The size of the file in bytes.
  /// - `type`: The MIME type of the file.
  /// - `createdDate`: The date and time when the file was created.
  /// - `modifiedDate`: The date and time when the file was last modified.
  FileMetadata({
    required this.size,
    required this.path,
    required this.name,
    required this.created,
    required this.modified,
  });

  /// Creates an instance of [FileMetadata] from a map.
  ///
  /// The [map] parameter is a [Map] containing key-value pairs that correspond
  /// to the properties of [FileMetadata].
  ///
  /// Returns an instance of [FileMetadata] populated with the values from the
  /// map.
  factory FileMetadata.fromMap(Map<String, dynamic> map) {
    return FileMetadata(
      size: map['size'] as int,
      path: map['path'] as String,
      name: map['name'] as String,
      created: map['created'] as String,
      modified: map['modified'] as String,
    );
  }

  /// Represents the size of the file in bytes.
  int size;

  /// The file path associated with the metadata.
  ///
  /// This string represents the location of the file in the filesystem.
  String path;

  /// The name of the file.
  String name;

  /// The date and time when the file was created.
  ///
  /// This is represented as a string in ISO 8601 format.
  String created;

  /// The date and time when the file was last modified.
  ///
  /// This field stores the modification timestamp as a string.
  String modified;

  /// Converts the file metadata to a map representation.
  ///
  /// This method serializes the file metadata into a `Map<String, dynamic>`
  /// which can be useful for encoding the metadata into JSON or other
  /// key-value based formats.
  ///
  /// Returns a `Map<String, dynamic>` containing the file metadata.
  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'path': path,
      'name': name,
      'created': created,
      'modified': modified,
    };
  }
}
