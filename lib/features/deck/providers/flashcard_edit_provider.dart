import 'package:flashy/features/deck/providers/flashcard_dao_provider.dart';
import 'package:flashy/shared/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flashcardEditProvider =
    FutureProvider.family<int, FlashcardsCompanion>((ref, flashcard) async {
  final repo = ref.watch(flashcardDaoProvider);

  return await repo.upsertFlashcard(flashcard: flashcard);
});
