class FileMetadata {
  FileMetadata({
    required this.size,
    required this.path,
    required this.name,
    required this.created,
    required this.modified,
  });
  factory FileMetadata.fromMap(Map<String, dynamic> map) {
    return FileMetadata(
      size: map['size'] as int,
      path: map['path'] as String,
      name: map['name'] as String,
      created: map['created'] as String,
      modified: map['modified'] as String,
    );
  }
  int size;
  String path;
  String name;
  String created;
  String modified;
  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'path': path,
      'name': name,
      'created': created,
      'modified': modified,
    };
  }
}
