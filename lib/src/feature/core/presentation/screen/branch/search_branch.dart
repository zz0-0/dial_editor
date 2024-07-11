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
    return const Center(
      child: Text("search"),
    );
  }
}
