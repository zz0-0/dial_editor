import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final indentationProvider = Provider((ref) => 40);
final iconSizeProvider = Provider((ref) => 40);
final directoryNodeExpandedProvider =
    StateProvider.family<bool, Key>((ref, arg) => false);
final fileProvider = StateProvider<File?>((ref) => null);
