import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flashy/shared/database/daos/decks_dao.dart';
import 'package:flashy/shared/database/daos/flashcards_dao.dart';
import 'package:flashy/shared/database/entities/decks.dart';
import 'package:flashy/shared/database/entities/flashcards.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Decks, Flashcards], daos: [DecksDao, FlashcardsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
