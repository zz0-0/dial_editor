/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';

base class CodeLine extends Inline {
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
