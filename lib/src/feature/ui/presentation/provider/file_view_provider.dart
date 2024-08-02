import 'package:dial_editor/src/feature/editor/domain/model/element/block/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/ui/presentation/provider/canvas_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final openedFilesProvider =
    StateNotifierProvider<OpenedFilesNotifier, Set<String>>((ref) {
  return OpenedFilesNotifier(ref);
});
final selectedFileProvider = StateProvider<String?>((ref) => null);
final documentChildrenProvider =
    StateNotifierProvider<DocumentChildrenNotifier, List<Node>>(
  (ref) => DocumentChildrenNotifier(ref),
);

class OpenedFilesNotifier extends StateNotifier<Set<String>> {
  Ref ref;

  OpenedFilesNotifier(this.ref) : super({});

  void addFile(String filePath) {
    if (!state.contains(filePath)) {
      final current = Set<String>.from(state);
      current.add(filePath);
      state = current;
    } else {
      ref.read(selectedFileProvider.notifier).state = filePath;
    }
  }

  void removeFile(String filePath) {
    if (state.contains(filePath)) {
      final current = Set<String>.from(state);
      current.remove(filePath);
      state = current;
      if (ref.read(selectedFileProvider.notifier).state == filePath) {
        ref.read(selectedFileProvider.notifier).state =
            current.isNotEmpty ? current.first : null;
      }
    }
  }
}

class DocumentChildrenNotifier extends StateNotifier<List<Node>> {
  Ref ref;
  DocumentChildrenNotifier(this.ref) : super([]);

  // ignore: use_setters_to_change_properties
  void setChildren(List<Node> children) {
    state = children;

    for (final child in children) {
      final GlobalKey key = GlobalKey();
      final group = ref.watch(groupProvider(key));

      final layoutId = ref
          .read(groupLayoutProvider.notifier)
          .build(group.key, ResizeType.group);
      ref.read(groupLayoutProvider.notifier).addLayoutId(layoutId);

      if (child is Block && child.children!.isNotEmpty) {
        final GlobalKey key = GlobalKey();
        final card = ref.watch(cardProvider(key));
        final layoutId = ref
            .read(cardLayoutProvider.notifier)
            .build(card.key, ResizeType.card);
        ref.read(cardLayoutProvider.notifier).addLayoutId(layoutId);
      }
    }
  }
}
