import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingBranch extends ConsumerStatefulWidget {
  const SettingBranch({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingBranchState();
}

class _SettingBranchState extends ConsumerState<SettingBranch> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("setting"),
    );
  }
}
