import 'package:flutter/material.dart';

import '../../routes/app_pages.dart';
import '../constants/controllers.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final pages = AppPages.getByName(settings.name!);
  pages.binding!.dependencies();
  return _getPageRoute(pages.page());
}

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: Routes.getInstance.getPath("HOME"),
      onGenerateRoute: generateRoute,
    );

Navigator navegateTo(String route) => Navigator(
      key: navigationController.navigationKey,
      initialRoute: route,
      onGenerateRoute: generateRoute,
    );

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
