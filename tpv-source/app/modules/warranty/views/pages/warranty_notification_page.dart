// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/warranty/bindings/warranty_binding.dart';
import '../../../../core/config/assets.dart';
import '../../../../core/interfaces/app_page.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/images/background_image.dart';
import '../colors.dart';

class NotificationPage<Controller> extends GetResponsiveView<Controller> {
  static final NotificationPage getInstance = NotificationPage._internal();
  Widget? notify;

  List<Widget>? bottonsList;
  NotificationPage._internal()
      : super(
            settings: ResponsiveScreenSettings(
          desktopChangePoint: 800,
          tabletChangePoint: 700,
          watchChangePoint: 600,
        ));

  @override
  Widget build(BuildContext context) {
    if (NotificationPage.getInstance.notify == null) {
      Future.microtask(() => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AppPages.getIndex("/index"))));
      // Get.toNamed(Routes.getInstance.getPath("INDEX"));
    }

    final List<Widget> btns =
        NotificationPage.getInstance.bottonsList ?? <Widget>[];

    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
        ),
        Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Container(
              margin: EdgeInsets.only(left: 80, right: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NotificationPage.getInstance.notify ?? Container(),
                  if (btns.isNotEmpty && btns.length == 1)
                    ...btns
                  else if (btns.isNotEmpty && btns.length > 1)
                    Row(
                      children: btns,
                    )
                ],
              ),
            )),
      ],
    );
  }

  List<Widget> createBotton(String label, void Function()? onPressed) {
    return NotificationPage.getInstance.bottonsList = [
      Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: MaterialButton(
          height: 50,
          onPressed: onPressed ??
              () {
                Get.toNamed(Routes.getInstance.getPath("INDEX"));
              },
          shape: StadiumBorder(),
          color: aceptBottonColor,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    ];
  }

  Widget createNotify(String msg) {
    return NotificationPage.getInstance.notify = Container(
      height: 350,
      margin: EdgeInsets.only(left: 10, right: 10, top: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Image.asset(
              ASSETS_IMAGES_LOGOS_ENZONA_EZ_LOGO_PNG,
              height: 50,
              width: 50,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              //color: Colors.red,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: notificationTextColor,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
            bottom: 30,
          ))
        ],
      ),
    );
  }

  setBottons(List<Widget> bottons) {
    bottonsList = bottons;
    return this;
  }

  setNotifyWidget(Widget notifyWidget) {
    notify = notifyWidget;
    return this;
  }
}

class WarrantyNotificationPageImpl<T> extends CustomAppPageImpl<T> {
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

  WarrantyNotificationPageImpl({
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

  static WarrantyNotificationPageImpl builder({
    String name = "/warranty-notifiction",
    String keyMap = "WARRANTY_NOTIFICATION",
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
      WarrantyNotificationPageImpl(
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
        binding: binding ?? WarrantyBinding(),
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
    return () => NotificationPage.getInstance;
  }
}
