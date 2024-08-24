import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Attributes extends ConsumerWidget {
  final Inline node;
  const Attributes(this.node, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 19,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: node.attributeMap.length,
        itemBuilder: (context, index) {
          return const SizedBox(width: 50, child: Text(""));
        },
      ),
    );
  }
}
