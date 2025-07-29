import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/services/key_value_storage_service.dart';
import '../../../../config/services/key_value_storage_service_impl.dart';

final darkModeProvider = StateProvider<bool>((ref) {
  return false;
});

final darkModeStateNotifierProvider =
    StateNotifierProvider<DarkModeStateNotifier, DarkModeState>((ref) {
  final keyValueStorageService = KeyValueStorageserviceImpl();
  return DarkModeStateNotifier(keyValueStorageService: keyValueStorageService);
});

class DarkModeStateNotifier extends StateNotifier<DarkModeState> {
  final KeyValueStorageservice keyValueStorageService;
  DarkModeStateNotifier({required this.keyValueStorageService})
      : super(DarkModeState());

  Future<void> saveIsDarkMode() async {
    await keyValueStorageService
        .setKeyValue('DarkMode', state.isDarkMode!)
        .whenComplete(() => log('Se completo el salvado del DarkMode'));
  }

  Future<void> getIsDarkMode() async {
    if (await keyValueStorageService.containsKey('DarkMode')) {
      final isDarkModePrefs =
          await keyValueStorageService.getValue<bool>('DarkMode');
      state = state.copyWith(isDarkMode: isDarkModePrefs);
    } else {
      saveIsDarkMode();
    }
  }

  Future<void> changeIsDarkMode() async {
    state = state.copyWith(isDarkMode: !state.isDarkMode!);
    await saveIsDarkMode();
  }
}

class DarkModeState {
  final bool? isDarkMode;
  DarkModeState({this.isDarkMode = false});

  DarkModeState copyWith({bool? isDarkMode}) {
    return DarkModeState(isDarkMode: isDarkMode ?? this.isDarkMode);
  }
}
