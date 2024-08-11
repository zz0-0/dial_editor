import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline/heading.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_document_children_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileViewViewModel extends ChangeNotifier {
  final Ref ref;

  FileViewViewModel(this.ref);

  List<Node> get nodeList => getDocumentChildren();
  List<Inline> get flatNodeList => ref.watch(flatNodeListStateNotifierProvider);
  List<Widget> get widgetList => ref.watch(widgetListStateNotifierProvider);

  List<Node> getNodeList() {
    return getDocumentChildren();
  }

  List<Node> getDocumentChildren() {
    final GetDocumentChildrenUseCase getDocumentChildren =
        ref.watch(getDocumentChildrenUseCaseProvider);
    return getDocumentChildren.getChildren();
  }

  void updateFlatNodeList() {
    final List<Inline> flatNodeList = [];
    flattenNodeList(nodeList, flatNodeList);
    ref
        .read(flatNodeListStateNotifierProvider.notifier)
        .updateList(flatNodeList);
  }

  void updateWidgetList() {
    ref.read(widgetListStateNotifierProvider.notifier).updateList(flatNodeList);
  }

  void flattenNodeList(List<Node> nodeList, List<Node> flatNodeList) {
    for (final node in nodeList) {
      if (node is Block && node.children.isNotEmpty) {
        if (node is Heading) {
          flatNodeList.add(node);
        }
        flattenNodeList(node.children, flatNodeList);
      } else {
        flatNodeList.add(node);
      }
    }
  }
}
