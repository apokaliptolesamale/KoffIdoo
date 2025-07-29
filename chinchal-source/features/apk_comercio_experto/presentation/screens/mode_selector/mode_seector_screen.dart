import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/expert_mode_provider.dart';

class ModeSelectionScreen extends ConsumerWidget {
  const ModeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isExpertMode = ref.watch(expertModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Seleccionar Modo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Selecciona el modo de la tienda",
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(expertModeProvider.notifier).setBool(false);
                context.go('/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: !isExpertMode ? Colors.blue : Colors.grey,
              ),
              child: const Text("Modo Ligero"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ref.read(expertModeProvider.notifier).setBool(true);
                context.go('/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isExpertMode ? Colors.blue : Colors.grey,
              ),
              child: const Text("Modo Experto"),
            ),
          ],
        ),
      ),
    );
  }
}
