import 'package:dial_editor/src/feature/file_management/directory/file_directory/domain/model/directory_node.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
