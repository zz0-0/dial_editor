import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/node_repository.dart';

class ConvertStringToLineUseCase {
  final NodeRepository _nodeRepository;

  ConvertStringToLineUseCase(this._nodeRepository);

  Node convertLine(String value) {
    return _nodeRepository.convert(value);
  }
}
