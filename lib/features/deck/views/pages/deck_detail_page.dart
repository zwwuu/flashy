import 'package:flashy/features/deck/providers/deck_view_provider.dart';
import 'package:flashy/features/deck/views/pages/flashcard_edit_page.dart';
import 'package:flashy/shared/views/widget/error_indicator.dart';
import 'package:flashy/shared/views/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeckDetailPage extends ConsumerStatefulWidget {
  final int deckId;

  const DeckDetailPage({super.key, required this.deckId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeckDetailPageState();
}

class _DeckDetailPageState extends ConsumerState<DeckDetailPage> {
  int _position = 0;
  bool _isQuestionView = true;

  void _toggleView() {
    setState(() {
      _isQuestionView = !_isQuestionView;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deckWithFlashcards = ref.watch(deckViewProvider(widget.deckId));

    return Scaffold(
      appBar: AppBar(
          title: deckWithFlashcards.when(
              loading: () => const Text('Loading...'),
              error: (error, stackTrace) => const Text('Error'),
              data: (data) => Text(data.deck.name))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: deckWithFlashcards.when(
            error: (error, stackTrace) =>
                const ErrorIndicator(message: 'Error loading decks'),
            loading: () => const LoadingIndicator(),
            data: (data) {
              return data.flashcards.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 24.0),
                              child: Text(
                                  '${_position + 1} / ${data.flashcards.length}',
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: _toggleView,
                            onHorizontalDragEnd: (details) {
                              setState(() {
                                if (details.primaryVelocity! < -8) {
                                  _position =
                                      _position < data.flashcards.length - 1
                                          ? _position + 1
                                          : 0;
                                } else if (details.primaryVelocity! > 8) {
                                  _position = _position > 0
                                      ? _position - 1
                                      : data.flashcards.length - 1;
                                }
                                _isQuestionView = true;
                              });
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      _isQuestionView
                                          ? data.flashcards[_position].question
                                          : data.flashcards[_position].answer,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24.0, horizontal: 16.0),
                          ),
                          onPressed: () {
                            _toggleView();
                          },
                          child: const Text('FLIP'),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(
                          child: Card(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('No flashcards yet'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24.0, horizontal: 16.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FlashcardEditPage(
                                  deckId: widget.deckId,
                                  clearOnSaved: true,
                                ),
                              ),
                            );
                          },
                          child: const Text('Add flashcard'),
                        ),
                      ],
                    );
            }),
      ),
    );
  }
}
