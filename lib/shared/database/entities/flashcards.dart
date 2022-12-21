import 'package:drift/drift.dart';
import 'package:flashy/shared/database/entities/decks.dart';

class Flashcards extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get question => text()();

  TextColumn get answer => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  IntColumn get deckId =>
      integer().references(Decks, #id, onDelete: KeyAction.cascade)();
}
