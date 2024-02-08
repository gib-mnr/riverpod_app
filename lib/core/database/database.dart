import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

@DriftDatabase(tables: [TodoItems, ArticleEntities])
class AppDb extends _$AppDb {

  // Private constructor
  AppDb._internal() : super(_openConnection());

  // The single instance of AppDb
  static final AppDb instance = AppDb._internal();

  /// Schema: Defines the structure of data, including tables, columns,
  /// data types, relationships, and constraints.
  /// Schema Version: Tracks changes made to the schema over time.
  /// Each version represents a specific snapshot of the schema's definition.
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'dba.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase.createInBackground(file);
  });
}


class TodoItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  IntColumn get category => integer().nullable()();
}



// @DataClassName('ArticleEntity')
class ArticleEntities extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  // TextColumn get type => text().nullable()();
  TextColumn get type => text()();
  TextColumn get description => text().nullable()();
  // Add all other fields that your articles need, mapping them to the JSON model.
  TextColumn get url => text().nullable()();
  TextColumn get urlToImage => text().nullable()();
  TextColumn get publishedAt => text().nullable()();
  TextColumn get content => text().nullable()();
  // Assuming 'source' is a simple string. If it's a nested object, you'll need a separate table for it.
  TextColumn get source => text().nullable()();
}

