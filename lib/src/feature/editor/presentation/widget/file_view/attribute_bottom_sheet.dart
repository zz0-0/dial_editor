import 'package:animated_tree_view/animated_tree_view.dart' as atv;
import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AttributeType { incoming, outgoing }

enum NodeType { file, block, inline }

class AttributeBottomSheet extends ConsumerStatefulWidget {
  final GlobalKey nodeKey;
  final Set<Connection> incomingConnections;
  final Set<Connection> outgoingConnections;

  const AttributeBottomSheet({
    super.key,
    required this.nodeKey,
    required this.incomingConnections,
    required this.outgoingConnections,
  });

  @override
  _AttributeBottomSheetState createState() => _AttributeBottomSheetState();
}

class _AttributeBottomSheetState extends ConsumerState<AttributeBottomSheet> {
  AttributeType _attributeType = AttributeType.incoming;
  final Set<NodeType> _filters = <NodeType>{};
  String _searchQuery = '';
  final Set<String> _incomingSelectNodes = <String>{};
  final Set<String> _outgoingSelectNodes = <String>{};

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(8.0),
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
                      leading: Checkbox(
                        value: ref.watch(checkboxProvider(node.key)),
                        onChanged: (value) {
                          ref
                              .read(checkboxProvider(node.key).notifier)
                              .update((state) => value);
                          if (value!) {
                            if (_attributeType == AttributeType.incoming) {
                              _incomingSelectNodes.add(node.key);
                            } else {
                              _outgoingSelectNodes.add(node.key);
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
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  // TODO: Add connections
                  if (_attributeType == AttributeType.incoming) {
                    for (final node in _incomingSelectNodes) {
                      ref
                          .read(
                            nodeIncomingConnectionProvider(widget.nodeKey)
                                .notifier,
                          )
                          .addIncomingConnection(
                            Connection(
                              sourceDocumentUuid: '',
                              targetDocumentUuid: '',
                              connectionKey: GlobalKey().toString(),
                              sourceNodeKey: '',
                              targetNodeKey: node,
                            ),
                          );
                    }
                  } else {
                    for (final node in _outgoingSelectNodes) {
                      ref
                          .read(
                            nodeOutgoingConnectionProvider(widget.nodeKey)
                                .notifier,
                          )
                          .addOutgoingConnections(
                            Connection(
                              sourceDocumentUuid: '',
                              targetDocumentUuid: '',
                              connectionKey: GlobalKey().toString(),
                              sourceNodeKey: node,
                              targetNodeKey: '',
                            ),
                          );
                    }
                  }
                  Navigator.pop(context);
                },
                child: const Text('Add and Close'),
              ),
              TextButton(
                onPressed: () {},
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

  bool _shouldShowNode(atv.TreeNode node) {
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

  NodeType _getNodeType(atv.TreeNode node) {
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
