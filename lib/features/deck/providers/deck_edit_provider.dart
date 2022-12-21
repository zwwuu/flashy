import 'package:flashy/features/deck/providers/deck_dao_provider.dart';
import 'package:flashy/shared/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deckEditProvider =
    FutureProvider.family<int, DecksCompanion>((ref, deck) async {
  final repo = ref.watch(deckDaoProvider);

  return await repo.upsertDeck(deck: deck);
});
