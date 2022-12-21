import 'package:flashy/shared/database/daos/decks_dao.dart';
import 'package:flashy/shared/database/database.dart';
import 'package:flashy/shared/providers/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deckDaoProvider = Provider<DecksDao>((ref) {
  final AppDatabase db = ref.watch(databaseProvider);

  return DecksDao(db);
});
