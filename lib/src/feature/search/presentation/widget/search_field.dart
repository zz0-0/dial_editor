import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchField extends ConsumerStatefulWidget {
  const SearchField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
