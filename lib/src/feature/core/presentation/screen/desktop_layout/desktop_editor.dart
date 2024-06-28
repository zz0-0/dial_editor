import 'package:dial_editor/src/feature/core/presentation/widget/topbar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DesktopEditor extends ConsumerStatefulWidget {
  final MaterialApp child;

  const DesktopEditor({super.key, required this.child});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DesktopEditorState();
}

class _DesktopEditorState extends ConsumerState<DesktopEditor> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20, child: Topbar()),
            Expanded(
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
