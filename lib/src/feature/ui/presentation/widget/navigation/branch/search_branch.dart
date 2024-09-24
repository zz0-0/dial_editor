import 'package:dial_editor/src/core/provider/ui/search_branch_provider.dart';
import 'package:dial_editor/src/feature/search/presentation/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBranch extends ConsumerWidget {
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
