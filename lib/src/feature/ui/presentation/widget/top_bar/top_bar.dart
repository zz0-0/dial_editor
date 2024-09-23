import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents the top bar in the UI.
///
/// This widget is a consumer widget, which means it listens to changes in the
/// provider and rebuilds accordingly. It is typically used to display
/// navigation controls, titles, or other important actions at the top of the
/// screen.
class TopBar extends ConsumerWidget {
  /// A widget that represents the top bar in the UI.
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
