import 'package:flashy/features/deck/providers/flashcard_delete_provider.dart';
import 'package:flashy/features/deck/views/pages/flashcard_edit_page.dart';
import 'package:flashy/shared/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MenuItem { edit, delete }

class FlashcardListItem extends ConsumerWidget {
  const FlashcardListItem({super.key, required this.flashcard});

  final Flashcard flashcard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text(flashcard.question),
        subtitle: Text(flashcard.answer.length > 40
            ? '${flashcard.answer.substring(0, 40)}...'
            : flashcard.answer),
        trailing: PopupMenuButton(
          padding: EdgeInsets.zero,
          onSelected: (MenuItem item) {
            if (item == MenuItem.edit) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FlashcardEditPage(
                    question: flashcard.question,
                    answer: flashcard.answer,
                    deckId: flashcard.deckId,
                    flashcardId: flashcard.id,
                  ),
                ),
              );
            }

            if (item == MenuItem.delete) {
              ref.read(flashcardDeleteProvider(flashcard.id));
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
      ),
    );
  }
}
