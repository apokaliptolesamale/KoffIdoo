import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/config/domain/models/theme_model.dart';
import '../design/theme.dart';
import '../interfaces/controller.dart';

class CustomGetxController extends GetxController implements CustomController {
  //
  RxBool isDarkMode = false.obs;
  RxInt currentTheme = 0.obs;

  List<ThemeData> _themes = [
    ...CustomThemeSingleList.instance.getThemesData,
    ThemeData.light(),
    ThemeData.dark(),
  ];

  CustomGetxController() : super() {
    if (!Get.isRegistered<CustomGetxController>()) {
      Get.lazyPut(() => this);
      globalThemeData = theme;
    }
  }

  List<ThemeData> get getThemesData {
    final themes = CustomThemeSingleList.instance.getThemesData;
    _themes = [
      ...themes,
      ThemeData.light(),
      ThemeData.dark(),
    ];
    return _themes;
  }

  bool get isDark => isDarkMode.value;

  ThemeData get theme => _themes.elementAt(currentTheme.value);

  ThemeData getActiveTheme() {
    final themes = CustomThemeSingleList.instance.getThemes;
    for (var i = 0; i < themes.length; i++) {
      ThemeModel item = themes.elementAt(i);
      if (item.active) return item.wrap();
    }
    return ThemeData.light();
  }

  void selectTheme(BuildContext context) {
    List<ThemeData> themes = getThemesData;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Selecciona un tema'),
              content: DropdownButton(
                //value: currentTheme,
                items: List.generate(themes.length, (index) {
                  return DropdownMenuItem(
                    child: Text('Tema: $index'),
                    value: index,
                  );
                }),
                onChanged: (value) {
                  currentTheme.value = value as int;
                  globalThemeData = theme;
                  final ctsl = CustomThemeSingleList.instance;
                  setActiveTheme(ctsl.get(currentTheme.value));
                  Navigator.pop(_);
                },
              ),
            ));
  }

  setActiveTheme(ThemeModel theme) {
    List<ThemeData> themes = getThemesData;
    final ctsl = CustomThemeSingleList.instance;
    for (var i = 0; i < themes.length; i++) {
      if (i < themes.length - 2) {
        ThemeModel item = ctsl.get(i);
        item.active = item.name == theme.name;
        ctsl.set(i, item);
      }
      /*ThemeData item = themes.elementAt(i);
      if (item is ThemeModel && theme is ThemeModel) {
        (_themes[i] as ThemeModel).active =
            (item as ThemeModel).name == (theme as ThemeModel).name;
      }*/
    }
  }

  @override
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
