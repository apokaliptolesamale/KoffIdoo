// ignore_for_file: must_be_immutable, overridden_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/config/assets.dart';
import '/app/core/interfaces/app_page.dart';
import '/app/modules/security/controllers/security_controller.dart';
import '/app/modules/warranty/bindings/warranty_binding.dart';
import '/app/modules/warranty/views/colors.dart';
import '/app/modules/warranty/views/pages/warranty_notification_page.dart';
import '/app/widgets/field/custom_labeled_check_box.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widgets/images/background_image.dart';

class CreateAccountView extends GetResponsiveView<SecurityController> {
  final Widget? child;

  CreateAccountView({
    Key? key,
    this.child,
  }) : super(
            key: key,
            settings: ResponsiveScreenSettings(
              desktopChangePoint: 800,
              tabletChangePoint: 700,
              watchChangePoint: 600,
            ));
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Container(
              margin: EdgeInsets.only(left: 80, right: 80),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 100, right: 100),
                    height: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF00b1a4),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: const Color(0xFF00b1a4),
                              )),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                              border: InputBorder.none,
                              hintText:
                                  'Celular (8 dígitos) o Correo electrónico',
                              hintStyle: TextStyle(
                                color: const Color(0xFF00b1a4),
                                fontSize: 22,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.phone_android,
                                  color: const Color(0xFF00b1a4),
                                  size: 30,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: const Color(0xFF00b1a4),
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Container(
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF00b1a4),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: const Color(0xFF00b1a4),
                              )),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                              border: InputBorder.none,
                              hintText: 'Número de identidad',
                              hintStyle: TextStyle(
                                color: const Color(0xFF00b1a4),
                                fontSize: 22,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.perm_identity,
                                  color: const Color(0xFF00b1a4),
                                  size: 30,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: const Color(0xFF00b1a4),
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Container(
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF00b1a4),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: const Color(0xFF00b1a4),
                              )),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                              border: InputBorder.none,
                              hintText: 'Tomo',
                              hintStyle: TextStyle(
                                color: const Color(0xFF00b1a4),
                                fontSize: 22,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.numbers,
                                  color: const Color(0xFF00b1a4),
                                  size: 30,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: const Color(0xFF00b1a4),
                              fontSize: 22,
                            ),
                          ),
                        ),
                        //END OF FIRST TEXT FIELD
                        Container(
                          height: 10,
                        ),
                        Container(
                          child: TextField(
                            obscureText: false,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF00b1a4),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: const Color(0xFF00b1a4),
                              )),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                              border: InputBorder.none,
                              hintText: 'Folio',
                              hintStyle: TextStyle(
                                color: const Color(0xFF00b1a4),
                                fontSize: 22,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.numbers,
                                  color: const Color(0xFF00b1a4),
                                  size: 30,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: const Color(0xFF00b1a4),
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Container(
                          child: TextField(
                            obscureText: false,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF00b1a4),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: const Color(0xFF00b1a4),
                              )),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                              border: InputBorder.none,
                              hintText: 'Contraseña*',
                              hintStyle: TextStyle(
                                color: const Color(0xFF00b1a4),
                                fontSize: 22,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.key,
                                  color: const Color(0xFF00b1a4),
                                  size: 30,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: const Color(0xFF00b1a4),
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Container(
                          child: TextField(
                            obscureText: false,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF00b1a4),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: const Color(0xFF00b1a4),
                              )),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                              border: InputBorder.none,
                              hintText: 'Confirmar contraseña*',
                              hintStyle: TextStyle(
                                color: const Color(0xFF00b1a4),
                                fontSize: 22,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.key,
                                  color: const Color(0xFF00b1a4),
                                  size: 30,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: const Color(0xFF00b1a4),
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Container(
                          child: TextField(
                            obscureText: false,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF00b1a4),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: const Color(0xFF00b1a4),
                              )),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                              border: InputBorder.none,
                              hintText: 'Capcha',
                              hintStyle: TextStyle(
                                color: const Color(0xFF00b1a4),
                                fontSize: 22,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.update,
                                  color: const Color(0xFF00b1a4),
                                  size: 30,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: const Color(0xFF00b1a4),
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Container(
                          child: TextField(
                            obscureText: false,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF00b1a4),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: const Color(0xFF00b1a4),
                              )),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                              border: InputBorder.none,
                              hintText: 'Escriba el capcha',
                              hintStyle: TextStyle(
                                color: const Color(0xFF00b1a4),
                                fontSize: 22,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.receipt,
                                  color: const Color(0xFF00b1a4),
                                  size: 30,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0xFF00b1a4),
                              fontSize: 22,
                            ),
                          ),
                        ),
                        GroupLabeledCheckbox(
                            textStyle: TextStyle(
                              color: Color(0xFF00b1a4),
                              fontSize: 20,
                            ),
                            list: [
                              LabeledCheckbox(
                                label: "Guardar dispositivo",
                                value: false,
                                onChanged: (newValue) {},
                                leadingCheckbox: true,
                              ),
                              LabeledCheckbox(
                                label: "Acepto la Política de Privacidad",
                                value: false,
                                onChanged: (newValue) {},
                                leadingCheckbox: true,
                              )
                            ]),

                        //END OF SECOND TEXT FIELD

                        Container(
                          height: 40,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 30),
                          child: MaterialButton(
                            onPressed: () {
                              //TODO implementar el registro y redireccionar hacia la pagina de notificacion con confirmacion.
                              NotificationPage.getInstance.createNotify(
                                  "Su usuario ha sido registrado correctamente. Por favor,presione Aceptar para continuar.");
                              NotificationPage.getInstance
                                  .createBotton("ACEPTAR", () {
                                Get.toNamed(
                                    Routes.getInstance.getPath("INDEX"));
                              });

                              Get.toNamed(Routes.getInstance
                                  .getPath("WARRANTY_NOTIFICATION"));
                            },
                            shape: const StadiumBorder(),
                            color: aceptBottonColor,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 3.0,
                                //horizontal: 24.0,
                              ),
                              child: Text(
                                "REGISTRAR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        //END OF BUTTON
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WarrantyCreateAccountPageImpl<T> extends CustomAppPageImpl<T> {
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

  WarrantyCreateAccountPageImpl({
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

  static WarrantyCreateAccountPageImpl builder({
    String name = "/warranty-registry",
    String keyMap = "REGISTRY_LOGIN",
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
      WarrantyCreateAccountPageImpl(
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
    return () => CreateAccountView();
  }
}
