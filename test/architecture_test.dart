import 'dart:io';

import 'package:dial_editor/src/core/file_system_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Dependency Test', () {
    test('getPubspecFiles returns correct Pubspec files', () {
      final currentDirectory = Directory.current.path;

      // Make sure there is a pubspec.yaml file in the test directory
      final pubspecFiles = getPubspecFiles(currentDirectory);

      expect(pubspecFiles.isNotEmpty, isTrue);

      final firstPubspec = pubspecFiles.first;
      expect(firstPubspec.name, isNotNull);
    });

    test("'domain' folders should not depend on any other layers", () {
      // Arrange
      const bannedLayers = ['data', 'presentation'];
      const basePath = 'lib/src/feature'; // Base directory for all features

      // Act
      final folders = getDomainFolders(basePath);
      final filesWithBannedImport = <String>[];

      // Check each domain folder for imports
      for (final domainFolder in folders) {
        final dartFiles = getDartFilesInFolder(domainFolder);
        for (final bannedLayer in bannedLayers) {
          final offendingFiles = findFilesWithImport(dartFiles, bannedLayer);
          filesWithBannedImport.addAll(offendingFiles);
        }
      }

      // Assert
      expect(
        filesWithBannedImport,
        isEmpty,
        reason:
            'The following files import other layers: $filesWithBannedImport',
      );
    });

    test('Repositories in domain layer should be abstractions', () {
      const basePath = 'lib/src/feature'; // Base directory for all features

      final folders = getDomainFolders(basePath);
      final concreteRepositories = ['impl', 'repository_impl'];

      for (final folder in folders) {
        final dartFiles = getDartFilesInFolder(folder);
        final offendingFiles =
            findFilesWithImport(dartFiles, concreteRepositories.join('|'));
        expect(
          offendingFiles,
          isEmpty,
          reason: 'Domain should depend on repository interfaces, '
              'not implementations.',
        );
      }
    });

    test(
      "'data' folders should depend on domain layer, "
      'not depend on presentation layer',
      () {
        // Arrange
        const bannedLayers = ['presentation'];
        const basePath = 'lib/src/feature'; // Base directory for all features

        // Act
        final folders = getDataFolders(basePath);
        final filesWithBannedImport = <String>[];

        // Check each domain folder for imports
        for (final folder in folders) {
          final dartFiles = getDartFilesInFolder(folder);
          for (final bannedLayer in bannedLayers) {
            final offendingFiles = findFilesWithImport(dartFiles, bannedLayer);
            filesWithBannedImport.addAll(offendingFiles);
          }
        }

        // Assert
        expect(
          filesWithBannedImport,
          isEmpty,
          reason:
              'The following files import other layers: $filesWithBannedImport',
        );
      },
    );

    test('Repositories should be implemented in data layer', () {
      const basePath = 'lib/src/feature'; // Base directory for all features

      // Act
      final folders = getDataFolders(basePath);
      final domainInterfaces = ['repository'];

      for (final folder in folders) {
        final dataFiles = getDartFilesInFolder(folder);
        final offendingFiles =
            findFilesWithImport(dataFiles, domainInterfaces.join('|'));
        expect(
          offendingFiles,
          isNotEmpty,
          reason: 'Data layer must implement domain interfaces.',
        );
      }
    });

    test(
      "'presentation' folders should depend on domain layer, "
      'not depend on data layer',
      () {
        // Arrange
        const bannedLayers = ['data'];
        const basePath = 'lib/src/feature'; // Base directory for all features

        // Act
        final folders = getPresentationFolders(basePath);
        final filesWithBannedImport = <String>[];

        // Check each domain folder for imports
        for (final folder in folders) {
          final dartFiles = getDartFilesInFolder(folder);
          for (final bannedLayer in bannedLayers) {
            final offendingFiles = findFilesWithImport(dartFiles, bannedLayer);
            filesWithBannedImport.addAll(offendingFiles);
          }
        }

        // Assert
        expect(
          filesWithBannedImport,
          isEmpty,
          reason:
              'The following files import other layers: $filesWithBannedImport',
        );
      },
    );
  });
}

// Helper function to get all Dart files in a folder recursively
List<File> getDartFilesInFolder(String folderPath) {
  final dir = Directory(folderPath);

  if (!dir.existsSync()) {
    throw FileSystemException('Directory not found', folderPath);
  }

  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .toList();
}

// Helper function to check if files contain a specific import
List<String> findFilesWithImport(List<File> files, String importString) {
  final offendingFiles = <String>[];

  final regex = RegExp(
    "${r"(import|export)\s+'package:[^']*/" + importString}/[^']*'",
  );

  for (final file in files) {
    final content = file.readAsStringSync();
    if (regex.hasMatch(content)) {
      offendingFiles.add(file.path);
    }
  }

  return offendingFiles;
}

// Helper function to recursively find all 'domain' folders in a base path
List<String> getDomainFolders(String basePath) {
  final baseDir = Directory(basePath);
  final folder = <String>[];

  if (!baseDir.existsSync()) {
    throw FileSystemException('Base directory not found', basePath);
  }

  // Recursively list all subdirectories, looking for 'domain' folders
  baseDir.listSync(recursive: true).whereType<Directory>().forEach((dir) {
    if (dir.path.endsWith('${Platform.pathSeparator}domain')) {
      folder.add(dir.path);
    }
  });

  return folder;
}

List<String> getDataFolders(String basePath) {
  final baseDir = Directory(basePath);
  final folder = <String>[];

  if (!baseDir.existsSync()) {
    throw FileSystemException('Base directory not found', basePath);
  }

  baseDir.listSync(recursive: true).whereType<Directory>().forEach((dir) {
    if (dir.path.endsWith('${Platform.pathSeparator}data')) {
      folder.add(dir.path);
    }
  });

  return folder;
}

List<String> getPresentationFolders(String basePath) {
  final baseDir = Directory(basePath);
  final folder = <String>[];

  if (!baseDir.existsSync()) {
    throw FileSystemException('Base directory not found', basePath);
  }

  baseDir.listSync(recursive: true).whereType<Directory>().forEach((dir) {
    if (dir.path.endsWith('${Platform.pathSeparator}presentation')) {
      folder.add(dir.path);
    }
  });

  return folder;
}
