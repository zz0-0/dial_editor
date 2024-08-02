import 'dart:io';

import 'package:dial_editor/src/feature/ui/presentation/provider/directory_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Localfiledatasource {
  File getFile();
}

class LocalfiledatasourceImpl implements Localfiledatasource {
  final container = ProviderContainer();

  @override
  File getFile() {
    return container.read(fileProvider)!;
  }
}
