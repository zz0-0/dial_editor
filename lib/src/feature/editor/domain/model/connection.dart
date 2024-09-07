class Connection {
  String sourceDocumentUuid;
  String targetDocumentUuid;
  String connectionKey;
  String sourceNodeKey;
  String targetNodeKey;

  Connection({
    required this.sourceDocumentUuid,
    required this.targetDocumentUuid,
    required this.connectionKey,
    required this.sourceNodeKey,
    required this.targetNodeKey,
  });
}
