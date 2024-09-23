import 'package:dial_editor/src/core/provider/ui/search_branch_provider.dart';
import 'package:dial_editor/src/feature/search/presentation/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that provides a search functionality within a branch.
///
/// This widget is a [ConsumerWidget] which means it listens to changes in the
/// provider and rebuilds accordingly. It is used to search through branches
/// and display the results.
///
/// Usage:
/// ```dart
/// SearchBranch();
/// ```
///
/// Make sure to wrap this widget with a provider scope to ensure it functions
/// correctly.
class SearchBranch extends ConsumerWidget {
  /// A widget that represents the search branch in the navigation.
  ///
  /// This widget is used to provide a search functionality within a specific
  /// branch
  /// of the navigation structure.
  ///
  const SearchBranch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        if (ref.watch(searchSidePanelProvider)) const Search(),
        if (ref.watch(searchSidePanelProvider))
          const VerticalDivider(thickness: 1, width: 1),
        const Expanded(child: Center(child: Text('Search'))),
      ],
    );
  }
}
