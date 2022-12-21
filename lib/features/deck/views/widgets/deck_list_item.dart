import 'package:flashy/features/deck/domain/deck_with_flashcards.dart';
import 'package:flashy/features/deck/providers/deck_delete_provider.dart';
import 'package:flashy/features/deck/views/pages/deck_detail_page.dart';
import 'package:flashy/features/deck/views/pages/deck_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MenuItem { edit, delete }

class DeckListItem extends ConsumerWidget {
  const DeckListItem({super.key, required this.deckWithFlashcards});

  final DeckWithFlashcards deckWithFlashcards;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text(deckWithFlashcards.deck.name),
        subtitle: Text('${deckWithFlashcards.flashcards.length} flashcards'),
        trailing: PopupMenuButton(
          padding: EdgeInsets.zero,
          onSelected: (MenuItem item) {
            if (item == MenuItem.edit) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      DeckEditPage(deckId: deckWithFlashcards.deck.id),
                ),
              );
            }
            if (item == MenuItem.delete) {
              ref.read(deckDeleteProvider(deckWithFlashcards.deck.id));
            }
          },
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<MenuItem>>[
              const PopupMenuItem(
                value: MenuItem.edit,
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: MenuItem.delete,
                child: ListTile(
                  title: Text('Delete'),
                  leading: Icon(Icons.delete),
                ),
              )
            ];
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) =>
                  DeckDetailPage(deckId: deckWithFlashcards.deck.id),
            ),
          );
        },
      ),
    );
  }
}
