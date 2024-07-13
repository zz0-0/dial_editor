import 'package:dial_editor/src/feature/core/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppearanceSetting extends ConsumerStatefulWidget {
  const AppearanceSetting({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppearanceSettingState();
}

class _AppearanceSettingState extends ConsumerState<AppearanceSetting> {
  final TextEditingController themeController = TextEditingController();
  ThemeMode? mode;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          "Theme",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const Divider(
          thickness: 1,
          height: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("App theme"),
            DropdownMenu<ThemeMode>(
              initialSelection: ThemeMode.system,
              controller: themeController,
              inputDecorationTheme:
                  const InputDecorationTheme(border: InputBorder.none),
              onSelected: (value) {
                setState(() {
                  if (value == ThemeMode.system) {
                    ref.read(themeNotifierProvider).setSystemMode();
                  } else if (value == ThemeMode.dark) {
                    ref.read(themeNotifierProvider).setDarkMode();
                  } else if (value == ThemeMode.light) {
                    ref.read(themeNotifierProvider).setLightMode();
                  }
                });
              },
              dropdownMenuEntries: ThemeMode.values.map((value) {
                return DropdownMenuEntry(
                  value: value,
                  label: value.name,
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
