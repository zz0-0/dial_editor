import 'dart:io';
import 'package:path/path.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

Iterable<Pubspec> getPubspecFiles(
  String directoryPath, {
  List<RegExp>? filePathExcludes,
}) {
  return getFiles(
    directoryPath: directoryPath,
    fileName: 'pubspec.yaml',
    filePathExcludes: filePathExcludes,
  ).map((file) {
    return Pubspec.parse(file.readAsStringSync());
  });
}

Iterable<File> getFiles({
  required String directoryPath,
  String? fileExtension,
  String? fileName,
  List<RegExp>? filePathExcludes,
}) {
  if (!FileSystemEntity.isDirectorySync(directoryPath)) return [];
  var files = Directory(directoryPath)
      .listSync(recursive: true)
      .whereType<File>()
      .where(
        (file) => !split(file.path).any(
          (pathComponent) =>
              pathComponent != '.' &&
              pathComponent != '..' &&
              pathComponent.startsWith('.'),
        ),
      );
  if (fileExtension != null) {
    files = files.where((file) => extension(file.path) == '.$fileExtension');
  }
  if (fileName != null) {
    files = files.where((file) => basename(file.path) == fileName);
  }
  if (filePathExcludes != null) {
    files = files.where(
      (file) =>
          filePathExcludes.every((exclude) => !exclude.hasMatch(file.path)),
    );
  }
  return files;
}

void log(String message) => stdout.writeln(message);
