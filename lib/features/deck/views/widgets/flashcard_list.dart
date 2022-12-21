import 'package:flashy/shared/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'flashcard_list_item.dart';

class FlashcardList extends StatelessWidget {
  const FlashcardList({super.key, required this.flashcards});

  final List<Flashcard> flashcards;

  @override
  Widget build(BuildContext context) {
    return flashcards.isNotEmpty
        ? SingleChildScrollView(
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              children: flashcards
                  .map((flashcard) => FlashcardListItem(flashcard: flashcard))
                  .toList(),
            ),
          )
        : Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Empty',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          );
  }
}
