import 'package:dial_editor/src/core/provider/side_panel/directory_provider.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/side_panel/file_directory/domain/use_case/get_directory_list_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectoryViewModel extends StateNotifier<List<DirectoryNode>> {
  final Ref ref;

  DirectoryViewModel(this.ref) : super([]) {
    getDirectory();
  }

  Future<void> getDirectory() async {
    final GetDirectoryListUseCase getDirectoryListUseCase =
        await ref.read(getDirectoryListUseCaseProvider.future);
    state = await getDirectoryListUseCase();
  }
}
