import 'package:dial_editor/src/feature/sidepanel/file_directory/domain/model/directory_node.dart';
import 'package:dial_editor/src/feature/sidepanel/file_directory/domain/repository/directory_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final directoryNodeListProvider =
    StateNotifierProvider<DiretoryNotifier, List<DirectoryNode>>(
  (ref) {
    final watch = ref.watch(directoryNodeListRepositoryProvider);
    return DiretoryNotifier(watch);
  },
);
final directoryNodeListHasDataProvider = Provider((ref) {
  if (ref.watch(directoryNodeListProvider) != []) {
    return true;
  } else {
    return false;
  }
});

class DiretoryNotifier extends StateNotifier<List<DirectoryNode>> {
  AsyncValue<List<DirectoryNode>> watch;
  List<DirectoryNode> get openFolder => state;
  DiretoryNotifier(this.watch) : super([]) {
    watch.when(
      data: (value) {
        state = value;
      },
      error: (Object error, StackTrace stackTrace) {},
      loading: () {},
    );
  }
}
