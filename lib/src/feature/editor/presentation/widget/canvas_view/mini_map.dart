import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MiniMap extends ConsumerWidget {
  const MiniMap({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 20,
          right: 20,
          child: Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white.withOpacity(0.05),
            ),
            child: Transform.scale(
              scale: 0.05,
              child: RepaintBoundary(
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
