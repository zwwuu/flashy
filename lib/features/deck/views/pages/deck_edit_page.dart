import 'package:drift/drift.dart' hide Column;
import 'package:flashy/features/deck/providers/deck_edit_provider.dart';
import 'package:flashy/features/deck/providers/deck_view_provider.dart';
import 'package:flashy/features/deck/views/pages/flashcard_edit_page.dart';
import 'package:flashy/features/deck/views/widgets/flashcard_list.dart';
import 'package:flashy/shared/database/database.dart';
import 'package:flashy/shared/views/widget/error_indicator.dart';
import 'package:flashy/shared/views/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeckEditPage extends ConsumerStatefulWidget {
  const DeckEditPage({super.key, required this.deckId});

  final int deckId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeckEditPageState();
}

class _DeckEditPageState extends ConsumerState<DeckEditPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  bool _isDirty = false;

  @override
  Widget build(BuildContext context) {
    final deckWithFlashcards = ref.watch(deckViewProvider(widget.deckId));

    return Scaffold(
      appBar: AppBar(
          title: const Text("Edit Deck"),
          actions: deckWithFlashcards.when(
              error: (error, stackTrace) => null,
              loading: () => null,
              data: (data) {
                return [
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: _isDirty
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              ref.read(deckEditProvider(DecksCompanion(
                                id: Value(widget.deckId),
                                name: Value(_name),
                              )));
                              setState(() {
                                _isDirty = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Deck updated')),
                              );
                            }
                          }
                        : null,
                  ),
                ];
              })),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: deckWithFlashcards.when(
            data: (data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      initialValue: data.deck.name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      onChanged: (value) {
                        _name = value;
                        setState(() {
                          _isDirty = true;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: FlashcardList(flashcards: data.flashcards),
                  ),
                  const SizedBox(height: 24),
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
                            deckId: data.deck.id,
                            clearOnSaved: true,
                          ),
                        ),
                      );
                    },
                    child: const Text('Add Flashcard'),
                  ),
                ],
              );
            },
            error: (error, stackTrace) =>
                const ErrorIndicator(message: 'Error loading decks'),
            loading: () => const LoadingIndicator(),
          )),
    );
  }
}
