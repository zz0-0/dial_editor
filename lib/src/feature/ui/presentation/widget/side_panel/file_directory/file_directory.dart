import 'package:dial_editor/src/feature/side_panel/file_directory/presentation/widget/directory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileDirectory extends ConsumerWidget {
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
