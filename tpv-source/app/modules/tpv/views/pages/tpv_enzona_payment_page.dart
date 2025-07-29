// ignore_for_file: must_be_immutable, overridden_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/config/app_home_container.dart';
import '/app/core/interfaces/app_page.dart';
import '/app/modules/home/widgets/navbar.dart';
import '/app/modules/home/widgets/sidebar.dart';
import '/app/modules/tpv/bindings/tpv_binding.dart';
import '/app/modules/tpv/controllers/tpv_controller.dart';
import '/app/modules/tpv/views/tpv_opening_view.dart';
import '../../../../routes/app_routes.dart';

class TpvSTCPage extends GetResponsiveView<TpvController> {
  final Widget child;

  TpvSTCPage({Key? key, required this.child})
      : super(
            key: key,
            settings: ResponsiveScreenSettings(
              desktopChangePoint: 800,
              tabletChangePoint: 700,
              watchChangePoint: 600,
            ));

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget? desktop() {
    super.desktop();
    var sideBarContainer =
        AppHomeContainerProvider.getHomeContainer(screen.context, 15);

    final sideBar = SideBar(
      sideBarContainer: sideBarContainer,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          sideBar,
          Expanded(
            child: Scaffold(
              appBar: NavBar.instance,
              body: child,
            ),
          )
        ],
      ),
    );
  }

  @override
  phone() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavBar.instance,
      body: Row(
        children: [
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  tablet() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavBar.instance,
      body: Row(
        children: [
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  watch() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavBar.instance,
      body: Row(
        children: [
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

class TpvSTCPImpl<T> extends CustomAppPageImpl<T> {
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

  TpvSTCPImpl({
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
  Route<T> createRoute(BuildContext context) {
    final page = PageRedirect(
      route: this,
      settings: this,
      unknownRoute: unknownRoute,
    ).getPageToRoute<T>(this, unknownRoute);
    return page;
  }

  static TpvSTCPImpl builder({
    String name = "/tpv-select-starting-cash-page",
    String keyMap = "",
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
      TpvSTCPImpl(
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
        binding: binding ?? TpvBinding(),
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
    Routes.getInstance.addRoute("TPV_SELECT_STARTING_CASH", name);
    return () => TpvOpeningView();
  }
}
