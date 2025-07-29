// ignore_for_file: must_be_immutable, file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/patterns/publisher_subscriber.dart';
import '../../../app/core/interfaces/application.dart';
import '../../../app/core/interfaces/module.dart';
import '../../../app/core/services/logger_service.dart';
import '../../../globlal_constants.dart';
import '../../core/config/app_config.dart';
import '../../core/config/assets.dart';
import '../../core/helpers/widgets.dart';
import '../../modules/general_binding.dart';
import '../../modules/home/views/pages/home_page.dart';
import '../../modules/security/controllers/security_controller.dart';
import '../../modules/splash/splash_page.dart';
import '../../routes/app_pages.dart';
import '../components/reload.dart';
import '../event/event_notification.dart';
import '../images/background_image.dart';

class WarrantyApp extends StatelessWidget
    with
        WidgetsBindingObserver,
        SubscriberMixinImpl<WarrantyApp>,
        PublisherMixinImpl<WarrantyApp>
    implements Application<dynamic> {
  //ConfigApp globalConf = ConfigApp.getInstance;
  MediaQueryData? queryData;

  List<Module> _modules = [];

  //
  final myAppKey = genAppKey();

  @override
  List<Module> get applicationModules => _modules;
  @override
  Map<String, List<void Function(Publisher<Subscriber<WarrantyApp>> event)>>
      get getSubscriptionsFunction => subscriptionsFunction;
  @override
  Widget build(BuildContext context) {
    final loginRoute = ConfigApp.getInstance.configModel!.loginRoute;
    //Load pages at startup
    final ctl = SecurityController();
    final theme = ctl.getActiveTheme();

    /*final rbackCtl = RbacController.getInstance;
    rbackCtl.loadRoles({
      "path": ASSETS_MODELS_SECURITY_JSON,
    }).then((response) {
      response.fold((l) => log(l.toString()), (r) {
        rbackCtl.setRbac(r);
      });
    });*/
    Get.addKey(myAppKey);
    final materialApp = GetMaterialApp(
      enableLog: true,
      popGesture: Get.isPopGestureEnable,
      logWriterCallback: localLogWriter,
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
        Locale('it'),
        Locale('fr'),
      ],
      debugShowCheckedModeBanner: false,
      title: ConfigApp.getInstance.configModel!.name,
      defaultTransition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
      theme: theme,
      initialRoute: loginRoute,
      initialBinding: GeneralBinding(),
      getPages: AppPages.getRoutePages(),
      routes: AppPages.getRoutes(context),
      navigatorKey: myAppKey,
      builder: (context, child) {
        queryData = MediaQuery.of(context);
        ConfigApp.refresh(context);
        return GetBuilder<SecurityController>(
          init: ctl,
          initState: (GetBuilderState<SecurityController> state) {
            /*state.controller ??= ctl;
              state.controller!.authStatus = AuthStatus.cheking;
              state.controller!.isAuthenticated().then((value) {
                state.controller!.authStatus = value
                    ? AuthStatus.authenticated
                    : AuthStatus.notAuthenticated;
              });*/
          },
          builder: ((controller) {
            //Registro global de propiedades con GetX sencillo pero efectivo
            if (!Get.isRegistered<Map<dynamic, dynamic>>()) {
              Get.lazyPut<Map<dynamic, dynamic>>(() => {});
            }
            final conf = ConfigApp.getInstance;
            bool isConected = conf.getValue<bool>("networkStatus") ?? false;

            log("isConected:$isConected");
            //Si está el dispositivo desconectado de la red o no hay conección a internet.
            if (isConected == false) {
              return SplashPage(
                isNetWorkAvaliable: isConected,
                onReload: () {
                  runApp(WarrantyApp());
                },
                backGround: BackGroundImage(
                  backgroundImage:
                      ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
                ),
              );
            }

            //Está el dispositivo conectado a la red y hay acceso a internet
            if (controller.authStatus == AuthStatus.cheking) {
              log('Main: chequing auth status');
              return SplashPage(
                isNetWorkAvaliable: isConected,
                onReload: () {
                  runApp(WarrantyApp());
                },
                backGround: BackGroundImage(
                  backgroundImage:
                      ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
                ),
              );
            } else if (controller.authStatus == AuthStatus.authenticated) {
              log('Main: usuario autenticado');
              return Theme(
                data: theme,
                child: HomePage(
                  child: child!,
                ),
              );
            } else {
              log('Main: usuario no autenticado');
              return ReloadWidget(
                child: child!,
              );
            }
          }),
        );
      },
    );

    WidgetsBinding.instance.addObserver(this);
    return NotificationListener<EventNotification>(
      onNotification: (notification) {
        return true;
      },
      child: EventNotifier(
        child: NotificationListener<SizeChangedLayoutNotification>(
          onNotification: (notification) {
            //here you can't use setState, so you can't have a bool on which differentiate the layout,
            //but you should be able to call build(context) to force a rebuild
            ConfigApp.getInstance.appIsResizing = true;
            Timer(Duration(seconds: 1), () {
              // Do something
              ConfigApp.getInstance.appIsResizing = false;
            });
            return ConfigApp.getInstance.appIsResizing;
          },
          child: SizeChangedLayoutNotifier(
            child: materialApp,
          ),
        ),
      ),
    );
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    fireEvent("onWindowResize", {
      "queryData": queryData,
    });
  }

  @override
  String getApplicationDescription() {
    if (ConfigApp.getInstance.configModel != null) {
      return "Aplicación ${ConfigApp.getInstance.configModel!.app.name}";
    }
    return "Sin descripción";
  }

  @override
  String getApplicationId() {
    if (ConfigApp.getInstance.configModel != null) {
      return ConfigApp.getInstance.configModel!.app.applicationId;
    }
    return globalApplicationId;
  }

  @override
  List<Module> getApplicationModules() => _modules;

  @override
  String getApplicationName() {
    if (ConfigApp.getInstance.configModel != null) {
      return ConfigApp.getInstance.configModel!.app.name;
    }
    return "Sin nombre";
  }

  @override
  Future initApplicationModules() async {
    _modules = ConfigApp.getInstance.getApplicationModules();
    return Future.value(_modules);
  }

  void localLogWriter(String text, {bool isError = false}) {
    // pass the message to your favourite logging package here
    // please note that even if enableLog: false log messages will be pushed in this callback
    // you get check the flag if you want through GetConfig.isLogEnable
    log(text);
  }
}
