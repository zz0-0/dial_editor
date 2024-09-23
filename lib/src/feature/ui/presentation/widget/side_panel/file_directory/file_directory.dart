import 'package:dial_editor/src/feature/side_panel/file_directory/presentation/widget/directory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents a file directory in the side panel of the UI.
///
/// This widget is a consumer widget that listens to changes in the provider
/// and rebuilds accordingly. It is used to display the file directory structure
/// in the side panel of the application.
class FileDirectory extends ConsumerWidget {
  /// A widget that represents the file directory in the side panel.
  const FileDirectory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Directory(),
      ],
    );
  }
}
