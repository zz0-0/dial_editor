import 'package:dial_editor/src/feature/editor/domain/model/attribute.dart';
import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Attribute', () {
    test('should have a GlobalKey of EditableTextState', () {
      final attribute = Attribute();
      expect(attribute.key, isA<GlobalKey<EditableTextState>>());
    });

    test('should initialize with an empty connections map', () {
      final attribute = Attribute();
      expect(attribute.connections, isEmpty);
    });

    test('should allow adding connections to the map', () {
      final attribute = Attribute();
      final connection = Connection(
        sourceDocumentUuid: '',
        targetDocumentUuid: '',
        connectionKey: '',
        sourceNodeKey: '',
        targetNodeKey: '',
      ); // Assuming Connection has a default constructor
      attribute.connections['test'] = connection;

      expect(attribute.connections.containsKey('test'), isTrue);
      expect(attribute.connections['test'], equals(connection));
    });
  });
}
