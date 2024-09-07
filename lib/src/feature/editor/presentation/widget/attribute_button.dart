import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AttributeType { key, incoming, outgoing }

class AttributeButton extends ConsumerWidget {
  final AttributeType type;
  final String content;
  const AttributeButton(this.type, this.content, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final IconData icon;

    if (type == AttributeType.key) {
      icon = Icons.outlined_flag;
    } else if (type == AttributeType.incoming) {
      icon = Icons.arrow_circle_left_outlined;
    } else {
      icon = Icons.arrow_circle_right_outlined;
    }

    return Chip(
      avatar: Icon(icon),
      label: Text(content),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
