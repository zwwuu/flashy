import 'package:flashy/features/deck/domain/deck_with_flashcards.dart';
import 'package:flashy/shared/database/daos/decks_dao.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'deck_dao_provider.dart';

final deckViewProvider =
    StreamProvider.family<DeckWithFlashcards, int>((ref, deckId) {
  final DecksDao repo = ref.watch(deckDaoProvider);
  final deck = repo.watchDeckById(deckId: deckId);

  return deck;
});
