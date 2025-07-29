import 'package:flutter_riverpod/flutter_riverpod.dart';

final expertModeProvider = StateNotifierProvider<BoolNotifier, bool>((ref) {
  return BoolNotifier();
});

class BoolNotifier extends StateNotifier<bool> {
  BoolNotifier() : super(false); // Initialize with false

  void setBool(bool mode) {
    state = mode; // Actualizamos el estado
  }

}