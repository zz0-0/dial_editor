import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/recursive.dart';
import 'package:dial_editor/src/feature/ui/presentation/widget/main_area/editor/file_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents the editing area within the file view.
///
/// This widget is a [ConsumerStatefulWidget] which means it can listen to
/// changes in the provider and update its state accordingly.
///
/// The [EditingArea] is used to provide an interface for users to edit
/// content within the application.
///
/// The widget is located at:
/// `/D:/Project/markdown/dial_editor/lib/src/feature/editor/presentation/widget/file_view/editing_area.dart`
class EditingArea extends ConsumerStatefulWidget {
  /// A widget that represents the editing area in the file view.
  ///
  /// This widget is used within the file view to provide an area where
  /// users can edit the content. It is a stateless widget that takes
  /// an optional key parameter.
  ///
  /// {@category Widget}
  /// {@subCategory Editing}
  ///
  /// Example usage:
  /// ```dart
  /// EditingArea(key: Key('editing_area'));
  /// ```
  ///
  /// See also:
  /// - [FileView], which contains the editing area.
  const EditingArea({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditingAreaState();
}

class _EditingAreaState extends ConsumerState<EditingArea> {
  @override
  Widget build(BuildContext context) {
    final nodeList = ref.watch(nodeListStateNotifierProvider);
    final scrollController3 = ref.watch(scrollController3Provider);
    var index = 0;
    return ListView(
      controller: scrollController3,
      children: nodeList.map((node) {
        final widget = Recursive(node, index);
        if (node is Block) {
          index += node.children.length;
        } else {
          index++;
        }
        return widget;
      }).toList(),
    );
  }
}
