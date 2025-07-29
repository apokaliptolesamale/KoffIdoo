// ignore_for_file: library_private_types_in_public_api, overridden_fields, prefer_function_declarations_over_variables, must_be_immutable

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/config/assets.dart';
import '/app/core/constants/enums.dart';
import '/app/core/helpers/store_short_cuts.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/modules/product/domain/models/role_model.dart';
import '/app/modules/product/domain/usecases/filter_product_usecase.dart';
import '/app/modules/security/domain/models/profile_model.dart';
import '/app/widgets/ext/user_profile_avatar.dart';
import '/app/widgets/layout/card/empty_card.dart';
import '../../../../../app/core/interfaces/app_page.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../../app/core/interfaces/use_case.dart';
import '../../../../../app/modules/product/domain/models/product_model.dart';
import '../../../../../app/modules/product/domain/usecases/get_product_usecase.dart';
import '../../../../../app/modules/product/domain/usecases/list_product_usecase.dart';
import '../../../../../app/modules/product/views/product_detail_view.dart';
import '../../../../../app/widgets/bar/custom_app_bar.dart';
import '../../../../../app/widgets/botton/custom_base_botton.dart';
import '../../../../../app/widgets/botton/custom_bottom_nav_bar.dart';
import '../../../../../app/widgets/field/search_text.dart';
import '../../../../../app/widgets/images/background_image.dart';
import '../../../../../app/widgets/promise/custom_future_builder.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/helpers/extract_failure.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widgets/dialog/custom_dialog.dart';
import '../../../../widgets/event/custom_drag_target.dart';
import '../../../../widgets/field/custom_drop_down.dart';
import '../../../../widgets/panel/custom_item_counter.dart';
import '../../../product/bindings/product_binding.dart';
import '../../../product/controllers/product_controller.dart';

class ProductHomeImpl<T> extends CustomAppPageImpl<T> {
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

  ProductHomeImpl({
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

  static ProductHomeImpl builder({
    String name = "/product/product-info",
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
      ProductHomeImpl(
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
    Routes.getInstance.addRoute("PRODUCT_INFO", name);
    return () => ProductHomeView();
  }
}

class ProductHomeView extends GetResponsiveView<ProductController> {
  late UseCase usecase;
  late CustomFutureBuilder fututeBuilder;
  late String idProduct, idOrder, idOrderService, id;
  //late ProductFrameDetail frame;

  int index = 3;
  bool activateSearch = false;
  SearchText? searchInput;
  late ProductModel product;
  late ProductList<ProductModel> products;
  GlobalViewMode? mode;

  ProductHomeView() {
    Get.lazyPut(() => this);
    id = Get.parameters.containsKey("id") ? Get.parameters["id"] ?? "" : "";
    mode = Get.parameters.containsKey("mode")
        ? ViewMode(Get.parameters["mode"] ?? GlobalViewMode.visible.name).mode
        : GlobalViewMode.visible;
    idProduct = Get.parameters.containsKey("idProduct")
        ? Get.parameters["idProduct"] ?? ""
        : "";
    idOrder = Get.parameters.containsKey("idOrder")
        ? Get.parameters["idOrder"] ?? ""
        : "";
    idOrderService = Get.parameters.containsKey("idOrderService")
        ? Get.parameters["idOrderService"] ?? ""
        : "";
    final mas = ManagerAuthorizationService().get("apiez");
    if (id.isNotEmpty) {
      usecase = GetProductUseCase<ProductModel>(Get.find());
      usecase = usecase.setParamsFromMap({
        "id": id,
        "idProduct": idProduct,
      });
    } else if (idProduct.isNotEmpty) {
      usecase = FilterProductUseCase<ProductModel>(Get.find());
      usecase = usecase.setParamsFromMap(Get.parameters);
    } else {
      usecase = ListProductUseCase<ProductModel>(Get.find());
      Map<String, dynamic> filters = Get.parameters;
      ProfileModel? profileStored = mas!.getUserSession().getBy("profile");
      if (RoleModel.instance.isCliente()) {
        //TODO Si es cliente sólo sus productos
        usecase = FilterProductUseCase<ProductModel>(Get.find());
        if (profileStored != null) {
          filters.putIfAbsent("userName", () => profileStored.userName);
        }
      }
      if (RoleModel.instance.isTransportista()) {
        //TODO Si es cliente sólo sus productos y los productos de las órdenes asignadas a él.
        usecase = FilterProductUseCase<ProductModel>(Get.find());
        if (profileStored != null) {
          filters.putIfAbsent("userName", () => profileStored.userName);
          filters.putIfAbsent("asDelivery", () => "true");
        }
      }
      filters.removeWhere((key, value) =>
          value == null || (value != null && value.toString().isEmpty));
      usecase = usecase.setParamsFromMap(filters);
    }
    log(usecase);
  }

  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  /*@override
  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    mode = Get.parameters.containsKey("mode")
        ? ViewMode(Get.parameters["mode"] ?? GlobalViewMode.visible.name).mode
        : GlobalViewMode.visible;
    if (uc is GetProductUseCase) return getProductInfoBuilder<A>();
    if (uc is FilterProductUseCase) return getProductInfoBuilder<A>();
    return getProductInfoBuilder();
  }*/

  Future<T> getFutureByUseCase<T>(UseCase uc) async {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }

  /*AsyncWidgetBuilder<A> getProductInfoBuilder<A>() {
    var builder = (BuildContext context, AsyncSnapshot<A> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return EmptyDataSearcherResult(
          child: Loading.fromText(
              key: key, text: "Cargando información del producto..."),
        );
      } else if (isDone(snapshot)) {
        final dartz.Right resultData = snapshot.data as dartz.Right;
        final args = Get.arguments != null ? json.decode(Get.arguments) : {};

        log("Argumentos:${args.toString()}");
        final orderPayload = args["orderPayload"];
        final warrantyPayload = args["warrantyPayload"];
        log("Order Payload:$orderPayload");
        if (resultData.value is ProductModel) {
          ProductModel product = resultData.value;
          if (orderPayload != null) {
            product.setOrderPayLoad(orderPayload);
          }
          if (warrantyPayload != null) {
            product.setWarrantyPayLoad(warrantyPayload);
          }
          products = ProductList.fromModels([product]);
        } else if (resultData.value is ProductList<ProductModel>) {
          products = resultData.value;
          for (var element in products.products) {
            if (orderPayload != null) {
              element.setOrderPayLoad(orderPayload);
            }
            if (warrantyPayload != null) {
              element.setWarrantyPayLoad(warrantyPayload);
            }
          }
        }
        return ProductInfoWidget(
          productList: products,
          viewMode: mode = mode ?? GlobalViewMode.visible,
        );
      } else if (isError(snapshot)) {
        return ProductInfoWidget(
          productList: ProductList.fromModels([]),
          viewMode: mode = mode ?? GlobalViewMode.visible,
        );
        /* final fail = FailureExtractor.message(snapshot.data as dartz.Left);
        return Text(fail);*/
      }
      return Loading.fromText(
          key: key, text: "Cargando información de producto...");
    };
    return builder;
  }*/

  /*bool isDone(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
        snapshot.hasData &&
        snapshot.data is dartz.Right;
  }

  bool isError(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data is dartz.Left ||
        snapshot.error != null;
  }*/

  Widget rebuild(BuildContext context, UseCase uc) {
    return ProductInfoWidget(
      uc: uc,
      controller: controller,
    );
  }

  /*Widget rebuild(BuildContext context, UseCase uc) =>
      fututeBuilder = CustomFutureBuilder(
        future: getFutureByUseCase(uc),
        builder: getBuilderByUseCase(uc),
      );*/
}

class ProductInfoWidget extends StatefulWidget {
  final UseCase uc;
  final ProductController controller;
  final GlobalViewMode viewMode;
  ProductInfoWidget({
    Key? key,
    required this.controller,
    required this.uc,
    this.viewMode = GlobalViewMode.visible,
  }) : super(key: key);

  @override
  _ProductInfoViewState createState() => _ProductInfoViewState();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }
}

class _ProductInfoViewState extends State<ProductInfoWidget> {
  int index = 1;
  bool activateSearch = false;
  SearchText? searchInput;
  //List<ProductModel> _products = [];
  late EntityModelList<ProductModel> productList;
  List<ProductModel> _foundProducts = [];
  List<ProductModel> _selectedProducts = [];
  late GlobalViewMode viewMode;

  Color onEnterDropZoneColor = Colors.transparent;

  CustomItemCounter? counter;

  OptionItem? optionItemSelected;

  List<Widget> updateDialogStateWidgets = [];

  CustomDialogBox? updateDialogStateBox;

  String? enteredOrderPin;

  bool pinIsValid = false;

  bool isValid = false;

  bool failded = false;

  Failure? fail;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_DEFAULT_JPG,
        ),
        Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            bottomNavigationBar: CustomBotoonNavBar.fromRoute(
              Get.currentRoute,
              listOfPages: getListOfPages,
            ),
            appBar: CustomAppBar(
              keyStore: "appbar",
              leading: Icon(Icons.menu),
              title: Text('Productos'),
              actions: [
                //Icon(Icons.favorite),
                if (activateSearch) searchInput!,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CustomBaseBotton(
                    icon: Icon(Icons.search),
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
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: CustomDragTarget<ProductModel>(
                        child: Container(
                          margin: EdgeInsets.only(top: 20, bottom: 10),
                          child: Center(
                            child: counter!,
                          ),
                          decoration: BoxDecoration(
                            color: onEnterDropZoneColor,
                            border:
                                Border.all(color: Color(0xFFd7d7d7), width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        onEnter: <CustomBaseBotton>(_, event, btn) {
                          setState(() {
                            onEnterDropZoneColor = Colors.black12;
                          });
                        },
                        onExit: <CustomBaseBotton>(_, event, btn) {
                          setState(() {
                            onEnterDropZoneColor = Colors.transparent;
                          });
                        },
                        onWillAccept: (data) {
                          return data is ProductModel;
                        },
                        onAccept: (data) {
                          _itemDroppedOn(product: data);
                        },
                        onLeave: (data) {
                          setState(() {
                            onEnterDropZoneColor = Colors.transparent;
                          });
                        },
                      ),
                    ),
                    failded ? onFailed() : onLoaded(),
                  ],
                ),
              ),
            ) /* ProductDetailView(
            products: productList.getList(),
            defaultIndex: 0,
            viewMode: viewMode,
          )*/
            )
      ],
    ); /*Scaffold(
      bottomNavigationBar: CustomBotoonNavBar.fromRoute(
        Get.currentRoute,
        listOfPages: getListOfPages,
      ),
      body: ,
    );*/
  }

  void filter(String enteredKeyword) {
    List<ProductModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = productList.getList();
    } else {
      final list = productList.getList();
      results = list
          .where((product) =>
              (product.description ?? product.name)
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              product.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              (product.code != null &&
                  product.code!
                      .toLowerCase()
                      .contains(enteredKeyword.toLowerCase())) ||
              product.categoryName
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              (product.mark != null &&
                  product.mark!
                      .toLowerCase()
                      .contains(enteredKeyword.toLowerCase())) ||
              (product.model != null &&
                  product.model!
                      .toLowerCase()
                      .contains(enteredKeyword.toLowerCase())) ||
              product.idOrder
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundProducts = results;
    });
  }

  @override
  void initState() {
    super.initState();
    viewMode = widget.viewMode;
    activateSearch = failded = false;
    productList = DefaultEntityModelList();
    searchInput = SearchText(
      onChanged: (context, textField, text) {
        filter(text);
      },
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
        hintText: "Buscar productos...",
        //prefixIcon: icon,
        labelStyle: TextStyle(color: Colors.white70),
        hintStyle: TextStyle(color: Colors.white70),
      ),
    );
    counter = CustomItemCounter(
      value:
          _selectedProducts.isEmpty ? "" : _selectedProducts.length.toString(),
      padding: EdgeInsets.only(left: 6, top: 9),
      margin: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
    );
    load();
  }

  Future<T> load<T>() async {
    return widget.getFutureByUseCase(widget.uc).then((result) {
      if (result is dartz.Right && result.value is ProductList) {
        final ProductList list = result.value;
        setState(() {
          productList = list;
          _foundProducts = productList.getList();
          _selectedProducts = [];
          failded = false;
        });
      } else {
        if (result is dartz.Left) {
          setState(() {
            failded = true;
            fail = FailureExtractor.failure(result);
          });
        }
      }
      return result;
    });
  }

  Widget onFailed() {
    return EmptyDataCard(
        text: fail!.getMessage(), // "No hay datos para mostrar.",
        margin: EdgeInsets.only(top: 20),
        onPressed: () {});
  }

  onLoaded() {
    return Expanded(
      child: ProductDetailView(
        products: productList.getList(),
        defaultIndex: 0,
        viewMode: viewMode,
      ),
    );
  }

  void _itemDroppedOn({
    required ProductModel product,
  }) {
    setState(() {
      _foundProducts.removeWhere((element) => product.id == element.id);
      _selectedProducts.add(product);
      counter!.setValue(_selectedProducts.length.toString());
      counter!.start();
    });
  }
}
