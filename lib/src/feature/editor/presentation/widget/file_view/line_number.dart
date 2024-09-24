import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LineNumber extends ConsumerWidget {
  const LineNumber(this.node, this.index, {super.key});
  final Inline node;
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 30,
      child: Container(
        alignment: Alignment.center,
        height: node.textHeight,
        child: Text(
          '${index + 1}',
        ),
      ),
    );
  }
}
