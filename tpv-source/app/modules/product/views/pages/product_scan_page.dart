// ignore_for_file: library_private_types_in_public_api, overridden_fields, prefer_function_declarations_over_variables, must_be_immutable

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/config/assets.dart';
import '/app/core/helpers/extract_failure.dart';
import '/app/core/helpers/store_short_cuts.dart';
import '/app/core/interfaces/app_page.dart';
import '/app/core/interfaces/use_case.dart';
import '/app/modules/product/domain/models/product_model.dart';
import '/app/modules/product/domain/usecases/get_product_usecase.dart';
import '/app/widgets/bar/custom_app_bar.dart';
import '/app/widgets/botton/custom_bottom_nav_bar.dart';
import '/app/widgets/ext/user_profile_avatar.dart';
import '/app/widgets/field/custom_get_view.dart';
import '/app/widgets/field/search_text.dart';
import '/app/widgets/images/background_image.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '/app/widgets/utils/loading.dart';
import '../../../../routes/app_routes.dart';
import '../../../product/bindings/product_binding.dart';
import '../../../product/controllers/product_controller.dart';

class ProductScannerImpl<T> extends CustomAppPageImpl<T> {
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

  ProductScannerImpl({
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

  static ProductScannerImpl builder({
    String name = "/product/data-scanner",
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
      ProductScannerImpl(
        name: name,
        keyMap: keyMap,
        page: getPageBuilder(name, keyMap),
        index: -1,
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
        binding: binding ?? ProductBinding(),
        bindings: bindings ?? [],
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
    Routes.getInstance.addRoute("PRODUCT_DATA_SCANNER", name);
    return () => ProductScanPage();
  }
}

class ProductScanPage extends CustomView<ProductController> {
  late UseCase usecase;
  late CustomFutureBuilder fututeBuilder;
  late String idProduct;
  //late ProductFrameDetail frame;

  int index = 3;
  bool activateSearch = false;
  SearchText? searchInput;
  late ProductModel product;
  //late ProductList<ProductModel> products;

  ProductScanPage() {
    Get.lazyPut(() => this);
    idProduct = Get.parameters.containsKey("idProduct")
        ? Get.parameters["idProduct"] ?? ""
        : "";

    if (idProduct.isNotEmpty) {
      usecase = GetProductUseCase<ProductModel>(Get.find());
      usecase = usecase.setParamsFromMap({"id": idProduct});
    } /*else {
      usecase = ListProductUseCase<ProductModel>(Get.find());
    }*/
  }

  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  @override
  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    if (uc is GetProductUseCase) return getProductInfoBuilder<A>();
    return getProductInfoBuilder();
  }

  @override
  Future<T> getFutureByUseCase<T>(UseCase uc) {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }

  AsyncWidgetBuilder<A> getProductInfoBuilder<A>() {
    var builder = (BuildContext context, AsyncSnapshot<A> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return EmptyDataSearcherResult(
          child: Loading.fromText(
              key: key, text: "Cargando información del producto..."),
        );
      } else if (isDone(snapshot)) {
        final dartz.Right resultData = snapshot.data as dartz.Right;
        if (resultData.value is ProductModel) {
          product = resultData.value;
          // products = ProductList.fromModels([product]);
        } else if (resultData.value is ProductList<ProductModel>) {
          // products = resultData.value;
        }
        return ProductScanView(
          product: product,
        );
      } else if (isError(snapshot)) {
        final fail = FailureExtractor.message(snapshot.data as dartz.Left);
        return Text(fail);
      }
      return Loading.fromText(
          key: key, text: "Cargando información de producto...");
    };
    return builder;
  }

  bool isDone(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
        snapshot.hasData &&
        snapshot.data is dartz.Right;
  }

  bool isError(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data is dartz.Left ||
        snapshot.error != null;
  }

  Widget rebuild(BuildContext context, UseCase uc) =>
      fututeBuilder = CustomFutureBuilder(
        future: getFutureByUseCase(uc),
        builder: getBuilderByUseCase(uc),
        context: context,
      );
}

class ProductScanView extends StatefulWidget {
  final ProductModel product;

  ProductScanView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductScanViewState createState() => _ProductScanViewState();
}

class _ProductScanViewState extends State<ProductScanView> {
  int index = 1;
  //bool activateSearch = false;
  // SearchText? searchInput;
  late ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBotoonNavBar.fromRoute(
        Get.currentRoute,
        listOfPages: getListOfPages,
      ),
      body: Stack(
        children: [
          BackGroundImage(
            backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              keyStore: "appbar",
              leading: Icon(Icons.menu),
              title: Text('Productos'),
              actions: [
                //Icon(Icons.favorite),
                /*Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CustomBaseBotton(
                    icon: Icon(Icons.search),
                    onHover: (_, event) {
                      /*setState(() {
                      activateSearch = true;
                    });*/
                    },
                    onExit: (_, event) {
                     
                    },
                    onTap: (_) {
                      setState(() {
                        activateSearch = !activateSearch;
                      });
                    },
                  ),
                ),*/
                UserProfileAvatar()
              ],
              backgroundColor: Color(0xFF00b1a4),
            ),
            body: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (ctx, constraint) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        constraints: constraint,
                        margin: EdgeInsets.only(
                            top: 10, left: 5, right: 5, bottom: 0),
                        width: double.infinity,
                        height: constraint.constrainHeight(550),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.white,
                        ),
                      )
                    ],
                  );
                },
              ),
            ) /*LayoutBuilder(
              builder: (ctx, contrain) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        constraints: contrain,
                        margin: EdgeInsets.only(
                            top: 10, left: 5, right: 5, bottom: 0),
                        width: double.infinity,
                        height: SizeConstraints(context: ctx)
                            .getHeightByPercent(80),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                );
              },
            )*/
            ,
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }
}
