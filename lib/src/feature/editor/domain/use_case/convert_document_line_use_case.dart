import 'package:dial_editor/src/core/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';

class ConvertStringToLineUseCase {
  ConvertStringToLineUseCase(this.repository);
  final NodeRepository repository;
  Inline call(String value) {
    return repository.convert(value);
  }
}
