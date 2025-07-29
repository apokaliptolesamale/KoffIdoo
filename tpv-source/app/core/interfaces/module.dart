// ignore_for_file: prefer_final_fields

import '../../../app/core/interfaces/app_page.dart';

abstract class Module<T> {
  List<CustomAppPageImpl<T>> _pages = [];

  List<CustomAppPageImpl<T>> get getPages => _pages;

  String getDescription();

  String getId();

  String getName();

  List<CustomAppPageImpl<T>> loadRoutes();
}
