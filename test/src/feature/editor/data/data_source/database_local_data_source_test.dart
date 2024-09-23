// import 'dart:io';

// import 'package:dial_editor/src/feature/editor/data/data_source/database_local_data_source.dart';
// import 'package:dial_editor/src/feature/editor/domain/model/file_metadata.dart';
// import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mockito/mockito.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sembast/sembast.dart';
// import 'package:test/test.dart';
// import 'package:uuid/uuid.dart';

// // Mock classes
// class MockRef extends Mock implements Ref {}

// class MockDatabase extends Mock implements Database {}

// class MockFile extends Mock implements File {}

// void main() {
//   late DatabaseLocalDataSourceImpl dataSource;
//   late MockRef mockRef;
//   late MockDatabase mockDatabaseMetadata;
//   late MockDatabase mockDatabaseDocument;
//   late MockFile mockFile;

//   setUp(() async {
//     mockRef = MockRef();
//     mockDatabaseMetadata = MockDatabase();
//     mockDatabaseDocument = MockDatabase();
//     mockFile = MockFile();

//     dataSource = await DatabaseLocalDataSourceImpl.create(mockRef);
//     dataSource._databaseMetadata = mockDatabaseMetadata;
//     dataSource._databaseDocument = mockDatabaseDocument;
//   });

//   group('DatabaseLocalDataSource', () {
//     test('openDatabaseMetadata should open metadata database', () async {
//       final appDir = await getApplicationDocumentsDirectory();
//       final dbPath = '${appDir.path}/metadata.db';

//       when(databaseFactoryIo.openDatabase(dbPath, mode: DatabaseMode.create))
//           .thenAnswer((_) async => mockDatabaseMetadata);

//       final result = await dataSource.openDatabaseMetadata();

//       expect(result, mockDatabaseMetadata);
//     });

//     test('openDatabaseDocument should open document database', () async {
//       final appDir = await getApplicationDocumentsDirectory();
//       final dbPath = '${appDir.path}/document.db';

//       when(databaseFactoryIo.openDatabase(dbPath, mode: DatabaseMode.create))
//           .thenAnswer((_) async => mockDatabaseDocument);

//       final result = await dataSource.openDatabaseDocument();

//       expect(result, mockDatabaseDocument);
//     });

//     test('getOrCreateUuidForFile should return existing UUID', () async {
//       final store = StoreRef<String, Map<String, dynamic>>.main();
//       const filePath = 'test/path';
//       const uuid = 'existing-uuid';

//       when(mockFile.path).thenReturn(filePath);
//       when(store.find(any, finder: anyNamed('finder')))
//           .thenAnswer((_) async => [RecordSnapshot(uuid, {})]);

//       final result = await dataSource.getOrCreateUuidForFile(mockFile);

//       expect(result, (uuid, true));
//     });

//     test('getOrCreateUuidForFile should create new UUID', () async {
//       final store = StoreRef<String, Map<String, dynamic>>.main();
//       const filePath = 'test/path';
//       const uuid = 'new-uuid';

//       when(mockFile.path).thenReturn(filePath);
//       when(store.find(any, finder: anyNamed('finder')))
//           .thenAnswer((_) async => []);
//       when(const Uuid().v4()).thenReturn(uuid);

//       final result = await dataSource.getOrCreateUuidForFile(mockFile);

//       expect(result, (uuid, false));
//     });

//     test('fetchDocument should return document', () async {
//       final store = StoreRef<String, Map<String, dynamic>>.main();
//       const uuid = 'test-uuid';
//       final documentMap = {'uuid': uuid};

//       when(store.record(uuid).get(any)).thenAnswer((_) async => documentMap);

//       final result = await dataSource.fetchDocument(uuid);

//       expect(result.uuid, uuid);
//     });

//     test('fetchAllDocuments should return list of documents', () async {
//       final store = StoreRef<String, Map<String, dynamic>>.main();
//       final documentMap = {'uuid': 'test-uuid'};

//       when(store.find(any))
//           .thenAnswer((_) async => 
//[RecordSnapshot('test-uuid', documentMap)]);

//       final result = await dataSource.fetchAllDocuments();

//       expect(result.length, 1);
//       expect(result.first.uuid, 'test-uuid');
//     });

//     test('fetchFileMetadata should return file metadata', () async {
//       final store = StoreRef<String, Map<String, dynamic>>.main();
//       const uuid = 'test-uuid';
//       final metadataMap = {'path': 'test/path'};

//       when(store.record(uuid).get(any)).thenAnswer((_) async => metadataMap);

//       final result = await dataSource.fetchFileMetadata(uuid);

//       expect(result.path, 'test/path');
//     });

//     test('saveDocument should save document', () async {
//       final store = StoreRef<String, Map<String, dynamic>>.main();
//       final document = Document(uuid: 'test-uuid', content: 'test-content');

//       await dataSource.saveDocument(document);

//       verify(store.record(document.uuid)
//.put(any, document.toMap())).called(1);
//     });

//     test('deleteDocument should delete document', () async {
//       final store = StoreRef<String, Map<String, dynamic>>.main();
//       const uuid = 'test-uuid';

//       await dataSource.deleteDocument(uuid);

//       verify(store.record(uuid).delete(any)).called(1);
//     });

//     test('updateFilePath should update file path', () async {
//       final store = StoreRef<String, Map<String, dynamic>>.main();
//       const uuid = 'test-uuid';
//       const filePath = 'new/path';
//       final existingRecord = {'filePath': 'old/path'};

//       when(store.record(uuid).get(any))
//.thenAnswer((_) async => existingRecord);

//       await dataSource.updateFilePath(uuid, filePath);

//       expect(existingRecord['filePath'], filePath);
//       verify(store.record(uuid).put(any, existingRecord)).called(1);
//     });
//   });
// }
