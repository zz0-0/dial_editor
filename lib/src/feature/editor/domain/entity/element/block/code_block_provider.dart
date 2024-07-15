import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code_block.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code_block_marker.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/element/block/code_line.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final codeBlockNotifierProvider =
    StateNotifierProvider.family<CodeBlockNotifier, CodeBlock?, GlobalKey>(
  (ref, key) => CodeBlockNotifier(null),
);

class CodeBlockNotifier extends StateNotifier<CodeBlock?> {
  CodeBlockNotifier(super.state);

  // ignore: use_setters_to_change_properties
  void updateCodeBlock(CodeBlock block) {
    state = block;
  }

  void addLine(Node line) {
    if (line is CodeLine || line is CodeBlockMarker) {
      final List<Node> newChildren = state!.children!;
      newChildren.add(line);
      state = state!.copyWith(children: newChildren);
    }
  }

  void updateLine(int index, String newContent) {
    final updatedLines = [...state!.children!];
    if (index >= 0 && index < updatedLines.length) {
      updatedLines[index] = CodeLine(
        context: state!.context,
        language: state!.language,
        rawText: newContent,
        parentKey: state!.key,
      );
      state = state!.copyWith(children: updatedLines);
    }
  }
}
