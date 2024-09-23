import 'package:dial_editor/src/core/provider/ui/directory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents an empty directory in the file directory side
/// panel.
///
/// This widget is used to display a placeholder or message when there are
/// no files
/// or directories present in the current directory.
///
/// This widget is a [ConsumerWidget], which means it can listen to changes
/// in the
/// application's state and rebuild accordingly.
///
/// Usage:
/// ```dart
/// EmptyDirectory();
/// ```
///
/// See also:
/// - [ConsumerWidget], which this widget extends.
class EmptyDirectory extends ConsumerWidget {
  /// A widget that represents an empty directory in the file directory side
  /// panel.
  ///
  /// This widget is used to display a placeholder or message when there are
  /// no files
  /// or directories present in the current directory.
  ///
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
            child: const Text('Open Folder'),
          ),
        ],
      ),
    );
  }
}
