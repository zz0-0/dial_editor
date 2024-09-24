import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Connection', () {
    test('should create a Connection instance with given parameters', () {
      final connection = Connection(
        sourceDocumentUuid: 'source-uuid',
        targetDocumentUuid: 'target-uuid',
        connectionKey: 'connection-key',
        sourceNodeKey: 'source-node-key',
        targetNodeKey: 'target-node-key',
      );

      expect(connection.sourceDocumentUuid, 'source-uuid');
      expect(connection.targetDocumentUuid, 'target-uuid');
      expect(connection.connectionKey, 'connection-key');
      expect(connection.sourceNodeKey, 'source-node-key');
      expect(connection.targetNodeKey, 'target-node-key');
    });

    test('should update the properties of Connection instance', () {
      final connection = Connection(
        sourceDocumentUuid: 'source-uuid',
        targetDocumentUuid: 'target-uuid',
        connectionKey: 'connection-key',
        sourceNodeKey: 'source-node-key',
        targetNodeKey: 'target-node-key',
      )
        ..sourceDocumentUuid = 'new-source-uuid'
        ..targetDocumentUuid = 'new-target-uuid'
        ..connectionKey = 'new-connection-key'
        ..sourceNodeKey = 'new-source-node-key'
        ..targetNodeKey = 'new-target-node-key';

      expect(connection.sourceDocumentUuid, 'new-source-uuid');
      expect(connection.targetDocumentUuid, 'new-target-uuid');
      expect(connection.connectionKey, 'new-connection-key');
      expect(connection.sourceNodeKey, 'new-source-node-key');
      expect(connection.targetNodeKey, 'new-target-node-key');
    });
  });
}
