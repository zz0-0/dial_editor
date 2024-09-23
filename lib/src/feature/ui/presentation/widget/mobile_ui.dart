import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents the mobile user interface.
///
/// This widget is a consumer widget that listens to changes in the provider
/// and rebuilds accordingly. It is designed to be used in the mobile version
/// of the application.
class MobileUI extends ConsumerWidget {
  /// A widget that represents the mobile user interface.
  const MobileUI({required this.child, super.key});

  /// The child widget to display in the mobile user interface.
  final MaterialApp child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dial Editor'),
        ),
        body: Column(
          children: [
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
