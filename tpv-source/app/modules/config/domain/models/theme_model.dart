// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// ignore_for_file: overridden_fields, empty_catches, deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/config/domain/models/custom_shadow_model.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../../app/core/services/logger_service.dart';
import '../../../../core/design/brightness_extension.dart';
import '../../../../core/design/color.dart';
import '../../../../core/design/color_scheme_extension.dart';
import '../../../../core/design/material_custom_color.dart';
import '../../../../core/helpers/functions.dart';
import '../../../../modules/config/domain/models/decoration_model.dart';
import '../entities/theme.dart' as theme;
import 'custom_icon_theme_data_model.dart';
import 'custom_text_style_model.dart';
import 'custom_text_theme_model.dart';
import 'custom_typography_model.dart';

ThemeList themeListModelFromJson(String str) =>
    ThemeList.fromJson(json.decode(str));

ThemeModel themeModelFromJson(String str) =>
    ThemeModel.fromJson(json.decode(str));

String themeModelToJson(ThemeModel data) => json.encode(data.toJson());

class CustomThemeSingleList {
  static final CustomThemeSingleList instance =
      !Get.isRegistered() ? CustomThemeSingleList._internal([]) : Get.find();
  final List<ThemeModel> _themes;

  factory CustomThemeSingleList({
    required themes,
  }) =>
      instance;
  CustomThemeSingleList._internal(this._themes) {
    Get.lazyPut(() => this);
  }

  List<ThemeModel> get getThemes => _themes;

  List<ThemeData> get getThemesData => _themes.map((e) => e.wrap()).toList();

  bool add(ThemeModel theme) {
    if (getByName(theme.name) == null) {
      _themes.add(theme);
      return true;
    }
    return false;
  }

  Map<String, ThemeModel> asMap() {
    Map<String, ThemeModel> map = {};
    _themes.map((e) {
      return map.addEntries([MapEntry(e.name, e)]);
    });
    return map;
  }

  bool exists(ThemeModel theme) {
    return _themes.contains(theme);
  }

  ThemeModel get(int position) {
    return _themes[position];
  }

  ThemeModel? getByName(String name) {
    ThemeModel? theme;

    if (_themes.isEmpty) return null;
    for (var element in _themes) {
      if (element.name == name) {
        theme = element;
        break;
      }
    }
    return theme;
  }

  CustomThemeSingleList set(int position, ThemeModel newTheme) {
    _themes[position] = newTheme;
    return this;
  }
}

class ThemeList<T extends ThemeModel> implements EntityModelList<T> {
  final List<T> themes;

  ThemeList({
    required this.themes,
  });

  factory ThemeList.fromEmpty() => ThemeList(
        themes: List<T>.from([
          {
            "name": "Default",
            "active": false,
            "colors": [
              {
                "name": "primary",
                "hex": "#1d4f7b",
                "rgb": "29,79,123",
                "hsl": "208,61%,29%"
              },
              {
                "name": "secondary",
                "hex": "#006ea3",
                "rgb": "0,110,163",
                "hsl": "199,100%,31%"
              },
              {
                "name": "tertiary",
                "hex": "#25669f",
                "rgb": "37,102,159",
                "hsl": "208,62%,38%"
              },
              {"name": "PaleGrey", "hex": "#F6F5F4"},
              {"name": "WhiteFont", "hex": "#FFFFFF"}
            ],
            "decorations": [
              {
                "name": "LayoutBody",
                "color": "#1d4f7b",
                "opacityColor": 0.3,
                "hoverOpacityColor": 0.6,
                "borderRadius": 8,
                "borderRadiusType": "circular"
              },
              {
                "name": "LayoutHeader",
                "color": "#1d4f7b",
                "opacityColor": 0.3,
                "hoverOpacityColor": 0.6,
                "borderRadius": "lt10,rt10",
                "borderRadiusType": "only"
              },
              {
                "name": "CardBody",
                "color": "PaleGrey",
                "opacityColor": 0.3,
                "hoverOpacityColor": 0.6,
                "borderRadius": 8,
                "borderRadiusType": "circular"
              }
            ]
          }
        ].map((x) => ThemeModel.fromJson(x))),
      );

  factory ThemeList.fromJson(Map<String, dynamic> json) => ThemeList(
        themes: json.containsKey("themes")
            ? List<T>.from(json["themes"].map((x) => ThemeModel.fromJson(x)))
            : [],
      );
  factory ThemeList.fromStringJson(String strJson) => ThemeList(
        themes: List<T>.from(
            json.decode(strJson)["themes"].map((x) => ThemeModel.fromJson(x))),
      );

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return ThemeList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!themes.contains(element)) themes.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return ThemeList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => themes;

  Map<String, dynamic> toJson() => {
        "themes": List<dynamic>.from(themes.map((x) => x.toJson())),
      };
}

class ThemeModel implements EntityModel {
  SearchViewThemeData? searchViewTheme;
  SearchBarThemeData? searchBarTheme;
  DatePickerThemeData? datePickerTheme;
  ActionIconThemeData? actionIconTheme;
  // GENERAL CONFIGURATION
  // PROPIEDADES BOOLEANAS
// Especifica si se debe aplicar el color de superposición de elevación al tema.

  bool applyElevationOverlayColor;

  // Especifica si se debe usar Material Design 3 para el tema.

  bool useMaterial3;

  // PROPIEDADES DE CADENA Y BOOLEANAS
// El nombre del tema.

  final String name;

  bool active;
  // PROPIEDADES DE LISTA
// La lista de colores utilizados en el tema.

  final List<Color> colors;

  final List<DecorationModel> decorations;

// PROPIEDADES DE COLOR
// El brillo del tema (claro u oscuro).

  Brightness brightness;
  // El color de fondo del canvas.

  Color canvasColor;

// El color de fondo de las tarjetas.

  Color cardColor;
  // El esquema de color utilizado en el tema.

  ColorScheme? colorScheme;

// El color de semilla utilizado para generar el esquema de color.

  Color? colorSchemeSeed;

// El color de fondo de los diálogos.

  Color dialogBackgroundColor;

// El color utilizado para indicar que un widget está deshabilitado.

  Color disabledColor;

// El color utilizado para separar el contenido en la interfaz de usuario.

  Color dividerColor;

// El color utilizado para indicar que un widget tiene el enfoque.

  Color focusColor;

// El color utilizado para resaltar el contenido en la interfaz de usuario.

  Color highlightColor;

// El color utilizado para el texto de sugerencia en la interfaz de usuario.

  Color hintColor;

// El color utilizado cuando un widget se coloca sobre él.

  Color hoverColor;

// El color utilizado para los indicadores (como la barra de progreso).

  Color? indicatorColor;

// El color primario utilizado en el tema.

  Color primaryColor;

// La variante más oscura del color primario utilizado en el tema.

  Color primaryColorDark;

// La variante más clara del color primario utilizado en el tema.

  Color primaryColorLight;

// El conjunto de colores primarios utilizado en el tema.

  MaterialColor primarySwatch;

// El color de fondo del widget Scaffold.

  Color scaffoldBackgroundColor;

// El color utilizado para los encabezados secundarios en la interfaz de usuario.

  Color secondaryHeaderColor;

// El color utilizado para las sombras en la interfaz de usuario.

  Color shadowColor;

// El color utilizado cuando se hace clic en un widget (como cuando se toca).

  Color splashColor;

// El color utilizado para los widgets no seleccionados en la interfaz de usuario.

  Color unselectedWidgetColor;

// PROPIEDADES DE TIPOGRAFÍA E ICONOGRAFÍA
// La familia de fuentes utilizada en el tema.

  String? fontFamily;

// La familia de fuentes de respaldo utilizada en el tema.

  List<String>? fontFamilyFallback;

// El paquete utilizado para los recursos en el tema.

  String? package;

// El tema de iconos utilizado en el tema.

  IconThemeData iconTheme;

// El tema de iconos primarios utilizado en el tema.

  IconThemeData? primaryIconTheme;

// El tema de texto primario utilizado en el tema.
  TextTheme primaryTextTheme;

// El tema de texto utilizado en el tema.

  TextTheme textTheme;

// La tipografía utilizada en el tema.

  Typography typography;
//

  ThemeData? _themeData;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  ThemeModel({
    required this.name,
    required this.colors,
    required this.decorations,
    required this.active,
    // For the sanity of the reader, make sure these properties are in the same
    // order in every place that they are separated by section comments (e.g.
    // GENERAL CONFIGURATION). Each section except for deprecations should be
    // alphabetical by symbol name.

    // GENERAL CONFIGURATION
    required this.applyElevationOverlayColor,
    NoDefaultCupertinoThemeData? cupertinoOverrideTheme,
    Map<Object, ThemeExtension<dynamic>>? extensions,
    InputDecorationTheme? inputDecorationTheme,
    MaterialTapTargetSize? materialTapTargetSize,
    PageTransitionsTheme? pageTransitionsTheme,
    TargetPlatform? platform,
    ScrollbarThemeData? scrollbarTheme,
    InteractiveInkFeatureFactory? splashFactory,
    required this.useMaterial3,
    VisualDensity? visualDensity,
    // COLOR
    // [colorScheme] is the preferred way to configure colors. The other color
    // properties (as well as primaryColorBrightness, and required this.)
    // will gradually be phased out, see https://github.com/flutter/flutter/issues/91772.
    required this.brightness,
    required this.canvasColor,
    required this.cardColor,
    required this.dialogBackgroundColor,
    required this.disabledColor,
    required this.dividerColor,
    required this.focusColor,
    required this.highlightColor,
    required this.hintColor,
    required this.hoverColor,
    required this.primaryColor,
    required this.primaryColorDark,
    required this.primaryColorLight,
    required this.primarySwatch,
    required this.scaffoldBackgroundColor,
    required this.secondaryHeaderColor,
    required this.shadowColor,
    required this.splashColor,
    required this.unselectedWidgetColor,
    ColorScheme? colorScheme,
    Color? colorSchemeSeed,
    Color? indicatorColor,
    // TYPOGRAPHY & ICONOGRAPHY
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    required this.iconTheme,
    IconThemeData? primaryIconTheme,
    required this.primaryTextTheme,
    required this.textTheme,
    required this.typography,
    // COMPONENT THEMES
    AppBarTheme? appBarTheme,
    BadgeThemeData? badgeTheme,
    MaterialBannerThemeData? bannerTheme,
    BottomAppBarTheme? bottomAppBarTheme,
    BottomNavigationBarThemeData? bottomNavigationBarTheme,
    BottomSheetThemeData? bottomSheetTheme,
    ButtonBarThemeData? buttonBarTheme,
    ButtonThemeData? buttonTheme,
    CardTheme? cardTheme,
    CheckboxThemeData? checkboxTheme,
    ChipThemeData? chipTheme,
    DataTableThemeData? dataTableTheme,
    DialogTheme? dialogTheme,
    DividerThemeData? dividerTheme,
    DrawerThemeData? drawerTheme,
    DropdownMenuThemeData? dropdownMenuTheme,
    ElevatedButtonThemeData? elevatedButtonTheme,
    ExpansionTileThemeData? expansionTileTheme,
    FilledButtonThemeData? filledButtonTheme,
    FloatingActionButtonThemeData? floatingActionButtonTheme,
    IconButtonThemeData? iconButtonTheme,
    ListTileThemeData? listTileTheme,
    MenuBarThemeData? menuBarTheme,
    MenuButtonThemeData? menuButtonTheme,
    MenuThemeData? menuTheme,
    NavigationBarThemeData? navigationBarTheme,
    NavigationDrawerThemeData? navigationDrawerTheme,
    NavigationRailThemeData? navigationRailTheme,
    OutlinedButtonThemeData? outlinedButtonTheme,
    PopupMenuThemeData? popupMenuTheme,
    ProgressIndicatorThemeData? progressIndicatorTheme,
    RadioThemeData? radioTheme,
    SegmentedButtonThemeData? segmentedButtonTheme,
    SliderThemeData? sliderTheme,
    SnackBarThemeData? snackBarTheme,
    SwitchThemeData? switchTheme,
    TabBarTheme? tabBarTheme,
    TextButtonThemeData? textButtonTheme,
    TextSelectionThemeData? textSelectionTheme,
    TimePickerThemeData? timePickerTheme,
    ToggleButtonsThemeData? toggleButtonsTheme,
    TooltipThemeData? tooltipTheme,
  }) {
    final ccsl = CustomColorSingleList.instance;
    final ctsl = CustomTextStyleSingleList.instance;
    final cssl = CustomShadowSingleList.instance;
    // Definición del esquema de colores..
    // Color que se utiliza para la barra de navegación inferior
    final bottomAppBarColor = ccsl.getByName("bottomAppBarColor");

    // Color que se utiliza para indicar un elemento activo en una lista o cuadrícula
    final toggleableActiveColor = ccsl.getByName("toggleableActiveColor");

    // Color que se utiliza para indicar una fila seleccionada en una tabla
    final selectedRowColor = ccsl.getByName("selectedRowColor");
    // Color que se utiliza para indicar un error en la interfaz de usuario
    final errorContainer = ccsl.getByName("errorContainer");

    // Color principal de la aplicación
    final primaryContainer = ccsl.getByName("primaryContainer");

    // Color terciario de la aplicación
    final tertiaryContainer = ccsl.getByName("tertiaryContainer");

    // Color secundario de la aplicación
    final secondaryContainer = ccsl.getByName("secondaryContainer");

    // Variante del color principal
    final primaryVariant = ccsl.getByName("primaryVariant");

    // Variante del color secundario
    final secondaryVariant = ccsl.getByName("secondaryVariant");

    // Variante del color de superficie
    final surfaceVariant = ccsl.getByName("surfaceVariant");

    // Color inverso del color de error
    final inversePrimary = ccsl.getByName("errorContainer");

    // Color inverso del color de superficie
    final inverseSurface = ccsl.getByName("inverseSurface");

    // Color que se utiliza para oscurecer la interfaz de usuario
    final scrim = ccsl.getByName("scrim");

    // Color que se utiliza para representar sombras en la interfaz de usuario
    final shadow = ccsl.getByName("shadow");

    // Color que se utiliza para agregar un tinte a la superficie de la interfaz de usuario
    final surfaceTint = ccsl.getByName("surfaceTint");

    // Segundo color terciario
    final tertiary = ccsl.getByName("tertiary");

    // Color que se utiliza para el texto de un mensaje de error
    final onErrorContainer = ccsl.getByName("onErrorContainer");

    // Color que se utiliza para el texto en un contenedor terciario
    final onTertiaryContainer = ccsl.getByName("onTertiaryContainer");

    // Color que se utiliza para el texto en un contenedor principal
    final onPrimaryContainer = ccsl.getByName("onPrimaryContainer");

    // Color que se utiliza para el texto en un contenedor secundario
    final onSecondaryContainer = ccsl.getByName("onSecondaryContainer");

    // Color de contorno de una variante
    final outlineVariant = ccsl.getByName("outlineVariant");

    // Color que se utiliza para el texto en una variante de superficie
    final onSurfaceVariant = ccsl.getByName("onSurfaceVariant");

    // Color que se utiliza para el texto en el color terciario
    final onTertiary = ccsl.getByName("onTertiary");

    // Color de contorno
    final outline = ccsl.getByName("outline");

    // Color que se utiliza para el texto en la superficie inversa
    final onInverseSurface = ccsl.getByName("onInverseSurface");

    // Color que se utiliza para el tinte de la superficie
    final surfaceTintColor = ccsl.getByName("surfaceTintColor");

    //Color que se utiliza para los dialog
    dialogBackgroundColor = ccsl.getByName("dialogBackgroundColor")!.color;
    //Color del widget cuando se produce una interacción con el mismo, como un toque o un clic.
    final overlayColor = ccsl.getByName("overlayColor");
    //Color primario de la aplicación
    final primaryColor = CustomColor.fromString("primary");

    final backgroundColor = CustomColor.fromString("backgroundColor");

    final selectedItemColor = CustomColor.fromString("selectedItemColor");

    final buttonColor = CustomColor.fromString("buttonColor");

    final deleteIconColor = CustomColor.fromString("deleteIconColor");

    final scaffoldBackgroundColor =
        CustomColor.fromString("scaffoldBackgroundColor");

    //Definición de stilos de textos
    final titleTextStyle = ctsl.getByName("Title");
    final toolbarTextStyle = ctsl.getByName("toolbarTextStyle");
    final contentTextStyle = ctsl.getByName("contentTextStyle");
    final headerHintStyle = ctsl.getByName("headerHintStyle");
    final hintStyle = ctsl.getByName("hintStyle");
    final textStyle = ctsl.getByName("textStyle");
    final labelStyle = ctsl.getByName("labelStyle");
    final errorStyle = ctsl.getByName("labelStyle");
    final secondaryLabelStyle = ctsl.getByName("secondaryLabelStyle");
    //
    colorScheme = colorScheme ??
        ColorScheme(
          tertiaryContainer: tertiaryContainer,
          tertiary: tertiary,
          surfaceVariant: surfaceVariant,
          surfaceTint: surfaceTint,
          shadow: shadow,
          secondaryVariant: secondaryVariant,
          secondaryContainer: secondaryContainer,
          scrim: scrim,
          primaryVariant: primaryVariant,
          primaryContainer: primaryContainer,
          outlineVariant: outlineVariant,
          outline: outline,
          onTertiaryContainer: onTertiaryContainer,
          onTertiary: onTertiary,
          brightness: brightness,
          primary: primaryColor,
          onPrimary: CustomColor.fromString("onPrimary"),
          secondary: CustomColor.fromString("secondary"),
          onSecondary: CustomColor.fromString("onSecondary"),
          error: CustomColor.fromString("error"),
          onError: CustomColor.fromString("onError"),
          background: CustomColor.fromString("background"),
          onBackground: CustomColor.fromString("onBackground"),
          surface: CustomColor.fromString("surface"),
          onSurface: CustomColor.fromString("onSurface"),
          errorContainer: errorContainer,
          inversePrimary: inversePrimary,
          inverseSurface: inverseSurface,
          onErrorContainer: onErrorContainer,
          onInverseSurface: onInverseSurface,
          onPrimaryContainer: onPrimaryContainer,
          onSecondaryContainer: onSecondaryContainer,
          onSurfaceVariant: onSurfaceVariant,
        );
    final bool isDark = colorScheme.brightness == Brightness.dark;

    // For surfaces that use primary color in light themes and surface color in dark
    final Color primarySurfaceColor =
        isDark ? colorScheme.surface : colorScheme.primary;
    final Color onPrimarySurfaceColor =
        isDark ? colorScheme.onSurface : colorScheme.onPrimary;

    final primaryColorBrightness =
        ThemeData.estimateBrightnessForColor(primarySurfaceColor);
    bottomAppBarTheme = bottomAppBarTheme ??
        BottomAppBarTheme(
          color: bottomAppBarColor,
          shadowColor: shadowColor,
          elevation: 4,
          surfaceTintColor: surfaceTintColor,
        );
    final buttonStyle = ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(colorScheme.background),
      overlayColor: MaterialStatePropertyAll(overlayColor),
      shadowColor: MaterialStatePropertyAll(shadowColor),
      surfaceTintColor: MaterialStatePropertyAll(surfaceTintColor),
      textStyle: MaterialStatePropertyAll(textStyle),
      iconColor: MaterialStatePropertyAll(iconTheme.color),
      foregroundColor: MaterialStatePropertyAll(textStyle!.color),
      splashFactory: splashFactory ?? InkSplash.splashFactory,
    );
    final menuStyle = MenuStyle(
      backgroundColor: MaterialStatePropertyAll(colorScheme.background),
      shadowColor: MaterialStatePropertyAll(shadowColor),
      surfaceTintColor: MaterialStatePropertyAll(surfaceTintColor),
    );
    appBarTheme = appBarTheme ??
        AppBarTheme(
          actionsIconTheme: iconTheme,
          iconTheme: iconTheme,
          backgroundColor: colorSchemeSeed,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          titleTextStyle: titleTextStyle,
          toolbarTextStyle: toolbarTextStyle,
          //systemOverlayStyle: SystemUiOverlayStyle()
          //color: colorSchemeSeed,
          // foregroundColor:
        );
    primaryIconTheme = primaryIconTheme ??
        IconThemeData(
          color: colorSchemeSeed,
          opacity: 0.2,
          shadows: cssl.getShadows,
        );
    inputDecorationTheme = inputDecorationTheme ??
        InputDecorationTheme(
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          errorStyle: errorStyle,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(8.0),
          ),
          iconColor: iconTheme.color,
        );
    pageTransitionsTheme = pageTransitionsTheme ?? PageTransitionsTheme();
    scrollbarTheme = scrollbarTheme ?? ScrollbarThemeData();
    dialogTheme = dialogTheme ??
        DialogTheme(
          backgroundColor: dialogBackgroundColor,
          titleTextStyle: titleTextStyle,
          contentTextStyle: contentTextStyle,
          surfaceTintColor: surfaceTintColor,
          actionsPadding: EdgeInsets.all(5),
          iconColor: iconTheme.color,
          shadowColor: shadowColor,
        );
    visualDensity = visualDensity ?? VisualDensity();

    searchViewTheme = searchViewTheme ??
        SearchViewThemeData(
          backgroundColor: colorScheme.background,
          dividerColor: dividerColor,
          surfaceTintColor: surfaceTintColor,
          headerHintStyle: headerHintStyle,
        );
    searchBarTheme = searchBarTheme ??
        SearchBarThemeData(
          backgroundColor: MaterialStatePropertyAll(colorScheme.background),
          overlayColor: MaterialStatePropertyAll(overlayColor),
          shadowColor: MaterialStatePropertyAll(shadowColor),
          surfaceTintColor: MaterialStatePropertyAll(surfaceTintColor),
          hintStyle: MaterialStatePropertyAll(hintStyle),
          textStyle: MaterialStatePropertyAll(textStyle),
        );
    datePickerTheme = datePickerTheme ??
        DatePickerThemeData(
          backgroundColor: backgroundColor,
          //TODO setear el resto de las propiedades.
        );
    actionIconTheme = actionIconTheme ?? ActionIconThemeData();
    bottomNavigationBarTheme = bottomNavigationBarTheme ??
        BottomNavigationBarThemeData(
          backgroundColor: backgroundColor,
          showSelectedLabels: true,
          selectedItemColor: selectedItemColor,
          selectedIconTheme: iconTheme.copyWith(
            color: iconTheme.color!.withOpacity(0.4),
            size: 24,
            weight: 2,
          ),
          unselectedIconTheme: iconTheme,
          unselectedItemColor: iconTheme.color,
          mouseCursor: MaterialStateProperty.all(MouseCursor.defer),
        );
    buttonBarTheme = buttonBarTheme ??
        ButtonBarThemeData(
          buttonTextTheme: ButtonTextTheme.normal,
        );
    buttonTheme = buttonTheme ??
        ButtonThemeData(
          colorScheme: colorScheme,
          textTheme: ButtonTextTheme.normal,
          buttonColor: buttonColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          disabledColor: disabledColor,
          splashColor: splashColor,
          highlightColor: highlightColor,
        );
    cardTheme = cardTheme ??
        CardTheme(
          color: colorScheme.background,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
        );
    drawerTheme = drawerTheme ??
        DrawerThemeData(
          backgroundColor: colorScheme.background,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          scrimColor: scrim,
        );
    elevatedButtonTheme = elevatedButtonTheme ??
        ElevatedButtonThemeData(
          style: buttonStyle,
        );

    dropdownMenuTheme = dropdownMenuTheme ??
        DropdownMenuThemeData(
          textStyle: textStyle,
          menuStyle: menuStyle,
          inputDecorationTheme: inputDecorationTheme,
        );
    iconButtonTheme = iconButtonTheme ??
        IconButtonThemeData(
          style: buttonStyle,
        );
    badgeTheme = badgeTheme ??
        BadgeThemeData(
          backgroundColor: colorScheme.background,
          textStyle: textStyle,
          textColor: textStyle.color,
          largeSize: 24,
          smallSize: 16,
        );
    bannerTheme = bannerTheme ??
        MaterialBannerThemeData(
          backgroundColor: colorScheme.background,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          contentTextStyle: contentTextStyle,
          dividerColor: dividerColor,
        );
    dividerTheme = dividerTheme ??
        DividerThemeData(
          color: dividerColor,
          thickness: 1,
          endIndent: 5,
        );
    bottomSheetTheme = bottomSheetTheme ??
        BottomSheetThemeData(
          backgroundColor: colorScheme.background,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
        );
    chipTheme = chipTheme ??
        ChipThemeData(
          backgroundColor: colorScheme.background,
          brightness: colorScheme.brightness,
          iconTheme: iconTheme,
          labelStyle: labelStyle,
          disabledColor: disabledColor,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          selectedColor: selectedItemColor,
          secondaryLabelStyle: secondaryLabelStyle,
          deleteIconColor: deleteIconColor,
          secondarySelectedColor: colorScheme.onSecondary,
        );
    cupertinoOverrideTheme = cupertinoOverrideTheme ??
        NoDefaultCupertinoThemeData(
          barBackgroundColor: colorScheme.background,
          primaryColor: primaryColor,
          brightness: colorScheme.brightness,
          applyThemeToAll: true,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          textTheme: CupertinoTextThemeData(),
        );
    //
    _themeData = ThemeData.raw(
      applyElevationOverlayColor: applyElevationOverlayColor,
      cupertinoOverrideTheme: cupertinoOverrideTheme,
      extensions: extensions ?? {},
      inputDecorationTheme: inputDecorationTheme,
      materialTapTargetSize:
          materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
      pageTransitionsTheme: pageTransitionsTheme,
      platform: platform ?? getTargetPlatform(),
      scrollbarTheme: scrollbarTheme,
      splashFactory: splashFactory ?? InkSplash.splashFactory,
      useMaterial3: useMaterial3,
      visualDensity: visualDensity,
      canvasColor: canvasColor,
      cardColor: cardColor,
      colorScheme: colorScheme,
      dialogBackgroundColor: dialogTheme.backgroundColor!,
      disabledColor: disabledColor,
      dividerColor: dividerColor,
      focusColor: focusColor,
      highlightColor: highlightColor,
      hintColor: hintColor,
      hoverColor: hoverColor,
      indicatorColor: indicatorColor ?? onPrimarySurfaceColor,
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      secondaryHeaderColor: secondaryHeaderColor,
      shadowColor: shadowColor,
      splashColor: splashColor,
      unselectedWidgetColor: unselectedWidgetColor,
      iconTheme: iconTheme,
      primaryIconTheme: primaryIconTheme,
      primaryTextTheme: primaryTextTheme,
      textTheme: textTheme,
      typography: typography,
      searchViewTheme: searchViewTheme!,
      searchBarTheme: searchBarTheme!,
      datePickerTheme: datePickerTheme!,
      actionIconTheme: actionIconTheme!,
      appBarTheme: appBarTheme,
      badgeTheme: badgeTheme,
      bannerTheme: bannerTheme,
      bottomAppBarTheme: bottomAppBarTheme,
      bottomNavigationBarTheme: bottomNavigationBarTheme,
      bottomSheetTheme: bottomSheetTheme,
      buttonBarTheme: buttonBarTheme,
      buttonTheme: buttonTheme,
      cardTheme: cardTheme,
      //checkboxTheme: checkboxTheme ?? CheckboxThemeData(),
      chipTheme: chipTheme,
      dataTableTheme: dataTableTheme ?? DataTableThemeData(),
      dialogTheme: dialogTheme,
      dividerTheme: dividerTheme,
      drawerTheme: drawerTheme,
      dropdownMenuTheme: dropdownMenuTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      expansionTileTheme: expansionTileTheme ?? ExpansionTileThemeData(),
      filledButtonTheme: filledButtonTheme ?? FilledButtonThemeData(),
      floatingActionButtonTheme:
          floatingActionButtonTheme ?? FloatingActionButtonThemeData(),
      iconButtonTheme: iconButtonTheme,
      listTileTheme: listTileTheme ?? ListTileThemeData(),
      menuBarTheme: menuBarTheme ?? MenuBarThemeData(),
      menuButtonTheme: menuButtonTheme ?? MenuButtonThemeData(),
      menuTheme: menuTheme ?? MenuThemeData(),
      navigationBarTheme: navigationBarTheme ?? NavigationBarThemeData(),
      navigationDrawerTheme:
          navigationDrawerTheme ?? NavigationDrawerThemeData(),
      navigationRailTheme: navigationRailTheme ?? NavigationRailThemeData(),
      outlinedButtonTheme: outlinedButtonTheme ?? OutlinedButtonThemeData(),
      popupMenuTheme: popupMenuTheme ?? PopupMenuThemeData(),
      progressIndicatorTheme:
          progressIndicatorTheme ?? ProgressIndicatorThemeData(),
      //radioTheme: radioTheme ?? RadioThemeData(),
      segmentedButtonTheme: segmentedButtonTheme ?? SegmentedButtonThemeData(),
      sliderTheme: sliderTheme ?? SliderThemeData(),
      snackBarTheme: snackBarTheme ?? SnackBarThemeData(),
      //switchTheme: switchTheme ?? SwitchThemeData(),
      tabBarTheme: tabBarTheme ?? TabBarTheme(),
      textButtonTheme: textButtonTheme ?? TextButtonThemeData(),
      textSelectionTheme: textSelectionTheme ?? TextSelectionThemeData(),
      timePickerTheme: timePickerTheme ?? TimePickerThemeData(),
      toggleButtonsTheme: toggleButtonsTheme ?? ToggleButtonsThemeData(),
      tooltipTheme: tooltipTheme ?? TooltipThemeData(),
      switchTheme: switchTheme ??
          SwitchThemeData().copyWith(
            thumbColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return null;
              }
              if (states.contains(MaterialState.selected)) {
                return Colors.red;
              }
              return null;
            }),
            trackColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return null;
              }
              if (states.contains(MaterialState.selected)) {
                return Colors.red;
              }
              return null;
            }),
          ),
      radioTheme: radioTheme ??
          RadioThemeData().copyWith(
            fillColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return null;
              }
              if (states.contains(MaterialState.selected)) {
                return Colors.red;
              }
              return null;
            }),
          ),
      checkboxTheme: checkboxTheme ??
          CheckboxThemeData().copyWith(
            fillColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return null;
              }
              if (states.contains(MaterialState.selected)) {
                return Colors.red;
              }
              return null;
            }),
          ),
      errorColor: colorScheme.error,
      bottomAppBarColor:
          bottomAppBarColor ?? CustomColor.fromString("bottomAppBarColor"),

      backgroundColor: bottomAppBarColor ?? backgroundColor,
      toggleableActiveColor: toggleableActiveColor,
      selectedRowColor: selectedRowColor,
      primaryColorBrightness: primaryColorBrightness,
      fixTextFieldOutlineLabel: false,
    );

    //Por ahora
    _themeData = ThemeData.light();
  }

  factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
        name: EntityModel.getValueFromJson(
          "name",
          json,
          "Default",
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key].toString().isNotEmpty) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        colors: EntityModel.getValueFromJson(
          "active",
          json,
          CustomColorSingleList.instance.getColors,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return List<Color>.from(
                  CustomColorList.fromJson(json).colors.map((e) {
                CustomColorSingleList.instance.add(e);
                return e;
              })).toList(growable: true);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        decorations: DecorationList.fromJson(json).decorations,
        active: EntityModel.getValueFromJson(
          "active",
          json,
          false,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        applyElevationOverlayColor: EntityModel.getValueFromJson(
          "applyElevationOverlayColor",
          json,
          false,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        useMaterial3: EntityModel.getValueFromJson(
          "useMaterial3",
          json,
          true,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        brightness: EntityModel.getValueFromJson(
          "brightness",
          json,
          BrightnessExtensionMethods.getBrightness("light"),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return BrightnessExtensionMethods.getBrightness(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        canvasColor: EntityModel.getValueFromJson(
          "canvasColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        cardColor: EntityModel.getValueFromJson(
          "cardColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        colorScheme: EntityModel.getValueFromJson(
          "colorScheme",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return ColorSchemeExtension.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        colorSchemeSeed: EntityModel.getValueFromJson(
          "colorSchemeSeed",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        dialogBackgroundColor: EntityModel.getValueFromJson(
          "dialogBackgroundColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        disabledColor: EntityModel.getValueFromJson(
          "disabledColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        dividerColor: EntityModel.getValueFromJson(
          "dividerColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        focusColor: EntityModel.getValueFromJson(
          "focusColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        highlightColor: EntityModel.getValueFromJson(
          "highlightColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        hintColor: EntityModel.getValueFromJson(
          "hintColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        hoverColor: EntityModel.getValueFromJson(
          "hoverColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        indicatorColor: EntityModel.getValueFromJson(
          "indicatorColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        primaryColor: EntityModel.getValueFromJson(
          "primaryColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        primaryColorDark: EntityModel.getValueFromJson(
          "primaryColorDark",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        primaryColorLight: EntityModel.getValueFromJson(
          "primaryColorLight",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        primarySwatch: EntityModel.getValueFromJson(
          "primarySwatch",
          json,
          MaterialCustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) &&
                data[key] is String &&
                !isJson(data[key].toString())) {
              return MaterialCustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return MaterialCustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        scaffoldBackgroundColor: EntityModel.getValueFromJson(
          "scaffoldBackgroundColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        secondaryHeaderColor: EntityModel.getValueFromJson(
          "secondaryHeaderColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        shadowColor: EntityModel.getValueFromJson(
          "shadowColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        splashColor: EntityModel.getValueFromJson(
          "splashColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        unselectedWidgetColor: EntityModel.getValueFromJson(
          "unselectedWidgetColor",
          json,
          CustomColor.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            } else if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        fontFamily: EntityModel.getValueFromJson(
          "fontFamily",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        fontFamilyFallback: EntityModel.getValueFromJson(
          "fontFamilyFallback",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return List<String>.from(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        package: EntityModel.getValueFromJson(
          "package",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        iconTheme: EntityModel.getValueFromJson<IconThemeData>(
          "iconTheme",
          json,
          CustomIconThemeDataModel.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return CustomIconThemeDataModel.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        primaryIconTheme: EntityModel.getValueFromJson<IconThemeData>(
          "primaryIconTheme",
          json,
          CustomIconThemeDataModel.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return CustomIconThemeDataModel.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        textTheme: EntityModel.getValueFromJson<TextTheme>(
          "textTheme",
          json,
          CustomTextThemeModel.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is Map) {
              return CustomTextThemeModel.fromJson(data[key]);
            } else if (data.containsKey(key) && data[key] is String) {
              final textTheme = CustomTextThemeModel.fromString(data[key]);
              final style = textTheme.bodyMedium;
              log(style.toString());
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        primaryTextTheme: EntityModel.getValueFromJson<TextTheme>(
          "primaryTextTheme",
          json,
          CustomTextThemeModel.fromDefault(),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) &&
                data[key] is String &&
                !isJson(data[key].toString())) {
              return CustomTextThemeModel.fromString(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        typography: EntityModel.getValueFromJson<Typography>(
          "typography",
          json,
          CustomTypographyModel.createTypography(
            platform: getTargetPlatform(),
            black: CustomTextThemeModel.fromString("black"),
            dense: CustomTextThemeModel.fromString("dense"),
            englishLike: CustomTextThemeModel.fromString("englishLike"),
            tall: CustomTextThemeModel.fromString("tall"),
            white: CustomTextThemeModel.fromString("white"),
          ),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return CustomTypographyModel.createTypographyFromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
      );

  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  ThemeData get getThemeData =>
      _themeData == null ? _themeData = ThemeData.light() : _themeData!;

  List<Object?> get props => [];

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  bool? get stringify => true;

  //method generated by wizard

  T cloneWith<T extends EntityModel>(T other) {
    return ThemeModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return ThemeList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return ThemeList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return ThemeList.fromJson({});
  }

  ThemeData createTheme() => theme.CustomTheme.fromJson(
        nameTheme: name,
        colorsList: colors,
        isActive: active,
        decorationsList: decorations,
        applyElevationOverlayColor: applyElevationOverlayColor,
        useMaterial3: useMaterial3,
        brightness: brightness,
        canvasColor: canvasColor,
        cardColor: cardColor,
        colorScheme: colorScheme,
        colorSchemeSeed: colorSchemeSeed,
        dialogBackgroundColor: dialogBackgroundColor,
        disabledColor: disabledColor,
        dividerColor: dividerColor,
        focusColor: focusColor,
        highlightColor: highlightColor,
        hintColor: hintColor,
        hoverColor: hoverColor,
        indicatorColor: indicatorColor,
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        primarySwatch: primarySwatch,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        secondaryHeaderColor: secondaryHeaderColor,
        shadowColor: shadowColor,
        splashColor: splashColor,
        unselectedWidgetColor: unselectedWidgetColor,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        iconTheme: iconTheme,
        primaryIconTheme: primaryIconTheme,
        primaryTextTheme: primaryTextTheme,
        textTheme: textTheme,
        typography: typography,
      );

  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return ThemeModel.fromJson(params) as T;
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    // TODO: implement getColumnMetaModel
    throw UnimplementedError();
  }

  @override
  Map<String, String> getColumnNames() {
    return {"id_config": "ID"};
  }

  @override
  List<String> getColumnNamesList() {
    return getColumnNames().values.toList();
  }

  StreamController<EntityModel> getController({
    void Function()? onListen,
    void Function()? onPause,
    void Function()? onResume,
    FutureOr<void> Function()? onCancel,
  }) {
    return EntityModel.getController(
      entity: this,
      onListen: onListen,
      onPause: onPause,
      onResume: onResume,
      onCancel: onCancel,
    );
  }

  @override
  Map<K1, V1> getMeta<K1, V1>(String searchKey, dynamic searchValue) {
    final Map<K1, V1> result = {};
    getColumnMetaModel().map<K1, V1>((key, value) {
      MapEntry<K1, V1> el = MapEntry(value.getDataIndex() as K1, value as V1);
      if (value[searchKey] == searchValue) {
        result.putIfAbsent(value.getDataIndex() as K1, () {
          return value as V1;
        });
      }
      return el;
    });
    return result;
  }

  Color getPrimaryColor() {
    return colors.isNotEmpty ? colors.first : Colors.transparent;
  }

  @override
  Map<String, String> getVisibleColumnNames() {
    // TODO: implement getVisibleColumnNames
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "colors": List<Map<String, dynamic>>.from(
            colors.map((e) => (e as CustomColor).toJson())),
        "active": active,
        "decorations":
            List<Map<String, dynamic>>.from(decorations.map((e) => e.toJson())),
      };

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, dynamic valueSearch, dynamic newValue) {
    Map<String, ColumnMetaModel> tmp = getColumnMetaModel();
    getMeta<String, ColumnMetaModel>(keySearch, valueSearch)
        .map<String, ColumnMetaModel>((key, value) {
      tmp.putIfAbsent(key, () => value);
      return MapEntry(key, value);
    });
    return metaModel = tmp;
  }

  ThemeData wrap() =>
      _themeData ??
      ThemeData(
        brightness: brightness,
        canvasColor: canvasColor,
        cardColor: cardColor,
        colorScheme: colorScheme,
        colorSchemeSeed: colorSchemeSeed,
        dialogBackgroundColor: dialogBackgroundColor,
        disabledColor: disabledColor,
        dividerColor: dividerColor,
        focusColor: focusColor,
        highlightColor: highlightColor,
        hintColor: hintColor,
        hoverColor: hoverColor,
        indicatorColor: indicatorColor,
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        primarySwatch: primarySwatch,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        secondaryHeaderColor: secondaryHeaderColor,
        shadowColor: shadowColor,
        splashColor: splashColor,
        unselectedWidgetColor: unselectedWidgetColor,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        iconTheme: iconTheme,
        primaryIconTheme: primaryIconTheme,
        primaryTextTheme: primaryTextTheme,
        textTheme: textTheme,
        typography: typography,
        useMaterial3: useMaterial3,
        //Los adicionales aquí
      );

  static T? getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, T? defaultValue,
      {JsonReader<T?>? reader}) {
    return EntityModel.getValueFromJson<T?>(key, json, defaultValue,
        reader: reader);
  }
}
