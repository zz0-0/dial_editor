import 'package:flutter/material.dart';

class MinimapWidget extends StatelessWidget {
  const MinimapWidget({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(child: widget);
  }
}

class MinimapScreen extends StatelessWidget {
  const MinimapScreen({
    super.key,
    required this.widget,
  });
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main canvas content with cards
          widget,
          // Minimap positioned in the top right corner
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
                alignment: Alignment.topLeft,
                scale: 0.05,
                child: MinimapWidget(widget: widget),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
