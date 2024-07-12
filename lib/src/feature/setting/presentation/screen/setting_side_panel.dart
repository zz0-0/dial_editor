import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingSidePanel extends ConsumerStatefulWidget {
  const SettingSidePanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettingSidePanelState();
}

class _SettingSidePanelState extends ConsumerState<SettingSidePanel> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
