import 'package:flashy/features/deck/providers/flashcard_dao_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flashcardDeleteProvider =
    FutureProvider.family<int, int>((ref, flashcardId) async {
  final repo = ref.watch(flashcardDaoProvider);

  return await repo.deleteFlashcard(id: flashcardId);
});
