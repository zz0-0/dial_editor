import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Card extends ConsumerWidget {
  const Card(this.node, {super.key});
  final Node node;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
