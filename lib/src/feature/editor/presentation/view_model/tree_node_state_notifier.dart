import 'package:animated_tree_view/animated_tree_view.dart' as atv;
import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A notifier class that manages the state of tree nodes in the editor feature.
///
/// This class is responsible for handling the state changes and notifying
/// listeners about updates to the tree nodes. It is used in the presentation
/// layer of the editor feature to ensure that the UI reflects the current
/// state of the tree nodes.
class TreeNodeStateNotifier
    extends StateNotifier<AsyncValue<TreeNode<dynamic>>> {
  /// Constructs a [TreeNodeStateNotifier] with the given [ref] and initializes
  /// the state with an [AsyncValue] containing an empty [TreeNode].
  ///
  /// The [ref] parameter is a reference to the provider's context.
  TreeNodeStateNotifier(this.ref) : super(AsyncValue.data(TreeNode())) {
    buildTree();
  }

  /// A reference to the provider's state, allowing access to the state and
  /// other providers within the same scope.
  ///
  /// This is typically used to read or watch other providers, or to perform
  /// actions such as updating the state.
  ///
  /// Example usage:
  /// ```dart
  /// final someState = ref.read(someProvider);
  /// ```
  Ref ref;

  /// Asynchronously builds the tree structure.
  ///
  /// This method is responsible for constructing the tree by performing
  /// necessary asynchronous operations. It does not take any parameters
  /// and does not return any value.
  ///
  /// Throws:
  /// - Any exceptions that might occur during the tree building process.
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

  /// Builds a tree of nodes from a given map of nodes.
  ///
  /// This method takes a map where the keys are strings and the values are
  /// [Node] objects. It returns an iterable collection of [atv.Node] objects
  /// that represent the tree structure.
  ///
  /// The [nodeMap] parameter is a map where each key is a string identifier
  /// for a node, and each value is a [Node] object associated with that
  /// identifier.
  ///
  /// Returns an [Iterable] of [atv.Node] objects representing the tree
  /// structure.
  ///
  /// - Parameter nodeMap: A map of string identifiers to [Node] objects.
  /// - Returns: An iterable collection of [atv.Node] objects.
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

  /// Builds an iterable collection of tree node children from a list of nodes.
  ///
  /// This method takes a list of [Node] objects and converts them into an
  /// iterable collection of [atv.Node] objects, which represent the children
  /// in a tree structure.
  ///
  /// - Parameter children: A list of [Node] objects to be converted.
  /// - Returns: An iterable collection of [atv.Node] objects representing the
  ///   children in the tree structure.
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
