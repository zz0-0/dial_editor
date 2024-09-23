import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/view_model/node_state_notifier.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A stateful widget that provides editing capabilities within the file view.
///
/// This widget is part of the presentation layer of the editor feature.
/// It utilizes the `ConsumerStatefulWidget` to interact with the state
/// management
/// solution provided by the `flutter_riverpod` package.
class Editing extends ConsumerStatefulWidget {
  /// A widget that represents the editing state of a node.
  ///
  /// This widget is used to display and manage the editing state of a given
  /// node.
  ///
  /// Parameters:
  /// - `node`: The node that is being edited.
  const Editing(this.node, {super.key});

  /// A final variable representing an inline node in the editor.
  ///
  /// This variable is used to hold an instance of the `Inline` class,
  /// which represents an inline element within the editor's document structure.
  final Inline node;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => EditingState();
}

/// A state class for the `Editing` widget that extends `ConsumerState`.
/// 
/// This class is responsible for managing the state of the `Editing` widget,
/// which is part of the file view editing feature in the application.
/// 
/// The `EditingState` class utilizes the `ConsumerState` from the Riverpod
/// package to listen to and react to state changes in the application.
class EditingState extends ConsumerState<Editing>
    implements TextSelectionGestureDetectorBuilderDelegate {
  /// A notifier for managing the state of nodes in the editor.
  /// 
  /// This is used to keep track of changes and updates to the nodes
  /// within the editor, ensuring that the UI reflects the current state
  /// of the nodes.
  late NodeStateNotifier nodeStateNotifier;
  final GlobalKey<EditableTextState> _editorKey =
      GlobalKey<EditableTextState>();

  @override
  GlobalKey<EditableTextState> get editableTextKey => _editorKey;

  @override
  bool get forcePressEnabled => false;

  @override
  bool get selectionEnabled => false;

  @override
  Widget build(BuildContext context) {
    nodeStateNotifier = ref.read(nodeStateProvider(widget.node.key).notifier);
    final selectionGestureDetectorBuilder =
        CustomTextSelectionGestureDetectorBuilder(state: this);

    return selectionGestureDetectorBuilder.buildGestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Focus(
        onKeyEvent: (node, event) => _onKeyEvent(event, widget.node),
        child: GestureDetector(
          child: ValueListenableBuilder(
            valueListenable: widget.node.controller,
            builder: (context, value, child) {
              return EditableText(
                key: widget.node.key,
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
                onSubmitted: (_) => _onEditingComplete(context),
                textInputAction: TextInputAction.done,
              );
            },
          ),
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
    // if ((event is KeyDownEvent || event is KeyRepeatEvent) &&
    //         event.logicalKey == LogicalKeyboardKey.enter ||
    //     event.logicalKey == LogicalKeyboardKey.numpadEnter) {
    //   _onEditingComplete(context);
    // }
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
    nodeStateNotifier.onArrowLeft(isShiftPressed: isShiftPressed);
  }

  void _onArrowRight(bool isShiftPressed) {
    nodeStateNotifier.onArrowRight(isShiftPressed: isShiftPressed);
  }

  void _onDragSelectionUpdate(TapDragUpdateDetails details) {
    nodeStateNotifier.onDragSelectionUpdate(details);
  }

  void _onDragSelectionStart(TapDragStartDetails details) {
    nodeStateNotifier.onDragSelectionStart(details);
  }
}

/// A custom gesture detector builder for handling text selection gestures
/// in a text editing widget.
///
/// This class extends the default gesture detector builder to provide
/// custom behavior for text selection, such as handling long presses,
/// double taps, and drag gestures.
///
/// It is used to create a gesture detector that wraps around a text
/// editing widget, allowing for custom handling of user interactions
/// with the text.
///
/// Example usage:
/// ```dart
/// CustomTextSelectionGestureDetectorBuilder(
///   // Provide necessary parameters and callbacks
/// );
/// ```
///
/// See also:
/// - [TextSelectionGestureDetectorBuilder], which this class extends.
/// - [TextEditingController], for controlling the text being edited.
/// - [TextSelectionControls], for handling text selection controls.
class CustomTextSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  /// A custom gesture detector builder for handling text selection gestures.
  ///
  /// This widget is used to create a custom gesture detector that can handle
  /// text selection gestures within the editor.
  ///
  /// The [state] parameter is required and should be an instance of the state
  /// that manages the text selection.
  CustomTextSelectionGestureDetectorBuilder({required this.state})
      : super(delegate: state);

  /// Represents the current state of the editing process.
  ///
  /// This state is used to manage and track the various stages and changes
  /// during the editing of a file in the editor.
  final EditingState state;

  @override
  void onDragSelectionStart(TapDragStartDetails details) {
    state._onDragSelectionStart(details);
  }

  @override
  void onDragSelectionUpdate(TapDragUpdateDetails details) {
    state._onDragSelectionUpdate(details);
  }
}
