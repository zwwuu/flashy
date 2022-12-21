import 'package:flashy/shared/database/daos/flashcards_dao.dart';
import 'package:flashy/shared/database/database.dart';
import 'package:flashy/shared/providers/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flashcardDaoProvider = Provider<FlashcardsDao>((ref) {
  final AppDatabase db = ref.watch(databaseProvider);

  return FlashcardsDao(db);
});
