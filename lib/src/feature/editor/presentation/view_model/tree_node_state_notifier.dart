import 'package:animated_tree_view/animated_tree_view.dart' as atv;
import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TreeNodeStateNotifier
    extends StateNotifier<AsyncValue<TreeNode<dynamic>>> {
  TreeNodeStateNotifier(this.ref) : super(AsyncValue.data(TreeNode())) {
    buildTree();
  }
  Ref ref;
  Future<void> buildTree() async {
    try {
      state = const AsyncValue.loading();
      await ref.read(documentListStateNotifierProvider.notifier).getList();
      final documentList = ref.read(documentListStateNotifierProvider);
      final root = atv.TreeNode<dynamic>();
      for (final document in documentList) {
        final node = atv.TreeNode<dynamic>(key: document.uuid);
        await ref
            .read(fileMetadataStateNotiferProvider(document.uuid).notifier)
            .getFileMetadata();
        node.addAll(buildTreeNode(document.nodeMap));
        final metadata =
            ref.read(fileMetadataStateNotiferProvider(document.uuid));
        node.data = metadata[0].name;
        root.add(node);
      }
      state = AsyncValue.data(root);
    } catch (error, stackTrace) {
      state = AsyncValue.error('Error', stackTrace);
    }
  }

  Iterable<atv.Node> buildTreeNode(Map<String, Node> nodeMap) {
    return nodeMap.entries.map((entry) {
      final node = atv.TreeNode<dynamic>(key: entry.key);
      if (entry.value is Block) {
        node
          ..addAll(buildTreeNodeChildren((entry.value as Block).children))
          ..data = entry.value.runtimeType;
      } else if (entry.value is Inline) {
        node.data = entry.value;
      }
      return node;
    });
  }

  Iterable<atv.Node> buildTreeNodeChildren(List<Node> children) {
    return children.map((child) {
      final node = atv.TreeNode<dynamic>(key: child.key.toString());
      if (child is Block) {
        node
          ..addAll(buildTreeNodeChildren(child.children))
          ..data = child.runtimeType;
      } else if (child is Inline) {
        node.data = child;
      }
      return node;
    });
  }
}
