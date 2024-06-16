import 'package:dial_editor/src/feature/file_management/directory/file_directory/domain/model/directory_node.dart';

abstract class DirectoryRepository {
  Future<List<DirectoryNode>> getDirectory();
}
