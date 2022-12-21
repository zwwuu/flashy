import 'package:flashy/features/deck/providers/deck_list_provider.dart';
import 'package:flashy/features/deck/views/widgets/deck_list_item.dart';
import 'package:flashy/shared/views/widget/error_indicator.dart';
import 'package:flashy/shared/views/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeckList extends ConsumerWidget {
  const DeckList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deckList = ref.watch(deckListProvider);

    return deckList.when(
      loading: () => const LoadingIndicator(),
      error: (error, stackTrace) =>
          const ErrorIndicator(message: 'Error loading decks'),
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return DeckListItem(deckWithFlashcards: data[index]);
          },
        );
      },
    );
  }
}
