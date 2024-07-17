import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileEditor extends ConsumerStatefulWidget {
  final MaterialApp child;

  const MobileEditor({super.key, required this.child});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MobileEditorState();
}

class _MobileEditorState extends ConsumerState<MobileEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: widget.child,
    );
  }
}
