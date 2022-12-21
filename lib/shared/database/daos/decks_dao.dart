import 'package:drift/drift.dart';
import 'package:flashy/features/deck/domain/deck_with_flashcards.dart';
import 'package:flashy/shared/database/database.dart';
import 'package:flashy/shared/database/entities/decks.dart';
import 'package:flashy/shared/database/entities/flashcards.dart';
import 'package:rxdart/rxdart.dart';

part 'decks_dao.g.dart';

@DriftAccessor(tables: [Decks, Flashcards])
class DecksDao extends DatabaseAccessor<AppDatabase> with _$DecksDaoMixin {
  DecksDao(AppDatabase db) : super(db);

  Stream<List<DeckWithFlashcards>> watchAllDecks() {
    final deckStream = db.select(decks).watch();
    final flashcardStream = db.select(flashcards).watch();

    // combine the two streams into a single stream
    return Rx.combineLatest2(deckStream, flashcardStream,
        (List<Deck> decks, List<Flashcard> flashcards) {
      final flashcardsByDeckId = <int, List<Flashcard>>{};
      for (final flashcard in flashcards) {
        flashcardsByDeckId
            .putIfAbsent(flashcard.deckId, () => [])
            .add(flashcard);
      }

      return decks.map((deck) {
        return DeckWithFlashcards(
          deck: deck,
          flashcards: flashcardsByDeckId[deck.id] ?? [],
        );
      }).toList();
    });
  }

  Stream<DeckWithFlashcards> watchDeckById({required int deckId}) {
    final deckStream =
        (db.select(decks)..where((d) => d.id.equals(deckId))).watch();
    final flashcardStream =
        (db.select(flashcards)..where((f) => f.deckId.equals(deckId))).watch();

    return Rx.combineLatest2(deckStream, flashcardStream,
        (List<Deck> decks, List<Flashcard> flashcards) {
      return DeckWithFlashcards(
        deck: decks.first,
        flashcards: flashcards,
      );
    });
  }

  Future<int> upsertDeck({required DecksCompanion deck}) async {
    return await (db.into(decks).insert(
      deck,
      onConflict: DoUpdate(
        (old) {
          return DecksCompanion.custom(
            name: Constant(deck.name.value),
            updatedAt: currentDateAndTime,
          );
        },
      ),
    ));
  }

  Future<int> deleteDeck({required int id}) async {
    return await (db.delete(decks)..where((d) => d.id.equals(id))).go();
  }
}
