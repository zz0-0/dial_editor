import 'package:dial_editor/src/feature/editor/domain/model/element/element.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';

class CodeLine extends Inline {
  CodeLine({required super.rawText});

  @override
  Inline createNewLine() {
    // TODO: implement createNewLine
    throw UnimplementedError();
  }

  @override
  RenderInstruction render() {
    // TODO: implement render
    throw UnimplementedError();
  }
}
