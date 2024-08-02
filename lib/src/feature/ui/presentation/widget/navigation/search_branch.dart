import 'package:dial_editor/src/feature/search/presentation/widget/search_field.dart';
import 'package:dial_editor/src/feature/ui/presentation/provider/side_panel_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBranch extends ConsumerStatefulWidget {
  const SearchBranch({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBranchState();
}

class _SearchBranchState extends ConsumerState<SearchBranch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (ref.watch(searchSidePanelProvider)) const SearchField(),
        if (ref.watch(searchSidePanelProvider))
          const VerticalDivider(thickness: 1, width: 1),
        const Expanded(child: Center(child: Text("Search"))),
      ],
    );
  }
}
