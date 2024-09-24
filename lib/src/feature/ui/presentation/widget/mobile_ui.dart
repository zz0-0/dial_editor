import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileUI extends ConsumerWidget {
  const MobileUI({required this.child, super.key});
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
