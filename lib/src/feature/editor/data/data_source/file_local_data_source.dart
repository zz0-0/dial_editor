import 'dart:io';

import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// An abstract class that defines the contract for local file data sources.
/// Implementations of this class are responsible for handling file operations
/// such as reading from and writing to local storage.
abstract class FileLocalDataSource {
  /// Reads a file from the local data source.
  ///
  /// Returns a [Future] that completes with the [File] object.
  Future<File> readFile();

  /// Writes the provided content to a file.
  ///
  /// This method takes a string [content] and writes it to a file.
  /// The file path and other details are managed internally.
  ///
  /// Throws an [IOException] if the file cannot be written.
  ///
  /// Example:
  /// ```dart
  /// await writeFile('Hello, World!');
  /// ```
  Future<void> writeFile(String content);
}

/// Implementation of the [FileLocalDataSource] interface that provides
/// local file data source functionalities.
///
/// This class is responsible for handling file operations such as reading
/// and writing data to local storage.
class FileLocalDataSourceImpl implements FileLocalDataSource {
  /// Implementation of a local data source that interacts with the file system.
  ///
  /// This class is responsible for handling file-based operations such as 
  /// reading
  /// and writing data to the local storage. It uses a reference to perform 
  /// these
  /// operations.
  ///
  /// [ref] - A reference used for file operations.
  FileLocalDataSourceImpl(this.ref);

  /// A reference to the provider's container, which allows access to other 
  /// providers and their state.
  ///
  /// This is typically used to read or manipulate the state of other providers 
  /// within the application.
  Ref ref;

  @override
  Future<File> readFile() async {
    return await ref.read(fileProvider)!;
  }

  @override
  Future<void> writeFile(String content) async {
    return ref.read(fileProvider)!.writeAsStringSync(content);
  }
}
