// ignore_for_file: public_member_api_docs, sort_constructors_first, overridden_fields, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import '/app/core/design/color.dart';

import 'decoration.dart' as dec;

class CustomTheme extends ThemeData {
  late String name;
  late bool active;
  late List<Color> colors;
  late List<dec.Decoration> decorations;

  // For the sanity of the reader, make sure these properties are in the same
  // order in every place that they are separated by section comments (e.g.
  // GENERAL CONFIGURATION). Each section except for deprecations should be
  // alphabetical by symbol name.

  // GENERAL CONFIGURATION
  @override
  late bool applyElevationOverlayColor;
  @override
  NoDefaultCupertinoThemeData? cupertinoOverrideTheme;
  @override
  late Map<Object, ThemeExtension<dynamic>> extensions;
  @override
  late InputDecorationTheme inputDecorationTheme;
  @override
  late MaterialTapTargetSize materialTapTargetSize;
  @override
  late PageTransitionsTheme pageTransitionsTheme;
  @override
  late TargetPlatform platform;
  @override
  late ScrollbarThemeData scrollbarTheme;
  @override
  late InteractiveInkFeatureFactory splashFactory;
  @override
  late bool useMaterial3;
  @override
  late VisualDensity visualDensity;
  // COLOR
  // [colorScheme] is the preferred way to configure colors. The other color
  // properties (as well as primaryColorBrightness, and primarySwatch)
  // will gradually be phased out, see https://github.com/flutter/flutter/issues/91772.
  @override
  late Brightness brightness;
  @override
  late Color canvasColor;
  @override
  late Color cardColor;
  @override
  late ColorScheme colorScheme;
  late Color colorSchemeSeed;
  @override
  late Color dialogBackgroundColor;
  @override
  late Color disabledColor;
  @override
  late Color dividerColor;
  @override
  late Color focusColor;
  @override
  late Color highlightColor;
  @override
  late Color hintColor;
  @override
  late Color hoverColor;
  @override
  late Color indicatorColor;
  @override
  late Color primaryColor;
  @override
  late Color primaryColorDark;
  @override
  late Color primaryColorLight;
  late MaterialColor primarySwatch;
  @override
  late Color scaffoldBackgroundColor;
  @override
  late Color secondaryHeaderColor;
  @override
  late Color shadowColor;
  @override
  late Color splashColor;
  @override
  late Color unselectedWidgetColor;
  // TYPOGRAPHY & ICONOGRAPHY
  String? fontFamily;
  List<String>? fontFamilyFallback;
  String? package;
  @override
  late IconThemeData iconTheme;
  @override
  late IconThemeData primaryIconTheme;
  @override
  late TextTheme primaryTextTheme;
  @override
  late TextTheme textTheme;
  @override
  late Typography typography;
  // COMPONENT THEMES
  @override
  late AppBarTheme appBarTheme;
  @override
  late BadgeThemeData badgeTheme;
  @override
  late MaterialBannerThemeData bannerTheme;
  @override
  late BottomAppBarTheme bottomAppBarTheme;
  @override
  late BottomNavigationBarThemeData bottomNavigationBarTheme;
  @override
  late BottomSheetThemeData bottomSheetTheme;
  @override
  late ButtonBarThemeData buttonBarTheme;
  @override
  late ButtonThemeData buttonTheme;
  @override
  late CardTheme cardTheme;
  @override
  late CheckboxThemeData checkboxTheme;
  @override
  late ChipThemeData chipTheme;
  @override
  late DataTableThemeData dataTableTheme;
  @override
  late DialogTheme dialogTheme;
  @override
  late DividerThemeData dividerTheme;
  @override
  late DrawerThemeData drawerTheme;
  @override
  late DropdownMenuThemeData dropdownMenuTheme;
  @override
  late ElevatedButtonThemeData elevatedButtonTheme;
  @override
  late ExpansionTileThemeData expansionTileTheme;
  @override
  late FilledButtonThemeData filledButtonTheme;
  @override
  late FloatingActionButtonThemeData floatingActionButtonTheme;
  @override
  late IconButtonThemeData iconButtonTheme;
  @override
  late ListTileThemeData listTileTheme;
  @override
  late MenuBarThemeData menuBarTheme;
  @override
  late MenuButtonThemeData menuButtonTheme;
  @override
  late MenuThemeData menuTheme;
  @override
  late NavigationBarThemeData navigationBarTheme;
  @override
  late NavigationDrawerThemeData navigationDrawerTheme;
  @override
  late NavigationRailThemeData navigationRailTheme;
  @override
  late OutlinedButtonThemeData outlinedButtonTheme;
  @override
  late PopupMenuThemeData popupMenuTheme;
  @override
  late ProgressIndicatorThemeData progressIndicatorTheme;
  @override
  late RadioThemeData radioTheme;
  @override
  late SegmentedButtonThemeData segmentedButtonTheme;
  @override
  late SliderThemeData sliderTheme;
  @override
  late SnackBarThemeData snackBarTheme;
  @override
  late SwitchThemeData switchTheme;
  @override
  late TabBarTheme tabBarTheme;
  @override
  late TextButtonThemeData textButtonTheme;
  @override
  late TextSelectionThemeData textSelectionTheme;
  @override
  late TimePickerThemeData timePickerTheme;
  @override
  late ToggleButtonsThemeData toggleButtonsTheme;
  @override
  late TooltipThemeData tooltipTheme;
  // DEPRECATED (newest deprecations at the bottom)

  @Deprecated(
    'Use colorScheme.secondary instead. '
    'For more information, consult the migration guide at '
    'https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide. '
    'This feature was deprecated after v2.3.0-0.1.pre.',
  )
  late Color accentColor;

  @Deprecated(
    'No longer used by the framework, please remove any reference to it. '
    'For more information, consult the migration guide at '
    'https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide. '
    'This feature was deprecated after v2.3.0-0.1.pre.',
  )
  late Brightness accentColorBrightness;

  @Deprecated(
    'No longer used by the framework, please remove any reference to it. '
    'For more information, consult the migration guide at '
    'https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide. '
    'This feature was deprecated after v2.3.0-0.1.pre.',
  )
  late TextTheme accentTextTheme;

  @Deprecated(
    'No longer used by the framework, please remove any reference to it. '
    'For more information, consult the migration guide at '
    'https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide. '
    'This feature was deprecated after v2.3.0-0.1.pre.',
  )
  late IconThemeData accentIconTheme;

  @Deprecated(
    'No longer used by the framework, please remove any reference to it. '
    'This feature was deprecated after v2.3.0-0.2.pre.',
  )
  late Color buttonColor;
  @override
  @Deprecated(
    'This "fix" is now enabled by default. '
    'This feature was deprecated after v2.5.0-1.0.pre.',
  )
  late bool fixTextFieldOutlineLabel;
  @override
  @Deprecated(
    'No longer used by the framework, please remove any reference to it. '
    'This feature was deprecated after v2.6.0-11.0.pre.',
  )
  late Brightness primaryColorBrightness;
  @override
  @Deprecated(
      'Use ThemeData.useMaterial3 or override ScrollBehavior.buildOverscrollIndicator. '
      'This feature was deprecated after v2.13.0-0.0.pre.')
  late AndroidOverscrollIndicator androidOverscrollIndicator;
  @override
  @Deprecated(
    'No longer used by the framework, please remove any reference to it. '
    'For more information, consult the migration guide at '
    'https://flutter.dev/docs/release/breaking-changes/toggleable-active-color#migration-guide. '
    'This feature was deprecated after v3.4.0-19.0.pre.',
  )
  late Color toggleableActiveColor;
  @override
  @Deprecated(
    'No longer used by the framework, please remove any reference to it. '
    'This feature was deprecated after v3.1.0-0.0.pre.',
  )
  late Color selectedRowColor;
  @override
  @Deprecated(
    'Use colorScheme.error instead. '
    'This feature was deprecated after v3.3.0-0.5.pre.',
  )
  late Color errorColor;
  @override
  @Deprecated(
    'Use colorScheme.background instead. '
    'This feature was deprecated after v3.3.0-0.5.pre.',
  )
  late Color backgroundColor;
  @override
  @Deprecated(
    'Use BottomAppBarTheme.color instead. '
    'This feature was deprecated after v3.3.0-0.6.pre.',
  )
  late Color bottomAppBarColor;

  //
  factory CustomTheme.fromJson({
    List<dec.Decoration> decorationsList = const [],
    String nameTheme = "Default",
    List<Color> colorsList = const [],
    bool isActive = false,
    // For the sanity of the reader, make sure these properties are in the same
    // order in every place that they are separated by section comments (e.g.
    // GENERAL CONFIGURATION). Each section except for deprecations should be
    // alphabetical by symbol name.

    // GENERAL CONFIGURATION
    bool? applyElevationOverlayColor,
    NoDefaultCupertinoThemeData? cupertinoOverrideTheme,
    Iterable<ThemeExtension<dynamic>>? extensions,
    InputDecorationTheme? inputDecorationTheme,
    MaterialTapTargetSize? materialTapTargetSize,
    PageTransitionsTheme? pageTransitionsTheme,
    TargetPlatform? platform,
    ScrollbarThemeData? scrollbarTheme,
    InteractiveInkFeatureFactory? splashFactory,
    bool? useMaterial3,
    VisualDensity? visualDensity,
    // COLOR
    // [colorScheme] is the preferred way to configure colors. The other color
    // properties (as well as primaryColorBrightness, and primarySwatch)
    // will gradually be phased out, see https://github.com/flutter/flutter/issues/91772.
    Brightness? brightness,
    Color? canvasColor,
    Color? cardColor,
    ColorScheme? colorScheme,
    Color? colorSchemeSeed,
    Color? dialogBackgroundColor,
    Color? disabledColor,
    Color? dividerColor,
    Color? focusColor,
    Color? highlightColor,
    Color? hintColor,
    Color? hoverColor,
    Color? indicatorColor,
    Color? primaryColor,
    Color? primaryColorDark,
    Color? primaryColorLight,
    MaterialColor? primarySwatch,
    Color? scaffoldBackgroundColor,
    Color? secondaryHeaderColor,
    Color? shadowColor,
    Color? splashColor,
    Color? unselectedWidgetColor,
    // TYPOGRAPHY & ICONOGRAPHY
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    IconThemeData? iconTheme,
    IconThemeData? primaryIconTheme,
    TextTheme? primaryTextTheme,
    TextTheme? textTheme,
    Typography? typography,
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
    // DEPRECATED (newest deprecations at the bottom)
    @Deprecated(
      'Use colorScheme.secondary instead. '
      'For more information, consult the migration guide at '
      'https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide. '
      'This feature was deprecated after v2.3.0-0.1.pre.',
    )
        Color? accentColor,
    @Deprecated(
      'No longer used by the framework, please remove any reference to it. '
      'For more information, consult the migration guide at '
      'https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide. '
      'This feature was deprecated after v2.3.0-0.1.pre.',
    )
        Brightness? accentColorBrightness,
    @Deprecated(
      'No longer used by the framework, please remove any reference to it. '
      'For more information, consult the migration guide at '
      'https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide. '
      'This feature was deprecated after v2.3.0-0.1.pre.',
    )
        TextTheme? accentTextTheme,
    @Deprecated(
      'No longer used by the framework, please remove any reference to it. '
      'For more information, consult the migration guide at '
      'https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide. '
      'This feature was deprecated after v2.3.0-0.1.pre.',
    )
        IconThemeData? accentIconTheme,
    @Deprecated(
      'No longer used by the framework, please remove any reference to it. '
      'This feature was deprecated after v2.3.0-0.2.pre.',
    )
        Color? buttonColor,
    @Deprecated(
      'This "fix" is now enabled by default. '
      'This feature was deprecated after v2.5.0-1.0.pre.',
    )
        bool? fixTextFieldOutlineLabel,
    @Deprecated(
      'No longer used by the framework, please remove any reference to it. '
      'This feature was deprecated after v2.6.0-11.0.pre.',
    )
        Brightness? primaryColorBrightness,
    @Deprecated(
        'Use ThemeData.useMaterial3 or override ScrollBehavior.buildOverscrollIndicator. '
        'This feature was deprecated after v2.13.0-0.0.pre.')
        AndroidOverscrollIndicator? androidOverscrollIndicator,
    @Deprecated(
      'No longer used by the framework, please remove any reference to it. '
      'For more information, consult the migration guide at '
      'https://flutter.dev/docs/release/breaking-changes/toggleable-active-color#migration-guide. '
      'This feature was deprecated after v3.4.0-19.0.pre.',
    )
        Color? toggleableActiveColor,
    @Deprecated(
      'No longer used by the framework, please remove any reference to it. '
      'This feature was deprecated after v3.1.0-0.0.pre.',
    )
        Color? selectedRowColor,
    @Deprecated(
      'Use colorScheme.error instead. '
      'This feature was deprecated after v3.3.0-0.5.pre.',
    )
        Color? errorColor,
    @Deprecated(
      'Use colorScheme.background instead. '
      'This feature was deprecated after v3.3.0-0.5.pre.',
    )
        Color? backgroundColor,
    @Deprecated(
      'Use BottomAppBarTheme.color instead. '
      'This feature was deprecated after v3.3.0-0.6.pre.',
    )
        Color? bottomAppBarColor,
  }) {
    final CustomTheme theme = ThemeData(
      applyElevationOverlayColor: applyElevationOverlayColor,
      cupertinoOverrideTheme: cupertinoOverrideTheme,
      extensions: extensions,
      inputDecorationTheme: inputDecorationTheme,
      materialTapTargetSize: materialTapTargetSize,
      pageTransitionsTheme: pageTransitionsTheme,
      platform: platform,
      scrollbarTheme: scrollbarTheme,
      splashFactory: splashFactory,
      useMaterial3: useMaterial3,
      visualDensity: visualDensity,
      canvasColor: canvasColor,
      cardColor: cardColor,
      colorScheme: colorScheme,
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
      appBarTheme: appBarTheme,
      badgeTheme: badgeTheme,
      bannerTheme: bannerTheme,
      bottomAppBarTheme: bottomAppBarTheme,
      bottomNavigationBarTheme: bottomNavigationBarTheme,
      bottomSheetTheme: bottomSheetTheme,
      buttonBarTheme: buttonBarTheme,
      buttonTheme: buttonTheme,
      cardTheme: cardTheme,
      checkboxTheme: checkboxTheme,
      chipTheme: chipTheme,
      dataTableTheme: dataTableTheme,
      dialogTheme: dialogTheme,
      dividerTheme: dividerTheme,
      drawerTheme: drawerTheme,
      dropdownMenuTheme: dropdownMenuTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      expansionTileTheme: expansionTileTheme,
      filledButtonTheme: filledButtonTheme,
      floatingActionButtonTheme: floatingActionButtonTheme,
      iconButtonTheme: iconButtonTheme,
      listTileTheme: listTileTheme,
      menuBarTheme: menuBarTheme,
      menuButtonTheme: menuButtonTheme,
      menuTheme: menuTheme,
      navigationBarTheme: navigationBarTheme,
      navigationDrawerTheme: navigationDrawerTheme,
      navigationRailTheme: navigationRailTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      popupMenuTheme: popupMenuTheme,
      progressIndicatorTheme: progressIndicatorTheme,
      radioTheme: radioTheme,
      segmentedButtonTheme: segmentedButtonTheme,
      sliderTheme: sliderTheme,
      snackBarTheme: snackBarTheme,
      switchTheme: switchTheme,
      tabBarTheme: tabBarTheme,
      textButtonTheme: textButtonTheme,
      textSelectionTheme: textSelectionTheme,
      timePickerTheme: timePickerTheme,
      toggleButtonsTheme: toggleButtonsTheme,
      tooltipTheme: tooltipTheme,
    ) as CustomTheme;
    theme.active = isActive;
    theme.colors = colorsList;
    theme.decorations = decorationsList;
    theme.name = nameTheme;
    theme.applyElevationOverlayColor = applyElevationOverlayColor!;
    theme.cupertinoOverrideTheme = cupertinoOverrideTheme;
    theme.extensions = extensions as Map<Object, ThemeExtension>;
    theme.inputDecorationTheme = inputDecorationTheme!;
    theme.materialTapTargetSize = materialTapTargetSize!;
    theme.pageTransitionsTheme = pageTransitionsTheme!;
    theme.platform = platform!;
    theme.scrollbarTheme = scrollbarTheme!;
    theme.splashFactory = splashFactory!;
    theme.useMaterial3 = useMaterial3!;
    theme.visualDensity = visualDensity!;
    theme.canvasColor = canvasColor!;
    theme.cardColor = cardColor!;
    theme.colorScheme = colorScheme!;
    theme.dialogBackgroundColor = dialogBackgroundColor!;
    theme.disabledColor = disabledColor!;
    theme.dividerColor = dividerColor!;
    theme.focusColor = focusColor!;
    theme.highlightColor = highlightColor!;
    theme.hintColor = hintColor!;
    theme.hoverColor = hoverColor!;
    theme.indicatorColor = indicatorColor!;
    theme.primaryColor = primaryColor!;
    theme.primaryColorDark = primaryColorDark!;
    theme.primaryColorLight = primaryColorLight!;
    theme.scaffoldBackgroundColor = scaffoldBackgroundColor!;
    theme.secondaryHeaderColor = secondaryHeaderColor!;
    theme.shadowColor = shadowColor!;
    theme.splashColor = splashColor!;
    theme.unselectedWidgetColor = unselectedWidgetColor!;
    theme.iconTheme = iconTheme!;
    theme.primaryIconTheme = primaryIconTheme!;
    theme.primaryTextTheme = primaryTextTheme!;
    theme.textTheme = textTheme!;
    theme.typography = typography!;
    theme.appBarTheme = appBarTheme!;
    theme.badgeTheme = badgeTheme!;
    theme.bannerTheme = bannerTheme!;
    theme.bottomAppBarTheme = bottomAppBarTheme!;
    theme.bottomNavigationBarTheme = bottomNavigationBarTheme!;
    theme.bottomSheetTheme = bottomSheetTheme!;
    theme.buttonBarTheme = buttonBarTheme!;
    theme.buttonTheme = buttonTheme!;
    theme.cardTheme = cardTheme!;
    theme.checkboxTheme = checkboxTheme!;
    theme.chipTheme = chipTheme!;
    theme.dataTableTheme = dataTableTheme!;
    theme.dialogTheme = dialogTheme!;
    theme.dividerTheme = dividerTheme!;
    theme.drawerTheme = drawerTheme!;
    theme.dropdownMenuTheme = dropdownMenuTheme!;
    theme.elevatedButtonTheme = elevatedButtonTheme!;
    theme.expansionTileTheme = expansionTileTheme!;
    theme.filledButtonTheme = filledButtonTheme!;
    theme.floatingActionButtonTheme = floatingActionButtonTheme!;
    theme.iconButtonTheme = iconButtonTheme!;
    theme.listTileTheme = listTileTheme!;
    theme.menuBarTheme = menuBarTheme!;
    theme.menuButtonTheme = menuButtonTheme!;
    theme.menuTheme = menuTheme!;
    theme.navigationBarTheme = navigationBarTheme!;
    theme.navigationDrawerTheme = navigationDrawerTheme!;
    theme.navigationRailTheme = navigationRailTheme!;
    theme.outlinedButtonTheme = outlinedButtonTheme!;
    theme.popupMenuTheme = popupMenuTheme!;
    theme.progressIndicatorTheme = progressIndicatorTheme!;
    theme.radioTheme = radioTheme!;
    theme.segmentedButtonTheme = segmentedButtonTheme!;
    theme.sliderTheme = sliderTheme!;
    theme.snackBarTheme = snackBarTheme!;
    theme.switchTheme = switchTheme!;
    theme.tabBarTheme = tabBarTheme!;
    theme.textButtonTheme = textButtonTheme!;
    theme.textSelectionTheme = textSelectionTheme!;
    theme.timePickerTheme = timePickerTheme!;
    theme.toggleButtonsTheme = toggleButtonsTheme!;
    theme.tooltipTheme = tooltipTheme!;
    return theme;
  }
}
