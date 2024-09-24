import 'package:dial_editor/src/core/provider/side_panel/directory_provider.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectoryViewModel extends StateNotifier<List<DirectoryNode>> {
  DirectoryViewModel(this.ref) : super([]) {
    getDirectory();
  }
  final Ref ref;
  Future<void> getDirectory() async {
    final getDirectoryListUseCase =
        await ref.read(getDirectoryListUseCaseProvider.future);
    state = await getDirectoryListUseCase();
  }
}
