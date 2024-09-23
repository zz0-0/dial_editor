import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/markdown_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents the file view in the editor.
///
/// This widget is a `ConsumerStatefulWidget` which means it listens to changes
/// in the provider and rebuilds accordingly. It is used to display and manage
/// the content of a file within the editor's main area.
class FileView extends ConsumerStatefulWidget {
  /// A widget that represents the view of a file in the editor.
  ///
  /// This widget is used to display the contents of a file within the editor's
  /// main area.
  ///
  const FileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FileViewState();
}

class _FileViewState extends ConsumerState<FileView> {
  @override
  Widget build(BuildContext context) {
    return const MarkdownFile();
  }
}
