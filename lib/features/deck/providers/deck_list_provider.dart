import 'package:flashy/features/deck/domain/deck_with_flashcards.dart';
import 'package:flashy/features/deck/providers/deck_dao_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deckListProvider = StreamProvider<List<DeckWithFlashcards>>((ref) {
  final dao = ref.watch(deckDaoProvider);

  return dao.watchAllDecks();
});
