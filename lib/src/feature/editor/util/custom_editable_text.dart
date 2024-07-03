import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:flutter/material.dart';

class CustomEditableText extends StatefulWidget {
  final Node node;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueSetter<String> onChanged;
  final VoidCallback onEditingComplete;

  const CustomEditableText({
    super.key,
    required this.node,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onEditingComplete,
  });

  @override
  _CustomEditableTextState createState() => _CustomEditableTextState();
}

class _CustomEditableTextState extends State<CustomEditableText>
    implements TextSelectionGestureDetectorBuilderDelegate {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late TextSelectionGestureDetectorBuilder _selectionGestureDetectorBuilder;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _focusNode = widget.focusNode;
    _selectionGestureDetectorBuilder = TextSelectionGestureDetectorBuilder(
      delegate: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _selectionGestureDetectorBuilder.buildGestureDetector(
      behavior: HitTestBehavior.translucent,
      child: EditableText(
        controller: _controller,
        focusNode: _focusNode,
        style: widget.node.style ?? Theme.of(context).textTheme.bodyMedium!,
        cursorColor: Colors.blue,
        backgroundCursorColor: Colors.grey,
        selectionColor: Colors.blue.withOpacity(0.4),
        onChanged: (value) => widget.onChanged(value),
        onSubmitted: (_) => widget.onEditingComplete(),
        maxLines: null,
        textAlign: TextAlign.left,
        readOnly: false,
        autofocus: true,
        selectionControls: materialTextSelectionControls,
      ),
    );
  }

  @override
  GlobalKey<EditableTextState> get editableTextKey =>
      GlobalKey<EditableTextState>();

  @override
  bool get forcePressEnabled => false;

  @override
  bool get selectionEnabled => true;

  late bool renderEditable;

  @override
  late BuildContext context;
}
