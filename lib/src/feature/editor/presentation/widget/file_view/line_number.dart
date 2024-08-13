import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LineNumber extends ConsumerWidget {
  final Inline node;
  final int index;
  const LineNumber(this.node, this.index, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 30,
      child: Container(
        alignment: Alignment.center,
        height: node.textHeight,
        child: Text(
          "${index + 1}",
        ),
      ),
    );
  }
}
