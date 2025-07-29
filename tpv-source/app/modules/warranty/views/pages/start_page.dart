// ignore_for_file: overridden_fields, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '/app/core/config/app_config.dart';
import '/app/core/helpers/store_short_cuts.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/core/services/user_session.dart';
import '/app/modules/product/domain/models/role_model.dart';
import '/app/modules/security/domain/models/profile_model.dart';
import '/app/widgets/bar/custom_app_bar.dart';
import '/app/widgets/botton/custom_base_botton.dart';
import '/app/widgets/botton/custom_bottom_nav_bar.dart';
import '/app/widgets/ext/user_profile_avatar.dart';
import '/app/widgets/images/background_image.dart';
import '/globlal_constants.dart';
import '../../../../../app/core/interfaces/app_page.dart';
import '../../../../../app/modules/warranty/bindings/warranty_binding.dart';
import '../../../../../app/modules/warranty/controllers/warranty_controller.dart';
import '../../../../core/config/assets.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widgets/components/bell.dart';

class StartPageAs extends GetResponsiveView<WarrantyController> {
  @override
  Widget build(BuildContext context) {
    return StartViewWidget();
  }
}

class StartViewWidget extends StatefulWidget {
  @override
  _StartViewWidgetState createState() => _StartViewWidgetState();
}

class WarrantyAppHomePageImpl<T> extends CustomAppPageImpl<T> {
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

  WarrantyAppHomePageImpl({
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

  static WarrantyAppHomePageImpl builder({
    String name = "/warranty/home",
    String keyMap = "WARRANTY_HOME",
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
      WarrantyAppHomePageImpl(
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
    return () => StartPageAs();
  }
}

class _StartViewWidgetState extends State<StartViewWidget> {
  bool _showNotification = false;
  bool _wasCalled = false;
  String _notificationText = '';
  Timer? _notificationTimer;
  bool activateSearch = false;
  late FrameCallback _callback;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Método
  void afterBuild(BuildContext context, String msg) {
    // Aquí puedes agregar la lógica que deseas ejecutar después de que se construya el widget
    /*final snackBar = SnackBar(
      content: Text(
        'Esta es una notificación',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      showCloseIcon: true,
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      dismissDirection: DismissDirection.down,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
    _notificationText = msg;
    if (!_wasCalled) {
      _wasCalled = true;
      _showAppBarNotification(
        context,
        _notificationText,
        Duration(seconds: 5),
        () {
          setState(() {
            _showNotification = false;
            _wasCalled = true;
          });
        },
      );
      WidgetsBinding.instance.scheduleForcedFrame();
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    UserSession? usession = service?.getUserSession();
    ProfileModel? profile = usession?.getBy<ProfileModel>(
      "profile",
      converter: (data, key) {
        return ProfileModel.converter(data, key);
      },
    );
    if (profile == null) {
      /*_callback = (_) {
        usession!.clearSession();
        service!.isValid(refreshIfExpired: true).then((value) {
          Get.toNamed(Routes.getInstance.getPath("WARRANTY_LOGIN"));
        });
        //Get.toNamed(Routes.getInstance.getPath("WARRANTY_LOGIN"));
      };
      WidgetsBinding.instance.addPostFrameCallback(_callback);
      return Stack(children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
        ),
        WarrantyView()
      ]);*/
    }
    final theme = Theme.of(context).copyWith(primaryColor: Color(0xFF00b1a4));
    TextStyle? btnTextStyle = theme.textTheme.titleMedium;
    //btnTextStyle = btnTextStyle!.copyWith(color: Colors.black);
    String notify = "¡Bienvenido!";
    log(profile != null
        ? "El perfil iniciado es del usuario: ${profile.userName}"
        : "No se inició correctamete el perfil de usuario.");
    notify = "¡Bienvenido${profile != null ? " ${profile.givenName}" : ''}!";

    final appBar = CustomAppBar(
      keyStore: "appbar",
      actionsIconTheme: theme.iconTheme,
      iconTheme: theme.iconTheme,
      foregroundColor: theme.appBarTheme.foregroundColor,
      shadowColor: theme.appBarTheme.shadowColor,
      surfaceTintColor: theme.appBarTheme.surfaceTintColor,
      systemOverlayStyle: theme.appBarTheme.systemOverlayStyle,
      toolbarTextStyle: theme.appBarTheme.toolbarTextStyle,
      titleTextStyle: theme.appBarTheme.titleTextStyle,
      backgroundColor: Color(0xFF00b1a4).withBlue(215).withGreen(200).withRed(
          70), // theme.appBarTheme.backgroundColor, // Color(0xFF00b1a4),
      leading: Icon(Icons.menu),
      title: Text(
        ConfigApp.getInstance.configModel!.name,
        style: theme.textTheme.titleLarge,
      ),
      actions: [
        //Icon(Icons.favorite),
        //if (activateSearch) searchInput!,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CustomBaseBotton(
            icon: BellWidget(),
            onHover: <CustomBaseBotton>(_, event, btn) {
              /*setState(() {
                        activateSearch = true;
                      });*/
            },
            onExit: <CustomBaseBotton>(_, event, btn) {
              /*setState(() {
                        activateSearch = false;
                      });*/
            },
            onTap: <CustomBaseBotton>(_, btn) {
              /*setState(() {
                        activateSearch = !activateSearch;
                      });*/
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: UserProfileAvatar(
            user: profile != null ? profile.userName : "",
          ),
        ),
      ],
    );
    _callback = (_) {
      afterBuild(context, notify);
      if (profile == null && service != null) {
        service.isValid(refreshIfExpired: true);
      }
    };
    WidgetsBinding.instance.addPostFrameCallback(_callback);

    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
        ),
        Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: CustomBotoonNavBar.fromRoute(
            Get.currentRoute,
            listOfPages: getListOfPages,
          ),
          appBar: appBar,
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          direction: Axis.horizontal,
                          spacing: 10,
                          children: [
                            //FIRST BUTTON
                            Container(
                              color: Colors.transparent,
                              height: 200,
                              width: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        //RoleModel.instance.asTransportista();
                                        RoleModel.instance.asAdministrador();
                                        Get.toNamed(Routes.getInstance
                                            .getPath("ORDERS"));
                                      },
                                      child: Container(
                                        child: Image(
                                          image: AssetImage(
                                              ASSETS_IMAGES_ICONS_APP_WARRANTY_TRANSPORTE_PNG),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Órdenes',
                                    style: btnTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            //SECOND BUTTON
                            Container(
                              color: Colors.transparent,
                              height: 200,
                              width: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        RoleModel.instance.asCliente();
                                        Get.toNamed(Routes.getInstance
                                            .getPath("ORDERS"));
                                      },
                                      child: Container(
                                        child: Image(
                                          image: AssetImage(
                                              ASSETS_IMAGES_ICONS_APP_WARRANTY_PEDIDOS_PNG),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Pedidos',
                                    style: btnTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            //Tercer BUTTON
                            Container(
                              color: Colors.transparent,
                              height: 200,
                              width: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed: () async {
                                        RoleModel.instance.asCliente();
                                        profile = usession
                                            ?.getBy<ProfileModel>("profile");
                                        Get.toNamed(
                                            Routes.getInstance
                                                .getPath("WARRANTIES"),
                                            parameters: {
                                              "ci": profile != null
                                                  ? profile!.identification
                                                  : ""
                                            });
                                      },
                                      child: Container(
                                        child: Image(
                                          image: AssetImage(
                                              ASSETS_IMAGES_ICONS_APP_WARRANTY_GARANTIA_JPEG),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Garantías',
                                    style: btnTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            //USERADMIN BUTTON
                            Container(
                              color: Colors.transparent,
                              height: 200,
                              width: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed: () async {
                                        RoleModel.instance.asAdministrador();
                                        Get.toNamed(
                                            Routes.getInstance.getPath("TPV"),
                                            parameters: {
                                              "ci": profile!.identification
                                            });
                                      },
                                      child: Container(
                                        child: Image(
                                          image: AssetImage(
                                              ASSETS_IMAGES_ICONS_APP_USER_ADMIN_PNG),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Administración',
                                    style: btnTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Agregamos la notificación en un AnimatedContainer o AnimatedOpacity
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: _showNotification ? kToolbarHeight : 0,
                child: Material(
                  elevation: 4,
                  textStyle: theme.textTheme.bodyMedium,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(_notificationText),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _notificationTimer?.cancel();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _callback = (_) => afterBuild(context, "");
  }

  void _showAppBarNotification(BuildContext context, String notificationText,
      Duration duration, VoidCallback onDismissed) {
    setState(() {
      _showNotification = true;
      _notificationText = notificationText;
    });

    _notificationTimer = Timer(duration, () {
      setState(() {
        _showNotification = false;
      });
      onDismissed();
    });
  }
}
