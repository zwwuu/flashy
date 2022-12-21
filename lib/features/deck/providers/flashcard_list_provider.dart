import 'package:flashy/features/deck/providers/flashcard_dao_provider.dart';
import 'package:flashy/shared/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flashcardListProvider =
    StreamProvider.family<List<Flashcard>, int>((ref, deckId) {
  final dao = ref.watch(flashcardDaoProvider);

  return dao.getAllFlashcards(deckId: deckId);
});
