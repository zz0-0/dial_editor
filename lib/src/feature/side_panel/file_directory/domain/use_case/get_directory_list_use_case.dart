import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/repository/directory_repository.dart';

class GetDirectoryListUseCase {
  GetDirectoryListUseCase(this.repository);
  final DirectoryRepository repository;
  Future<List<DirectoryNode>> call() async {
    return repository.getDirectory();
  }
}
