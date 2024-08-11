import 'package:dial_editor/src/feature/side_panel/file_directory/domain/model/directory_node.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectoryViewModel extends StateNotifier<List<DirectoryNode>> {
  AsyncValue<List<DirectoryNode>> watch;
  List<DirectoryNode> get openFolder => state;
  DirectoryViewModel(this.watch) : super([]) {
    watch.when(
      data: (value) {
        state = value;
      },
      error: (Object error, StackTrace stackTrace) {},
      loading: () {},
    );
  }
}
