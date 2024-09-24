class Connection {
  Connection({
    required this.sourceDocumentUuid,
    required this.targetDocumentUuid,
    required this.connectionKey,
    required this.sourceNodeKey,
    required this.targetNodeKey,
  });
  String sourceDocumentUuid;
  String targetDocumentUuid;
  String connectionKey;
  String sourceNodeKey;
  String targetNodeKey;
}
