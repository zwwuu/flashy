import 'package:drift/drift.dart';
import 'package:flashy/shared/database/database.dart';
import 'package:flashy/shared/database/entities/flashcards.dart';

part 'flashcards_dao.g.dart';

@DriftAccessor(tables: [Flashcards])
class FlashcardsDao extends DatabaseAccessor<AppDatabase>
    with _$FlashcardsDaoMixin {
  FlashcardsDao(AppDatabase db) : super(db);

  Stream<List<Flashcard>> getAllFlashcards({required int deckId}) {
    return (db.select(flashcards)..where((f) => f.deckId.equals(deckId)))
        .watch();
  }

  Future<int> upsertFlashcard({required FlashcardsCompanion flashcard}) async {
    return await (db.into(flashcards).insert(
      flashcard,
      onConflict: DoUpdate(
        (old) {
          return FlashcardsCompanion.custom(
            question: Constant(flashcard.question.value),
            answer: Constant(flashcard.answer.value),
            updatedAt: currentDateAndTime,
          );
        },
      ),
    ));
  }

  Future<int> deleteFlashcard({required int id}) async {
    return await (db.delete(flashcards)..where((d) => d.id.equals(id))).go();
  }
}
