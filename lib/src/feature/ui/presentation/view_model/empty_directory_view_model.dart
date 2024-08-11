import 'package:dial_editor/src/core/provider/ui/file_branch_provider.dart';
import 'package:dial_editor/src/core/provider/ui/top_bar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmptyDirectoryViewModel extends StateNotifier {
  EmptyDirectoryViewModel() : super(null);

  void openFolder(WidgetRef ref) {
    ref.read(fileEmptySidePanelProvider.notifier).update((state) => false);
    ref.read(openFolderProvider.notifier).update((state) => true);
    ref.read(fileSidePanelProvider.notifier).update((state) => true);
  }
}
