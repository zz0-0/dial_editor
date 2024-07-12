import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppearanceSetting extends ConsumerStatefulWidget {
  const AppearanceSetting({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppearanceSettingState();
}

class _AppearanceSettingState extends ConsumerState<AppearanceSetting> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Appearance"));
  }
}
