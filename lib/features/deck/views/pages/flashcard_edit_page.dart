import 'package:drift/drift.dart' hide Column;
import 'package:flashy/features/deck/providers/flashcard_edit_provider.dart';
import 'package:flashy/shared/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlashcardEditPage extends ConsumerStatefulWidget {
  const FlashcardEditPage(
      {super.key,
      this.flashcardId,
      this.question = '',
      this.answer = '',
      required this.deckId,
      this.clearOnSaved = false});

  final String question;
  final String answer;
  final int deckId;
  final int? flashcardId;
  final bool clearOnSaved;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FlashcardEditPageState();
}

class _FlashcardEditPageState extends ConsumerState<FlashcardEditPage> {
  final _formKey = GlobalKey<FormState>();
  late String _updatedQuestion;
  late String _updatedAnswer;
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    _updatedQuestion = widget.question;
    _updatedAnswer = widget.answer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Flashcard'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        child: TextFormField(
                          initialValue: widget.question,
                          maxLines: null,
                          minLines: 4,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(16.0),
                            labelText: "Question",
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          keyboardType: TextInputType.multiline,
                          onChanged: (value) {
                            _updatedQuestion = value;
                            setState(() {
                              _isDirty = true;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Question cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Card(
                        child: TextFormField(
                          maxLines: null,
                          minLines: 4,
                          initialValue: widget.answer,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(16.0),
                            labelText: "Answer",
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onChanged: (value) {
                            _updatedAnswer = value;
                            setState(() {
                              _isDirty = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 16.0),
                ),
                onPressed: _isDirty
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          ref.read(flashcardEditProvider(FlashcardsCompanion(
                            id: widget.flashcardId == null
                                ? const Value.absent()
                                : Value(widget.flashcardId!),
                            question: Value(_updatedQuestion),
                            answer: Value(_updatedAnswer),
                            deckId: Value(widget.deckId),
                          )));
                          if (widget.clearOnSaved) {
                            _formKey.currentState!.reset();
                          }
                          setState(() {
                            _isDirty = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Flashcard saved')),
                          );
                        }
                      }
                    : null,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
