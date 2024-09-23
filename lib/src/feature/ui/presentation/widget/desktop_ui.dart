import 'package:dial_editor/src/feature/ui/presentation/widget/top_bar/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents the desktop user interface.
///
/// This widget is a consumer widget that listens to changes in the provider
/// and rebuilds accordingly. It is designed to be used in desktop environments.
class DesktopUI extends ConsumerWidget {
  /// Constructs a [DesktopUI] widget with the given [child] and [key].
  const DesktopUI({required this.child, super.key});

  /// The child widget to display within the desktop user interface.
  final MaterialApp child;

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
