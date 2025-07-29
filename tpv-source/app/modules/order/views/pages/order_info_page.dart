// ignore_for_file: library_private_types_in_public_api, overridden_fields, must_be_immutable, prefer_function_declarations_over_variables

import 'dart:convert';

import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/app/core/helpers/extract_failure.dart';
import '/app/core/helpers/store_short_cuts.dart';
import '/app/core/interfaces/app_page.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/interfaces/use_case.dart';
import '/app/core/services/paths_service.dart';
import '/app/core/services/store_service.dart';
import '/app/modules/order/bindings/order_binding.dart';
import '/app/modules/product/domain/models/product_model.dart';
import '/app/modules/product/domain/usecases/filter_product_usecase.dart';
import '/app/modules/security/domain/models/profile_model.dart';
import '/app/modules/warranty/bindings/warranty_binding.dart';
import '/app/modules/warranty/controllers/warranty_controller.dart';
import '/app/widgets/bar/custom_app_bar.dart';
import '/app/widgets/botton/custom_base_botton.dart';
import '/app/widgets/botton/custom_bottom_nav_bar.dart';
import '/app/widgets/ext/user_profile_avatar.dart';
import '/app/widgets/field/search_text.dart';
import '/app/widgets/images/background_image.dart';
import '/app/widgets/images/custom_image_source.dart';
import '/app/widgets/layout/card/empty_card.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '../../../../core/config/assets.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widgets/dialog/custom_dialog.dart';
import '../../../../widgets/event/custom_drag_target.dart';
import '../../../../widgets/field/custom_drop_down.dart';
import '../../../../widgets/panel/custom_item_counter.dart';
import '../../../product/bindings/product_binding.dart';
import '../../../product/controllers/product_controller.dart';
import '../../controllers/order_controller.dart';

class OrderInfoPage extends GetResponsiveView<ProductController> {
  late UseCase usecase;
  late CustomFutureBuilder fututeBuilder;
  late String idOrder, id;
  bool remoteLoaded = false;
  OrderInfoPage() {
    OrderBinding();
    idOrder = Get.parameters.containsKey("idOrder")
        ? Get.parameters["idOrder"] ?? ""
        : "";
    id = Get.parameters.containsKey("id") ? Get.parameters["id"] ?? "" : "";
    usecase = FilterProductUseCase<ProductModel>(Get.find());
    if (idOrder.isNotEmpty) {
      usecase = usecase.setParamsFromMap({
        "idOrderService": id,
        "idOrder": idOrder,
      });
    }

    Get.parameters.clear();
    Get.lazyPut(() => this);
  }
  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  Widget createPage(BuildContext context, Widget body) {
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
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back),
            ),
            title: Text('Mis productos'),
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

  createWidgetFromProducts(ProfileModel? profile, {Widget? child}) {
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
            SizedBox(
              height: 20,
              width: double.infinity,
              child: Divider(
                color: Colors.white,
              ),
            ),
            if (child != null) child,
          ],
        ),
      ),
    );
  }

  Future<T> getFutureByUseCase<T>(UseCase uc) async {
    final result = await controller.getFutureByUseCase<T>(uc);
    return result;
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
        snapshot.hasError;
  }

  Widget rebuild(BuildContext context, UseCase uc) =>
      OrderInfoView(controller: controller, uc: uc);
}

class OrderInfoPageImpl<T> extends CustomAppPageImpl<T> {
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

  OrderInfoPageImpl({
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

  static OrderInfoPageImpl builder({
    String name = "/order/order-info",
    String keyMap = "ORDER_INFO",
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
      OrderInfoPageImpl(
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
        binding: binding ?? ProductBinding(),
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
    return () => OrderInfoPage();
  }
}

class OrderInfoView extends StatefulWidget {
  final UseCase uc;
  final ProductController controller;
  final GlobalViewMode viewMode;

  OrderInfoView({
    Key? key,
    required this.controller,
    required this.uc,
    this.viewMode = GlobalViewMode.visible,
  }) : super(key: key);

  @override
  _OrderInfoViewState createState() => _OrderInfoViewState();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }
}

class _OrderInfoViewState extends State<OrderInfoView> {
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

  //late FrameCallback _callback;

  bool failded = false;

  Failure? fail;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //final sizeConstraint = SizeConstraints(context: context);

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
              UserProfileAvatar(),
            ],
            backgroundColor: Color(0xFF00b1a4),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 50),
                  height: 80,
                  width: 80,
                  child: CustomDragTarget<ProductModel>(
                    child: Container(
                      height: 80,
                      width: 100,
                      // margin: EdgeInsets.only(top: 20, bottom: 10),
                      child: Center(
                        child: counter!,
                      ),
                      decoration: BoxDecoration(
                        color: onEnterDropZoneColor,
                        border: Border.all(color: Color(0xFFd7d7d7), width: 2),
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
        )
      ],
    );
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
    isLoading = false;
    activateSearch = false;
    productList = DefaultEntityModelList();
    _foundProducts = productList.getList();
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

  Future load<T>() async {
    if (isLoading) return Future(() => null);
    setState(() {
      isLoading = true;
    });
    return widget.getFutureByUseCase(widget.uc).then((result) {
      if (result is dart.Right && result.value is ProductList) {
        final ProductList list = result.value;
        setState(() {
          productList = list;
          _foundProducts = productList.getList();
          _selectedProducts = [];
          failded = false;
          isLoading = false;
        });
      } else {
        if (result is dart.Left) {
          setState(() {
            failded = true;
            fail = FailureExtractor.failure(result);
            isLoading = false;
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
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 20,
          );
        },
        itemCount: _foundProducts.length,
        itemBuilder: (_, i) {
          final ProductModel product = _foundProducts.elementAt(i);
          final store = StoreService().getStore("order");
          final future = Future.value(store.get("selectedOrder", ""));
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFf4f4f4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final params = {
                  "idProduct": product.idProduct,
                  "idOrder": product.idOrder,
                  "idOrderService": product.idOrderService,
                };
                var orderPayload = await future;
                if (orderPayload is Map) {
                  product.setOrderPayLoad(orderPayload
                      .map((key, value) => MapEntry(key.toString(), value)));
                } else {
                  if (product.getOrderPayLoad.isEmpty) {
                    final ctl = Get.find<OrderController>();
                    final orderPayload = await ctl.getOrder.setParamsFromMap({
                      "id": product.idOrderService,
                    }).call(null);
                    orderPayload.fold((l) => null, (order) {
                      product.setOrderPayLoad(order.toJson());
                      store.set("selectedOrder", order.toJson());
                    });
                  }
                }
                if (product.idWarranty.isNotEmpty) {
                  WarrantyBinding().dependencies();
                  final ctr = Get.find<WarrantyController>();
                  final warrantyPayload =
                      await ctr.getWarranty.setParamsFromMap({
                    "id": product.idWarranty,
                  }).call(null);
                  warrantyPayload.fold((l) => null, (model) {
                    product.setWarrantyPayLoad(model.toJson());
                  });
                }
                final args = json.encode({
                  "mode": "visible",
                  "orderPayload": product.getOrderPayLoad
                      .map((key, value) => MapEntry(key, value)),
                  "warrantyPayload": product.getWarrantyPayLoad
                      .map((key, value) => MapEntry(key, value))
                });

                Get.toNamed(
                  Routes.getInstance.getPath("PRODUCT_INFO"),
                  parameters: params,
                  arguments: args,
                );
              },
              child: Container(
                color: Color(0xFFf4f4f4),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: product.images.isEmpty
                            ? Image(
                                image: AssetImage(
                                  ASSETS_IMAGES_ICONS_APP_IC_PRODUCTO_PNG,
                                ),
                                height: 60,
                              )
                            : CustomImageResource(
                                url: product.images.elementAt(0).imageURL,
                                context: context,
                              ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 1, left: 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.getInstance.getPath("QR_INFO"),
                              parameters: {
                                "title": "Qr de la orden",
                                "idProduct": product.idProduct,
                                "idOrder": product.idOrder,
                                "idOrderService": product.idOrderService
                              });
                        },
                        icon: Icon(Icons.qr_code),
                        color: const Color(0xFF00b1a4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          /*return CustomFutureBuilder(
            future: future,
            builder: (ctx, snapshot) {
              if (isDone(snapshot)) {
                product.setOrderPayLoad(
                    snapshot.data != null && snapshot.data is Map
                        ? json.decode(snapshot.data!.toString())
                        : {});
                if (product.idWarranty.isNotEmpty) {
                  WarrantyBinding().dependencies();
                  final ctr = Get.find<WarrantyController>();
                  ctr.getWarranty
                      .setParamsFromMap({
                        "id": product.idWarranty,
                      })
                      .call(null)
                      .then((value) {
                        value.fold((l) => {}, (model) {
                          product.setWarrantyPayLoad(model.toJson());
                        });
                      });
                }
                
              }
              return Loading.fromText();
            },
          );*/
        },
      ),
    ); /*SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.start,
        child:  LayoutBuilder(
        builder: (ctx, constraint) {
          Size size = MediaQuery.of(context).size;
          final constraint = SizeConstraints(context: context);
          return Column(
            children: [
              //WarrantyLogo(),
              Container(
                margin: EdgeInsets.all(10),
                color: Colors.transparent,
                height: constraint.getHeightByPercent(90),
                child: ,
              ),
            ],
          );
        },
      ),
        );*/
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
