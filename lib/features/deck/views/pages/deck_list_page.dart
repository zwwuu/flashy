import 'package:animations/animations.dart';
import 'package:flashy/features/deck/views/widgets/deck_create_dialog.dart';
import 'package:flashy/features/deck/views/widgets/deck_list.dart';
import 'package:flutter/material.dart';

class DeckListPage extends StatelessWidget {
  const DeckListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flashy")),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: DeckList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModal(
            context: context,
            configuration: const FadeScaleTransitionConfiguration(),
            builder: (context) => const DeckCreateDialog(),
          );
        },
        tooltip: 'Create deck',
        child: const Icon(Icons.add),
      ),
    );
  }
}
