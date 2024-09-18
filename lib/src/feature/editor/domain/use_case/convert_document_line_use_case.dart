import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';

class ConvertStringToLineUseCase {
  final NodeRepository repository;

  ConvertStringToLineUseCase(this.repository);

  Inline call(String value) {
    return repository.convert(value);
  }
}
