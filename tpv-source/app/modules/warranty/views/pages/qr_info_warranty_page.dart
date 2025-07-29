// ignore_for_file: override_on_non_overriding_member, overridden_fields, prefer_function_declarations_over_variables, library_private_types_in_public_api, must_be_immutable

import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/config/errors/errors.dart';
import '/app/core/helpers/extract_failure.dart';
import '/app/core/helpers/store_short_cuts.dart';
import '/app/core/interfaces/app_page.dart';
import '/app/core/interfaces/get_provider.dart';
import '/app/core/interfaces/header_request.dart';
import '/app/core/interfaces/use_case.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/paths_service.dart';
import '/app/modules/warranty/bindings/warranty_binding.dart';
import '/app/modules/warranty/controllers/warranty_controller.dart';
import '/app/modules/warranty/domain/models/warranty_model.dart';
import '/app/modules/warranty/domain/usecases/get_warranty_usecase.dart';
import '/app/widgets/bar/custom_app_bar.dart';
import '/app/widgets/botton/custom_base_botton.dart';
import '/app/widgets/botton/custom_bottom_nav_bar.dart';
import '/app/widgets/ext/user_profile_avatar.dart';
import '/app/widgets/field/custom_get_view.dart';
import '/app/widgets/field/search_text.dart';
import '/app/widgets/images/background_image.dart';
import '/app/widgets/images/custom_image_source.dart';
import '/app/widgets/layout/card/empty_card.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '/app/widgets/qrflutter/qr_flutter.dart';
import '/app/widgets/utils/loading.dart';
import '/app/widgets/utils/qr_view.dart';
import '/app/widgets/utils/size_constraints.dart';
import '../../../../core/config/assets.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../routes/app_routes.dart';

class QrInfoWarrantyPage extends CustomView<WarrantyController> {
  late UseCase usecase;
  late CustomFutureBuilder fututeBuilder;
  late String warrantyId;

  QrInfoWarrantyPage() {
    warrantyId = Get.parameters["warrantyId"] ?? "";
    usecase = GetWarrantyUseCase<WarrantyModel>(Get.find())
        .setParamsFromMap({"id": warrantyId});

    Get.lazyPut(() => this);
  }
  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  @override
  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    if (uc is GetWarrantyUseCase<WarrantyModel>) {
      return getInfoWarrantyBuilder<A>();
    }
    return getInfoWarrantyBuilder();
  }

  @override
  Future<T> getFutureByUseCase<T>(UseCase uc) async {
    final result = await controller.getFutureByUseCase<T>(uc);
    return result;
  }

  AsyncWidgetBuilder<A> getInfoWarrantyBuilder<A>() {
    var builder = (BuildContext context, AsyncSnapshot<A> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return EmptyDataSearcherResult(
          child: Loading.fromText(
              key: key, text: "Generando QR de la garantía..."),
        );
      } else if (isDone(snapshot)) {
        final dart.Right resultData = snapshot.data as dart.Right;

        return QrInfoWarrantyView(
          warranty: resultData.value,
        );
      } else if (isError(snapshot)) {
        return Loading.fromText(key: key, text: snapshot.error.toString());
      }
      return Loading.fromText(key: key, text: "Generando QR de la garantía...");
    };
    return builder;
  }

  bool isDone(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
        snapshot.hasData &&
        snapshot.data is dart.Right;
  }

  bool isError(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data is dart.Left ||
        snapshot.error != null;
  }

  Widget rebuild(BuildContext context, UseCase uc) =>
      fututeBuilder = CustomFutureBuilder(
        future: getFutureByUseCase(uc),
        builder: getBuilderByUseCase(uc),
        initialData: [],
        context: context,
      );
}

class QrInfoWarrantyView extends StatefulWidget {
  final WarrantyModel warranty;

  QrInfoWarrantyView({
    Key? key,
    required this.warranty,
  }) : super(key: key);

  @override
  _QrInfoWarrantyViewState createState() => _QrInfoWarrantyViewState();
}

class WarrantyQrInfoPageImpl<T> extends CustomAppPageImpl<T> {
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

  WarrantyQrInfoPageImpl({
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

  static WarrantyQrInfoPageImpl builder({
    String name = "/warranty/qr-warranty-info",
    String keyMap = "WARRANTY_QR_WARRANTY_INFO",
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
      WarrantyQrInfoPageImpl(
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
    return () => QrInfoWarrantyPage();
  }
}

class _QrInfoWarrantyViewState extends State<QrInfoWarrantyView> {
  int index = 1;
  bool activateSearch = false;
  SearchText? searchInput;
  Map<String, dynamic> product = {};
  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: getProductWarranty(widget.warranty),
      builder: getBuilder(),
      context: context,
    );
  }

  Widget createPage(Widget child) {
    Size size = MediaQuery.of(context).size;

    final sizeConstraint = SizeConstraints(context: context);
    double sizeLogo = sizeConstraint.getHeightByPercent(10);
    String qrUrlService =
        "${PathsService.qrUrlService}dataUrl=${PathsService.merchantUrlService}dispatch-order/${widget.warranty.warrantyId}";

    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
        ),
        Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            bottomNavigationBar: CustomBotoonNavBar.fromRoute(
              "/product/product-info",
              listOfPages: getListOfPages,
            ),
            appBar: CustomAppBar(
              keyStore: "appbar",
              leading: Icon(Icons.menu),
              title: Text('Información'),
              actions: [
                //Icon(Icons.favorite),
                if (activateSearch) searchInput!,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CustomBaseBotton(
                    icon: Icon(Icons.search),
                    onHover: <CustomBaseBotton>(_, event, btn) {
                      setState(() {
                        activateSearch = true;
                      });
                    },
                    onExit: <CustomBaseBotton>(_, event, btn) {
                      setState(() {
                        activateSearch = false;
                      });
                    },
                    onTap: <CustomBaseBotton>(_, btn) {
                      setState(() {
                        activateSearch = !activateSearch;
                      });
                    },
                  ),
                ),
                UserProfileAvatar()
              ],
              backgroundColor: Color(0xFF00b1a4),
            ),
            body: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (ctx, constraint) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: size.height,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //WarrantyLogo(),
                          Container(
                            margin: EdgeInsets.only(top: 50, bottom: 50),
                            child: QRGenerator(
                              size: 300,
                              embeddedImage: AssetImage(
                                  ASSETS_IMAGES_LOGOS_WARRANTY_WARRANTY_LOGO_PNG),
                              embeddedImageStyle: QrEmbeddedImageStyle(
                                size: Size(sizeLogo, sizeLogo),
                              ),
                              data: qrUrlService,
                            ),
                          ),
                          Expanded(
                            child: child,
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ))
      ],
    );
  }

  AsyncWidgetBuilder<A> getBuilder<A>() {
    var builder = (BuildContext context, AsyncSnapshot<A> snapshot) {
      String productDescription = "Sin descripción";
      final sizeConstraint = SizeConstraints(context: context);
      late Widget child;
      if (snapshot.connectionState == ConnectionState.waiting) {
        return EmptyDataSearcherResult(
          child:
              Loading.fromText(text: "Cargando información del producto...."),
        );
      } else if (isDone(snapshot)) {
        if (snapshot.data is dart.Right) {
          product = (snapshot.data as dart.Right).value;
          productDescription = product.containsKey("description") &&
                  product["description"] != null &&
                  product["description"].toString().isNotEmpty
              ? product["description"]
              : "Producto sin descripción";
          log("Datos del producto:\n$product");
          child = ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFf4f4f4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              //TODO get product of warranty
              var id = product.containsKey("id") ? product["id"] : "";
              var idProduct =
                  product.containsKey("idProduct") ? product["idProduct"] : "";
              Get.toNamed(Routes.getInstance.getPath("PRODUCT_INFO"),
                  parameters: {"idProduct": idProduct, "id": id});
            },
            child: Container(
              color: Color(0xFFf4f4f4),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: product.containsKey("anyImage") &&
                              product["anyImage"].isNotEmpty
                          ? CustomImageResource(
                              context: context,
                              url: product["anyImage"].elementAt(0)["imageURL"],
                            )
                          : Image.asset(ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 1, left: 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.containsKey("productName")
                                ? product["productName"]
                                : "Sin denominación",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          FittedBox(
                            //fit: BoxFit.contain,
                            child: Text(
                              productDescription,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: sizeConstraint.getWidthByPercent(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_drop_down_circle),
                      color: const Color(0xFF00b1a4),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return createPage(child);
      } else if (isError(snapshot)) {
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        child = Center(
          child: EmptyDataCard(
            margin: EdgeInsets.only(top: 20),
            width: 150,
            height: 150,
            text: fail,
            onPressed: () {},
          ),
        );
        return createPage(child);
      }
      return Loading.fromText(text: "Cargando información de producto...");
    };
    return builder;
  }

  @override
  Future getProductWarranty(WarrantyModel warranty) async {
    final String? id = warranty.productIdService;
    if (id == null || id.isEmpty) {
      return dart.Left(EmptyParamsFailure(
          message: "No existe referencia al producto de la garantía."));
    }
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
      },
      idpKey: "apiez",
    ).getHeaders();
    final provider = GetDefautlProviderImpl(
      allowAutoSignedCert: true,
      followRedirects: true,
      maxAuthRetries: 3,
      maxRedirects: 3,
      sendUserAgent: true,
      timeout: const Duration(seconds: 5),
      userAgent: 'getx-client',
      withCredentials: false,
      baseUrl: PathsService.productUrlService,
      headers: headers,
      //certificates: certs,
    );
    final url = "products/id?id=$id";
    log("Cargando producto desde:${provider.baseUrl}$url");
    final response = await provider.processResponse(
      provider.get(
        url,
        headers: headers,
        decoder: (map) {
          if (map is Map<String, dynamic> && !map.containsKey("fault")) {
            return map;
          } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
            return Fault.fromJson(map['fault']);
          }
          return map;
        },
      ),
      provider: provider,
    );
    return response.fold((l) => dart.Left(l), (resp) {
      if (resp.statusCode == 200) {
        return dart.Right(resp.body);
      } else {
        log(resp.bodyString!);
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al consultar datos de un Producto.",
              "description": "Error al consultar datos de un Producto."
            }));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    activateSearch = false;
    searchInput = SearchText(
      width: 300,
      margin: EdgeInsets.only(left: 5, right: 1, top: 10, bottom: 10),
      containerDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
          width: 1.0,
        )),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.greenAccent,
            width: 1.0,
          ),
        ),
        hintText: "Buscar información de la garantía...",
        //prefixIcon: icon,
        labelStyle: TextStyle(color: Colors.white70),
        hintStyle: TextStyle(color: Colors.white70),
      ),
    );
  }

  bool isDone(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
        snapshot.hasData &&
        snapshot.data is dart.Right;
  }

  bool isError(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data is dart.Left ||
        snapshot.error != null;
  }
}
