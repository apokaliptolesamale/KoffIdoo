import 'package:apk_template/features/chinchal/presentation/providers/darkmode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:apk_template/config/config.dart';

void main() async {
  await Environment.initEnvironment();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    ref.read(darkModeStateNotifierProvider.notifier).getIsDarkMode();
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Template apps',
      theme: BlueDelight().lightTheme(),
      darkTheme: BlueDelight().darkTheme(),
      themeMode: ref.watch(darkModeStateNotifierProvider).isDarkMode ==
              true //ref.watch(darkModeProvider) == true
          ? ThemeMode.dark
          : ThemeMode.light, //ThemeMode.system,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
