import 'package:drift/drift.dart';
import 'package:riverpod_app/core/database/database.dart';


AppDb db = AppDb.instance;

@override
MigrationStrategy get migration => MigrationStrategy(
  // When the database is first created, create all tables
  onCreate: (Migrator m) {
    return m.createAll();
  },

  // When the database needs to be upgraded (version is increased)
  onUpgrade: (Migrator m, int from, int to) async {
    for (var i = from; i < to; i++) {
      await _updateToNextVersion(m, i + 1);
    }
  },
   // Optional: Set up steps to take before opening the database
  beforeOpen: (details) async {
    if (details.wasCreated) {
      // Database was just created, initialize data
    }
  },
);

  Future<void> _updateToNextVersion(Migrator m, int nextVersion) async {
    switch (nextVersion) {
      case 2:
        await _migrateToV2(m);
        break;
      case 3:
        await _migrateToV3(m);
        break;
    // More cases for other versions...
    }
  }

Future<void> _migrateToV2(Migrator m) async {
  // Your migration logic for version 2
  //   await m.createTable($ArticleEntities);
  // Assuming the `type` column was added in version 2
  await m.addColumn(db.articleEntities, db.articleEntities.type);
}

Future<void> _migrateToV3(Migrator m) async {
  // Your migration logic for version 3
}

