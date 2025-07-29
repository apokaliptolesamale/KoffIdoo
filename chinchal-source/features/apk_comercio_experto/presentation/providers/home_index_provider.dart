import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeIndexProvider = StateNotifierProvider<IndexNotifier, int>((ref) {
  return IndexNotifier();
});

class IndexNotifier extends StateNotifier<int> {
  IndexNotifier() : super(1); // Initialize with 0

  void setIndex(int index) {
    state = index; // Actualizamos el estado
  }

}