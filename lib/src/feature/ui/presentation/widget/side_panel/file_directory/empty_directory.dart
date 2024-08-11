import 'package:dial_editor/src/core/provider/ui/directory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmptyDirectory extends ConsumerWidget {
  const EmptyDirectory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emptyDirectoryViewModel =
        ref.read(emptyDirectoryViewModelProvider.notifier);
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              emptyDirectoryViewModel.openFolder(ref);
            },
            child: const Text("Open Folder"),
          ),
        ],
      ),
    );
  }
}
