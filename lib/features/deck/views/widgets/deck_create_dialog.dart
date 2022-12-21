import 'package:drift/drift.dart' hide Column;
import 'package:flashy/features/deck/providers/deck_edit_provider.dart';
import 'package:flashy/shared/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeckCreateDialog extends ConsumerStatefulWidget {
  const DeckCreateDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeckCreateDialogState();
}

class _DeckCreateDialogState extends ConsumerState<DeckCreateDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create deck'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          onChanged: (value) {
            _name = value;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Name cannot be empty';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ref.read(deckEditProvider(DecksCompanion(name: Value(_name))));
              Navigator.of(context).pop();
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
