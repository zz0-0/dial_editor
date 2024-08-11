import 'package:dial_editor/src/core/theme/presentation/view_model/theme_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = ChangeNotifierProvider((ref) {
  return ThemeViewModel();
});
