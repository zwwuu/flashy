import 'package:flashy/features/deck/providers/deck_dao_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deckDeleteProvider = FutureProvider.family<int, int>((ref, deckId) async {
  final repo = ref.watch(deckDaoProvider);

  return await repo.deleteDeck(id: deckId);
});
