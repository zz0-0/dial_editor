import 'package:dial_editor/src/feature/editor/domain/model/metadata.dart';

abstract class MetadataRepository {
  Future<Metadata> getMetadata();
}
