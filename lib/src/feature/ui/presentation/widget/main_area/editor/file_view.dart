import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/markdown_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileView extends ConsumerStatefulWidget {
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
