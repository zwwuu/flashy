import 'package:flashy/shared/database/database.dart';

class DeckWithFlashcards {
  final Deck deck;
  final List<Flashcard> flashcards;

  DeckWithFlashcards({required this.deck, required this.flashcards});
}
