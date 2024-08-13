import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/node_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Editing extends ConsumerStatefulWidget {
  final Inline node;
  const Editing(this.node, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditingState();
}

class _EditingState extends ConsumerState<Editing> {
  late NodeStateNotifier nodeStateNotifier;
  @override
  Widget build(BuildContext context) {
    nodeStateNotifier = ref.read(nodeStateProvider(widget.node.key).notifier);
    return Focus(
      onKeyEvent: (node, event) => _onKeyEvent(event, widget.node),
      child: GestureDetector(
        child: ValueListenableBuilder(
          valueListenable: widget.node.controller,
          builder: (context, value, child) {
            return EditableText(
              controller: widget.node.controller,
              focusNode: widget.node.focusNode,
              style: widget.node.style,
              cursorColor: Colors.blue,
              backgroundCursorColor: Colors.blue,
              showCursor: true,
              selectionColor: Colors.red,
              enableInteractiveSelection: true,
              paintCursorAboveText: true,
              onChanged: (value) => _onChange(widget.node, value, context),
              onEditingComplete: () => _onEditingComplete(context),
            );
          },
        ),
      ),
    );
  }

  KeyEventResult _onKeyEvent(KeyEvent event, Inline node) {
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.keyA &&
        HardwareKeyboard.instance.isControlPressed) {
      _selectAll();
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      _onDelete();
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _onArrowUp();
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _onArrowDown();
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _onArrowLeft(HardwareKeyboard.instance.isShiftPressed);
    }
    if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
        event.logicalKey == LogicalKeyboardKey.arrowRight) {
      _onArrowRight(HardwareKeyboard.instance.isShiftPressed);
    }
    return KeyEventResult.ignored;
  }

  void _onChange(
    Inline node,
    String value,
    BuildContext context,
  ) {
    nodeStateNotifier.onChange(node, value, context);
  }

  void _onEditingComplete(BuildContext context) {
    nodeStateNotifier.onEditingComplete(context);
  }

  void _selectAll() {
    nodeStateNotifier.selectAll();
  }

  void _onDelete() {
    nodeStateNotifier.onDelete();
  }

  void _onArrowUp() {
    nodeStateNotifier.onArrowUp();
  }

  void _onArrowDown() {
    nodeStateNotifier.onArrowDown();
  }

  void _onArrowLeft(bool isShiftPressed) {
    nodeStateNotifier.onArrowLeft(isShiftPressed);
  }

  void _onArrowRight(bool isShiftPressed) {
    nodeStateNotifier.onArrowRight(isShiftPressed);
  }
}
