class Node {
  String? nodeTag;
  String? nodeText;

  Node(this.nodeTag, this.nodeText);

  String get tag => nodeTag!;
  set tag(String tag) {
    nodeTag = tag;
  }

  String get text => nodeText!;
  set text(String text) {
    nodeText = text;
  }
}
