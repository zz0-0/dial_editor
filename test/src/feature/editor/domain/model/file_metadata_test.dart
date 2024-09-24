import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FileMetadata', () {
    test('fromMap creates an instance correctly', () {
      final map = {
        'size': 1024,
        'path': '/path/to/file',
        'name': 'file.txt',
        'created': '2023-01-01',
        'modified': '2023-01-02',
      };

      final fileMetadata = FileMetadata.fromMap(map);

      expect(fileMetadata.size, 1024);
      expect(fileMetadata.path, '/path/to/file');
      expect(fileMetadata.name, 'file.txt');
      expect(fileMetadata.created, '2023-01-01');
      expect(fileMetadata.modified, '2023-01-02');
    });

    test('toMap returns a map with correct values', () {
      final fileMetadata = FileMetadata(
        size: 1024,
        path: '/path/to/file',
        name: 'file.txt',
        created: '2023-01-01',
        modified: '2023-01-02',
      );

      final map = fileMetadata.toMap();

      expect(map['size'], 1024);
      expect(map['path'], '/path/to/file');
      expect(map['name'], 'file.txt');
      expect(map['created'], '2023-01-01');
      expect(map['modified'], '2023-01-02');
    });
  });
}
