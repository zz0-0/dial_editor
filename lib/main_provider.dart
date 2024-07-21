import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDesktopProvider = Provider(
  (ref) => Platform.isWindows || Platform.isMacOS || Platform.isLinux,
);
