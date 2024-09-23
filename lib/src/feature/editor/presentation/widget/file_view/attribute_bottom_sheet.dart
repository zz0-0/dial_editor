import 'dart:collection';

import 'package:animated_tree_view/animated_tree_view.dart' as atv;
import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Enum representing the type of attribute in the file view.
///
/// The `AttributeType` enum has two values:
/// - `incoming`: Represents an incoming attribute.
/// - `outgoing`: Represents an outgoing attribute.
enum AttributeType {
  /// This variable represents the incoming data or state that will be used
  /// within the attribute bottom sheet widget. It is likely to be processed
  /// or displayed in the UI component.
  incoming,

  /// This widget represents the bottom sheet used for displaying and editing
  /// attributes in the file view of the editor feature. It provides a user
  /// interface for modifying various attributes associated with the file.
  outgoing
}

/// Enum representing different types of nodes that can be used in the
/// attribute bottom sheet within the file view of the editor feature.
enum NodeType {
  /// Represents a file object used within the attribute bottom sheet widget.
  /// This object is likely used to handle file-related operations or data
  /// within the context of the editor's attribute bottom sheet.
  file,

  /// A widget that represents the bottom sheet for displaying and editing
  /// attributes in the file view of the editor feature.
  ///
  /// This widget is used to provide a user interface for modifying various
  /// attributes related to the file being viewed or edited.
  ///
  /// The bottom sheet can be invoked to allow users to make changes to
  /// attributes such as file properties, metadata, or other relevant details.
  ///
  /// The implementation details of this widget are defined in the
  /// `attribute_bottom_sheet.dart` file located in the specified path.
  block,

  /// Represents an inline node used within the attribute bottom sheet widget.
  inline
}

/// A widget that represents a bottom sheet for displaying and editing
/// attributes.
///
/// This widget is a `ConsumerStatefulWidget`, which means it can listen to
/// changes
/// in the provider and update its state accordingly.
///
/// The `AttributeBottomSheet` is typically used in the context of an editor
/// where
/// users can view and modify various attributes.
///
/// Usage:
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   builder: (context) => AttributeBottomSheet(),
/// );
/// ```
///
/// Note: Ensure that the necessary providers are set up in the widget tree
/// to use this widget effectively.
class AttributeBottomSheet extends ConsumerStatefulWidget {
  /// A widget that represents a bottom sheet for displaying and editing
  /// attributes.
  ///
  /// This widget is used within the file view to allow users to interact with
  /// and modify various attributes. It is designed to be used as a modal bottom
  /// sheet that slides up from the bottom of the screen.
  ///
  /// The [AttributeBottomSheet] is a constant constructor, meaning that it can
  /// be instantiated as a compile-time constant.
  const AttributeBottomSheet({
    required this.nodeKey,
    required this.incomingConnections,
    required this.outgoingConnections,
    super.key,
  });

  /// A global key used to identify and access the widget associated with
  /// this key.
  /// This key can be used to retrieve the state of the widget, perform
  /// operations
  /// on it, or access its properties.
  final GlobalKey nodeKey;

  /// A set of incoming connections associated with the current instance.
  ///
  /// This set contains all the connections that are directed towards the
  /// current instance, allowing for tracking and managing incoming data
  /// or signals.
  ///
  /// Example usage:
  /// ```dart
  /// final incoming = instance.incomingConnections;
  /// ```
  final Set<Connection> incomingConnections;

  /// A set of outgoing connections associated with the current entity.
  ///
  /// This set contains instances of the [Connection] class, representing
  /// the connections that originate from the current entity and lead to
  /// other entities or nodes within the system.
  final Set<Connection> outgoingConnections;

  @override
  AttributeBottomSheetState createState() => AttributeBottomSheetState();
}

/// A state class for the `AttributeBottomSheet` widget that extends 
/// `ConsumerState`.
/// This class manages the state and behavior of the attribute bottom sheet in 
/// the editor feature.
///
/// The `AttributeBottomSheetState` class is responsible for handling the UI 
/// and interactions
/// within the attribute bottom sheet, which is used to display and edit 
/// attributes of a file.
///
/// This class uses the `ConsumerState` from the Riverpod package to manage 
/// state and
/// dependencies, allowing it to react to changes in the state of the 
/// application.
class AttributeBottomSheetState extends ConsumerState<AttributeBottomSheet> {
  AttributeType _attributeType = AttributeType.incoming;
  final Set<NodeType> _filters = <NodeType>{};
  String _searchQuery = '';
  final HashMap<String, String> _incomingSelectNodes = HashMap();
  final HashMap<String, String> _outgoingSelectNodes = HashMap();

  /// A string that holds the UUID of the current document.
  ///
  /// This variable is used to uniquely identify the document that is
  /// currently being edited or viewed in the application. It is initialized
  /// to an empty string and should be assigned a valid UUID when a document
  /// is loaded.
  String currentDocumentUuid = '';

  @override
  Widget build(BuildContext context) {
    currentDocumentUuid = ref.watch(currentDocumentStateNotifierProvider)!.uuid;
    return Column(
      children: [
        SegmentedButton<AttributeType>(
          segments: [
            ButtonSegment<AttributeType>(
              value: AttributeType.incoming,
              label: Text('Incoming ${widget.incomingConnections.length}'),
              icon: const Icon(Icons.swipe_down_alt_outlined),
            ),
            ButtonSegment<AttributeType>(
              value: AttributeType.outgoing,
              label: Text('Outgoing ${widget.outgoingConnections.length}'),
              icon: const Icon(Icons.swipe_up_alt_outlined),
            ),
          ],
          selected: <AttributeType>{_attributeType},
          onSelectionChanged: (Set<AttributeType> selected) {
            setState(() {
              _attributeType = selected.first;
            });
          },
        ),
        Expanded(
          child: _buildConnectionList(),
        ),
      ],
    );
  }

  Widget _buildConnectionList() {
    final tree = ref.watch(treeNodeProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Search'),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              ElevatedButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 5,
          children: NodeType.values
              .map(
                (type) => FilterChip(
                  label: Text(type.toString().split('.').last),
                  selected: _filters.contains(type),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _filters.add(type);
                      } else {
                        _filters.remove(type);
                      }
                    });
                  },
                ),
              )
              .toList(),
        ),
        Expanded(
          child: tree.when(
            data: (data) {
              return atv.TreeView.simple(
                tree: data,
                shrinkWrap: true,
                showRootNode: false,
                builder: (BuildContext context, atv.TreeNode<dynamic> node) {
                  if (_shouldShowNode(node)) {
                    return ListTile(
                      // TODO(get): Checkbox should be checked if the node is
                      //already connected
                      // Need to check if the node is already connected for
                      //current node base on document uuid
                      leading: Checkbox(
                        value: ref.watch(checkboxProvider(node.key)),
                        onChanged: (value) {
                          ref
                              .read(checkboxProvider(node.key).notifier)
                              .update((state) => value);
                          if (value!) {
                            if (_attributeType == AttributeType.incoming) {
                              _incomingSelectNodes[node.key] = node.root.key;
                            } else {
                              _outgoingSelectNodes[node.key] = node.root.key;
                            }
                          } else {
                            if (_attributeType == AttributeType.incoming) {
                              _incomingSelectNodes.remove(node.key);
                            } else {
                              _outgoingSelectNodes.remove(node.key);
                            }
                          }
                        },
                      ),
                      title: Text(node.data.toString()),
                      onTap: () {},
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: Text('Error: $error'),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  addConnections();
                  Navigator.pop(context);
                },
                child: const Text('Add and Close'),
              ),
              TextButton(
                onPressed: addConnections,
                child: const Text('Add and Continue'),
              ),
              TextButton(
                onPressed: () {
                  if (_attributeType == AttributeType.incoming) {
                    _incomingSelectNodes.clear();
                  } else {
                    _outgoingSelectNodes.clear();
                  }
                },
                child: const Text('Clear'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Adds connections to the current context.
  ///
  /// This method is responsible for establishing necessary connections
  /// within the current context. It should be called when initializing
  /// or updating the state that requires these connections.
  void addConnections() {
    if (_attributeType == AttributeType.incoming) {
      _incomingSelectNodes.forEach((key, value) {
        ref
            .read(
              nodeIncomingConnectionProvider(widget.nodeKey).notifier,
            )
            .addIncomingConnection(
              Connection(
                sourceDocumentUuid: currentDocumentUuid,
                targetDocumentUuid: value,
                connectionKey: GlobalKey().toString(),
                sourceNodeKey: widget.nodeKey.toString(),
                targetNodeKey: key,
              ),
            );
      });
    } else {
      _outgoingSelectNodes.forEach((key, value) {
        ref
            .read(
              nodeOutgoingConnectionProvider(widget.nodeKey).notifier,
            )
            .addOutgoingConnections(
              Connection(
                sourceDocumentUuid: currentDocumentUuid,
                targetDocumentUuid: value,
                connectionKey: GlobalKey().toString(),
                sourceNodeKey: widget.nodeKey.toString(),
                targetNodeKey: key,
              ),
            );
      });
    }
  }

  bool _shouldShowNode(atv.TreeNode<dynamic> node) {
    if (_filters.isNotEmpty && !_filters.contains(_getNodeType(node))) {
      return false;
    }

    if (_searchQuery.isNotEmpty &&
        !node.data
            .toString()
            .toLowerCase()
            .contains(_searchQuery.toLowerCase())) {
      return false;
    }

    return true;
  }

  NodeType _getNodeType(atv.TreeNode<dynamic> node) {
    if (node.data is! Block && node.toString().contains('md')) {
      return NodeType.file;
    } else if (node.data is Block) {
      return NodeType.block;
    } else if (node.data is! Block) {
      return NodeType.inline;
    } else {
      return NodeType.inline;
    }
  }
}
