import 'package:flashy/features/deck/views/pages/deck_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlashyApp extends ConsumerWidget {
  const FlashyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flashy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const DeckListPage(),
    );
  }
}
