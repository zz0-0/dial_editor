import 'package:dial_editor/src/feature/sidepanel/file_directory/domain/model/directory_node.dart';

abstract class DirectoryRepository {
  Future<List<DirectoryNode>> getDirectory();
}
