// ignore_for_file: library_private_types_in_public_api, prefer_function_declarations_over_variables, must_be_immutable

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/app/core/helpers/extract_failure.dart';
import '/app/core/helpers/functions.dart';
import '/app/core/helpers/snapshot.dart';
import '/app/core/interfaces/app_page.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/interfaces/use_case.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/core/services/paths_service.dart';
import '/app/core/services/user_session.dart';
import '/app/modules/order/domain/usecases/list_order_usecase.dart';
import '/app/modules/security/domain/models/profile_model.dart';
import '/app/modules/warranty/bindings/warranty_binding.dart';
import '/app/modules/warranty/controllers/warranty_controller.dart';
import '/app/modules/warranty/domain/models/warranty_model.dart';
import '/app/modules/warranty/domain/usecases/filter_warranty_usecase.dart';
import '/app/modules/warranty/views/warranty_list_view.dart';
import '/app/widgets/bar/custom_app_bar.dart';
import '/app/widgets/images/background_image.dart';
import '/app/widgets/layout/card/empty_card.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '/app/widgets/utils/loading.dart';
import '/globlal_constants.dart';
import '../../../../core/config/assets.dart';
import '../../../../routes/app_routes.dart';

class WarrantyInfoPage extends GetResponsiveView<WarrantyController> {
  late UseCase usecase;
  late CustomFutureBuilder futureBuilder;
  bool remoteLoaded = false;
  WarrantyInfoPage() {
    Get.lazyPut(() => this);
    usecase = applyRules(FilterWarrantyUseCase<WarrantyModel>(Get.find()));
    controller.filterUseWarranty =
        usecase as FilterWarrantyUseCase<WarrantyModel>;
  }
  UseCase applyRules(UseCase uc) {
    String ci = gParams.containsKey("ci") ? gParams["ci"]!.toString() : "";
    int page = gParams.containsKey("page") ? int.parse(gParams["page"]!) : 0;
    int count = gParams.containsKey("count") ? int.parse(gParams["count"]!) : 5;
    return uc.setParamsFromMap({
      "ci": ci,
      "page": page,
      "count": count,
    });
  }

  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  Widget createPage(BuildContext context, Widget body) {
    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          //bottomNavigationBar: CustomBotoonNavBar.fromRoute(Get.currentRoute),
          appBar: CustomAppBar(
            keyStore: "garantia",
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back),
            ),
            title: Text('Mis garantías'),
            backgroundColor: Color(0xFF00b1a4),
          ),
          body: SafeArea(
            minimum: EdgeInsets.only(top: 30),
            child: body,
          ),
        )
      ],
    );
  }

  createWidgetFromWarranties(ProfileModel? profile, {Widget? child}) {
    remoteLoaded = false;
    final avatarUrl = (remoteLoaded =
            (profile != null && profile.userName.isNotEmpty))
        ? "${PathsService.mediaHost}images/user/avatar/${profile!.userName}.png"
        : Assets.ASSETS_IMAGES_ICONS_APP_CUENTA_PNG.getPath;
    bool isValid = profile != null;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              child: ClipRRect(
                child: isValid
                    ? Image.network(avatarUrl)
                    : Image.asset(
                        avatarUrl), // CustomImageResource.buildFromUrl(avatarUrl),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            Text(
                isValid
                    ? "${profile.givenName} ${profile.familyName}"
                    : "Perfil del usuario",
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ) /*TextStyle(
                fontSize: 40,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontFamily: "Pacifico",
              ),*/
                ),
            Text(
              isValid ? profile.userName : "Usuario",
              style: TextStyle(
                fontSize: 30,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontFamily: "Source Sans Pro",
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            if (child != null) child,
          ],
        ),
      ),
    );
  }

  AsyncWidgetBuilder<A> filterWarrantiesBuilder<A>() {
    return getListWarrantyBuilder<A>();
  }

  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    if (uc is ListOrderUseCase) return getListWarrantyBuilder<A>();
    if (uc is FilterWarrantyUseCase) return filterWarrantiesBuilder<A>();
    return getListWarrantyBuilder();
  }

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }

  AsyncWidgetBuilder<A> getListWarrantyBuilder<A>() {
    var builder = (BuildContext context, AsyncSnapshot<A> snapshot) {
      final service = ManagerAuthorizationService().get(defaultIdpKey);
      UserSession? usession = service?.getUserSession();

      final profile = usession?.getBy<ProfileModel>(
        "profile",
        converter: (data, key) {
          return ProfileModel.converter(data, key);
        },
      );
      final isValid = profile != null;
      EntityModelList<WarrantyModel> warrantyList = DefaultEntityModelList();
      Widget? result;
      Widget? child;
      if (isWaiting(snapshot)) {
        result = EmptyDataSearcherResult(
          child: Loading.fromText(key: key, text: "Cargando garantías..."),
        );
      } else if (isDone<dartz.Right>(snapshot)) {
        final dartz.Right resultData = snapshot.data as dartz.Right;
        warrantyList = resultData.value;
        remoteLoaded = true;
        if (!isValid) {
          child = EmptyDataCard(
              text: "No se inició correctamente el perfil del usuario.",
              margin: EdgeInsets.only(top: 20),
              onPressed: () {});
        }
        if (isValid && warrantyList.getTotal <= 0) {
          child = EmptyDataCard(
              text: "No hay datos para mostrar.",
              margin: EdgeInsets.only(top: 20),
              onPressed: () {});
        }
        if (isValid && warrantyList.getTotal > 0) {
          return WarrantyListView(
            items: warrantyList,
          );
        }
        result = createPage(
            context,
            createWidgetFromWarranties(
              profile,
              child: child,
            ));
      } else if (isError<dartz.Left>(snapshot)) {
        final data = snapshot.data as dartz.Left;
        final fail = FailureExtractor.failure(data);

        if (!isValid) {
          child = EmptyDataCard(
              text: fail.getMessage(),
              margin: EdgeInsets.only(top: 20),
              onPressed: () {});
        }
        if (isValid && warrantyList.getTotal <= 0) {
          child = EmptyDataCard(
              text: fail.getMessage(), // "No hay datos para mostrar.",
              margin: EdgeInsets.only(top: 20),
              onPressed: () {});
        }
        if (isValid && warrantyList.getTotal > 0) {
          return WarrantyListView(
            items: warrantyList,
          );
        }
        result = createPage(
            context,
            createWidgetFromWarranties(
              profile,
              child: child,
            ));
      }
      return result ??
          Loading.fromText(key: key, text: "Cargando garantías...");
    };
    return builder;
  }

  Widget rebuild(BuildContext context, UseCase uc) =>
      futureBuilder = CustomFutureBuilder(
        future: getFutureByUseCase(uc),
        builder: getBuilderByUseCase(uc),
        context: context,
      );
}

class WarrantyInfoPageImpl<T> extends CustomAppPageImpl<T> {
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

  WarrantyInfoPageImpl({
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

  static WarrantyInfoPageImpl builder({
    String name = "/warranties",
    String keyMap = "WARRANTIES",
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
      WarrantyInfoPageImpl(
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
    return () => WarrantyInfoPage();
  }
}
