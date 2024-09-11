import 'package:animated_tree_view/animated_tree_view.dart' as atv;
import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/use_case/get_all_document_element_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentListStateNotifier extends StateNotifier<List<Document>> {
  Ref ref;

  DocumentListStateNotifier(this.ref) : super([]) {
    getList();
  }

  void getList() {
    GetAllDocumentElementUseCase getAllDocumentElementUseCase;
    ref.watch(getAllDocumentElementUseCaseProvider).whenData((value) {
      getAllDocumentElementUseCase = value;
      getAllDocumentElementUseCase().then((value) {
        state = value;
      });
    });
  }

  atv.TreeNode buildTree() {
    final atv.TreeNode root = atv.TreeNode();
    for (final Document document in state) {
      final atv.TreeNode node = atv.TreeNode(key: document.uuid);
      node.addAll(buildTreeNode(document.nodeMap));
      root.add(node);
    }
    // print(root);
    return root;
  }

  Iterable<atv.Node> buildTreeNode(Map<String, Node> nodeMap) {
    return nodeMap.entries.map((entry) {
      final atv.TreeNode node = atv.TreeNode(key: entry.key);
      if (entry.value is Block) {
        node.addAll(buildTreeNodeChildren((entry.value as Block).children));
      } else if (entry.value is Inline) {
        node.data = entry.value;
      }
      return node;
    });
  }

  Iterable<atv.Node> buildTreeNodeChildren(List<Node> children) {
    return children.map((child) {
      final atv.TreeNode node = atv.TreeNode(key: child.key.toString());
      if (child is Block) {
        node.addAll(buildTreeNodeChildren(child.children));
      } else if (child is Inline) {
        node.data = child;
      }
      return node;
    });
  }
}
