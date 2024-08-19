import 'package:dial_editor/src/feature/editor/data/data_source/metadata_local_data_source.dart';
import 'package:dial_editor/src/feature/editor/domain/model/metadata.dart';
import 'package:dial_editor/src/feature/editor/domain/repository/metadata_repository.dart';
import 'package:sembast/sembast.dart';

class MetadataRepositoryImpl implements MetadataRepository {
  MetadataLocalDataSource metadataLocalDataSource;

  MetadataRepositoryImpl({required this.metadataLocalDataSource});

  @override
  Future<Metadata> getMetadata() async {
    final db = metadataLocalDataSource.getDatabase();
    final store = StoreRef.main();
    return (await store.record("metadata").get(await db))! as Metadata;
  }
}
