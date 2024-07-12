import 'package:dial_editor/src/feature/core/presentation/widget/sidepanel/side_panel_provider.dart';
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
    return Row(
      children: [
        // if (ref.watch(searchSidePanelProvider)) const Setting(),
        if (ref.watch(searchSidePanelProvider))
          const VerticalDivider(thickness: 1, width: 1),
        const Expanded(child: Center(child: Text("Setting"))),
      ],
    );
  }
}
