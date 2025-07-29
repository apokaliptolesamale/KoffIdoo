// ignore_for_file: override_on_non_overriding_member, overridden_fields, prefer_function_declarations_over_variables, library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/interfaces/app_page.dart';
import '/app/modules/qrcode/bindings/qrcode_binding.dart';
import '/app/modules/qrcode/controllers/qrcode_controller.dart';
import '/app/widgets/field/custom_get_view.dart';
import '/app/widgets/tools/scan_qr_code.dart';
import '../../../../routes/app_routes.dart';

class QrScanPage extends CustomView<QrCodeController> {
  static onScanCallBack? onScan;
  late String callBack;
  QrScanPage() {
    if (!Get.isRegistered<QrScanPage>()) {
      Get.lazyPut(() => this);
    }
    callBack = Get.parameters.containsKey("urlCallBack")
        ? Get.parameters["urlCallBack"] ?? ""
        : "/";
  }

  @override
  Widget build(BuildContext context) => QRCodeView(
      onScan: QrScanPage.onScan ?? onEmptyScanCallBack, callBack: callBack);
}

class QrScanPageImpl<T> extends CustomAppPageImpl<T> {
  @override
  final GetPageBuilder page;
  @override
  final bool? popGesture;
  @override
  final Map<String, String>? parameters;
  @override
  final String? title;
  @override
  final Transition? transition;
  @override
  final Curve curve;
  @override
  final bool? participatesInRootNavigator;
  @override
  final Alignment? alignment;
  @override
  final bool maintainState;
  @override
  final bool opaque;
  @override
  final double Function(BuildContext context)? gestureWidth;
  @override
  final Bindings? binding;
  @override
  final List<Bindings> bindings;
  @override
  final CustomTransition? customTransition;
  @override
  final Duration? transitionDuration;
  @override
  final bool fullscreenDialog;
  @override
  final bool preventDuplicates;

  @override
  final Object? arguments;

  @override
  final String name;

  @override
  final List<GetPage> children;
  @override
  final List<GetMiddleware>? middlewares;
  @override
  final PathDecoded customPath;
  @override
  final GetPage? unknownRoute;
  @override
  final bool showCupertinoParallax;
  @override
  String keyMap;

  @override
  int index;

  QrScanPageImpl({
    required this.name,
    required this.keyMap,
    required this.page,
    this.index = -1,
    this.title,
    this.participatesInRootNavigator,
    this.gestureWidth,
    this.maintainState = true,
    this.curve = Curves.linear,
    this.alignment,
    this.parameters,
    this.opaque = true,
    this.transitionDuration,
    this.popGesture,
    this.binding,
    this.bindings = const [],
    this.transition,
    this.customTransition,
    this.fullscreenDialog = false,
    this.children = const <GetPage>[],
    this.middlewares,
    this.unknownRoute,
    this.arguments,
    this.showCupertinoParallax = true,
    this.preventDuplicates = true,
  })  : customPath = CustomAppPageImpl.nameToRegex(name),
        assert(name.startsWith('/'),
            'It is necessary to start route name [$name] with a slash: /$name'),
        super(
          name: name,
          keyMap: keyMap,
          page: page,
          index: index,
          title: title,
          participatesInRootNavigator: participatesInRootNavigator,
          gestureWidth: gestureWidth,
          maintainState: maintainState,
          curve: curve,
          alignment: alignment,
          parameters: parameters,
          opaque: opaque,
          transitionDuration: transitionDuration,
          popGesture: popGesture,
          binding: binding,
          transition: transition,
          customTransition: customTransition,
          fullscreenDialog: fullscreenDialog,
          children: children,
          middlewares: middlewares,
          unknownRoute: unknownRoute,
          arguments: Get.arguments,
          showCupertinoParallax: showCupertinoParallax,
          preventDuplicates: preventDuplicates,
        );

  @override
  GetPage<T> copy({
    String? name,
    GetPageBuilder? page,
    bool? popGesture,
    Map<String, String>? parameters,
    String? title,
    Transition? transition,
    Curve? curve,
    Alignment? alignment,
    bool? maintainState,
    bool? opaque,
    Bindings? binding,
    List<Bindings>? bindings,
    CustomTransition? customTransition,
    Duration? transitionDuration,
    bool? fullscreenDialog,
    RouteSettings? settings,
    List<GetPage>? children,
    GetPage? unknownRoute,
    List<GetMiddleware>? middlewares,
    bool? preventDuplicates,
    final double Function(BuildContext context)? gestureWidth,
    bool? participatesInRootNavigator,
    Object? arguments,
    bool? showCupertinoParallax,
    int index = -1,
  }) {
    return super.copy(
      name: name,
      page: page,
      popGesture: popGesture,
      parameters: parameters,
      title: title,
      transition: transition,
      curve: curve,
      alignment: alignment,
      maintainState: maintainState,
      opaque: opaque,
      binding: binding,
      bindings: bindings,
      customTransition: customTransition,
      transitionDuration: transitionDuration,
      fullscreenDialog: fullscreenDialog,
      settings: settings,
      children: children,
      unknownRoute: unknownRoute,
      middlewares: middlewares,
      preventDuplicates: preventDuplicates,
      gestureWidth: gestureWidth,
      participatesInRootNavigator: participatesInRootNavigator,
      arguments: arguments,
      showCupertinoParallax: showCupertinoParallax,
    );
  }

  @override
  Route<T> createRoute(BuildContext context) {
    final page = PageRedirect(
      route: this,
      settings: this,
      unknownRoute: unknownRoute,
    ).getPageToRoute<T>(this, unknownRoute);
    return page;
  }

  static QrScanPageImpl builder({
    String name = "/qr/scan",
    String keyMap = "QR_SCAN",
    int index = -1,
    bool? popGesture,
    Map<String, String>? parameters,
    String? title,
    Transition? transition,
    Curve curve = Curves.linear,
    Alignment? alignment,
    bool maintainState = true,
    bool opaque = true,
    Bindings? binding,
    List<Bindings>? bindings,
    CustomTransition? customTransition,
    Duration? transitionDuration,
    bool fullscreenDialog = false,
    RouteSettings? settings,
    List<GetPage> children = const <GetPage>[],
    GetPage? unknownRoute,
    List<GetMiddleware>? middlewares,
    bool preventDuplicates = true,
    final double Function(BuildContext context)? gestureWidth,
    bool? participatesInRootNavigator,
    Object? arguments,
    bool showCupertinoParallax = true,
  }) =>
      QrScanPageImpl(
        name: name,
        keyMap: keyMap,
        page: getPageBuilder(name, keyMap),
        index: index,
        title: title,
        participatesInRootNavigator: participatesInRootNavigator,
        gestureWidth: gestureWidth,
        maintainState: maintainState,
        curve: curve,
        alignment: alignment,
        parameters: parameters,
        opaque: opaque,
        transitionDuration: transitionDuration,
        popGesture: popGesture,
        binding: binding ?? QrCodeBinding(),
        transition: transition,
        customTransition: customTransition,
        fullscreenDialog: fullscreenDialog,
        children: children,
        middlewares: middlewares,
        unknownRoute: unknownRoute,
        arguments: Get.arguments,
        showCupertinoParallax: showCupertinoParallax,
        preventDuplicates: preventDuplicates,
      );

  static GetPageBuilder getPageBuilder(String name, String keyMap) {
    Routes.getInstance.addRoute(keyMap, name);
    return () => QrScanPage();
  }
}
