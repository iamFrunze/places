import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DataClassName('SearchItem')
class SearchItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get category => text()();
}

@DriftDatabase(tables: [SearchItems])
class Database extends _$Database {
  @override
  int get schemaVersion => 1;

  Database() : super(_openConnection());
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  });
}
