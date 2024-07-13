import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyboardSetting extends ConsumerStatefulWidget {
  const KeyboardSetting({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _KeyboardSettingState();
}

class _KeyboardSettingState extends ConsumerState<KeyboardSetting> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Keyboard"));
  }
}
