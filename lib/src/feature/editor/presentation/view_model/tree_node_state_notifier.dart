import 'package:animated_tree_view/animated_tree_view.dart' as atv;
import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TreeNodeStateNotifier extends StateNotifier<AsyncValue<TreeNode>> {
  Ref ref;

  TreeNodeStateNotifier(this.ref) : super(const AsyncValue.loading()) {
    buildTree();
  }

  void buildTree() {
    final atv.TreeNode root = atv.TreeNode();
    final documentList = ref.read(documentListStateNotifierProvider);
    documentList.when(
      data: (data) {
        for (final Document document in data) {
          final atv.TreeNode node = atv.TreeNode(key: document.uuid);
          final metadata =
              ref.read(fileMetadataStateNotiferProvider(document.uuid));
          node.addAll(buildTreeNode(document.nodeMap));
          metadata.when(
            data: (data1) {
              if (data1.isNotEmpty) {
                node.data = data1[0].name;
                root.add(node);
              }
            },
            error: (error, stackTrace) {
              state = AsyncValue.error(error, stackTrace);
            },
            loading: () {
              state = const AsyncValue.loading();
            },
          );
        }
        state = AsyncValue.data(root);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
      loading: () {
        state = const AsyncValue.loading();
      },
    );
  }

  Iterable<atv.Node> buildTreeNode(Map<String, Node> nodeMap) {
    return nodeMap.entries.map((entry) {
      final atv.TreeNode node = atv.TreeNode(key: entry.key);
      if (entry.value is Block) {
        node.addAll(buildTreeNodeChildren((entry.value as Block).children));
        node.data = entry.value.runtimeType;
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
        node.data = child.runtimeType;
      } else if (child is Inline) {
        node.data = child;
      }
      return node;
    });
  }
}
