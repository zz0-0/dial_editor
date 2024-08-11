import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';

class ConvertStringToLineUseCase {
  final NodeRepository _nodeRepository;

  ConvertStringToLineUseCase(this._nodeRepository);

  Inline convertLine(String value) {
    return _nodeRepository.convert(value);
  }
}
