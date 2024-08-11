import 'package:dial_editor/src/feature/ui/presentation/widget/top_bar/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DesktopUI extends ConsumerWidget {
  final MaterialApp child;

  const DesktopUI({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20, child: TopBar()),
            const Divider(thickness: 1, height: 1),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
