import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fileSidePanelProvider = StateProvider((ref) => false);
final fileEmptySidePanelProvider = StateProvider((ref) => false);
final fileProvider = StateProvider<File?>((ref) => null);
