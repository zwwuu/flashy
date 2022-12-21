import 'package:flashy/shared/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);

  return database;
});
