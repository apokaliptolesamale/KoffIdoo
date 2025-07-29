// ignore_for_file: library_private_types_in_public_api, prefer_function_declarations_over_variables, must_be_immutable, unnecessary_null_comparison

import 'dart:convert';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../routes/app_routes.dart';
import '/app/core/config/errors/errors.dart';
import '/app/core/helpers/extract_failure.dart';
import '/app/core/helpers/store_short_cuts.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/interfaces/use_case.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/core/services/paths_service.dart';
import '/app/core/services/store_service.dart';
import '/app/core/services/user_session.dart';
import '/app/modules/order/domain/models/order_detail_model.dart';
import '/app/modules/order/domain/usecases/filter_order_usecase.dart';
import '/app/modules/order/domain/usecases/list_order_usecase.dart';
import '/app/modules/prestashop/bindings/orderhistory_binding.dart';
import '/app/modules/prestashop/bindings/status_binding.dart';
import '/app/modules/prestashop/controllers/orderhistory_controller.dart';
import '/app/modules/prestashop/controllers/status_controller.dart';
import '/app/modules/prestashop/service/presta_shop_order_detail_web_service.dart';
import '/app/modules/prestashop/service/presta_shop_web_service_factory.dart';
import '/app/modules/product/bindings/product_binding.dart';
import '/app/modules/product/controllers/product_controller.dart';
import '/app/modules/product/domain/models/role_model.dart';
import '/app/modules/security/domain/models/profile_model.dart';
import '/app/modules/warranty/views/colors.dart';
import '/app/widgets/bar/custom_app_bar.dart';
import '/app/widgets/botton/custom_base_botton.dart';
import '/app/widgets/botton/custom_bottom_nav_bar.dart';
import '/app/widgets/dialog/custom_dialog.dart';
import '/app/widgets/event/custom_drag_target.dart';
import '/app/widgets/ext/user_profile_avatar.dart';
import '/app/widgets/field/custom_drop_down.dart';
import '/app/widgets/field/custom_inputs.dart';
import '/app/widgets/field/search_text.dart';
import '/app/widgets/images/background_image.dart';
import '/app/widgets/layout/card/empty_card.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/panel/custom_item_counter.dart';
import '/app/widgets/patterns/state_machine.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '/app/widgets/utils/loading.dart';
import '/globlal_constants.dart';
import '../../../../core/config/assets.dart';
import '../../../../widgets/components/switch.dart';
import '../../../../widgets/event/event_notification.dart';
import '../../../order/controllers/order_controller.dart';
import '../../../order/domain/models/order_model.dart';

class TransportOrdersInfoPage extends GetResponsiveView<OrderController> {
  late UseCase usecase;
  late CustomFutureBuilder futureBuilder;
  bool remoteLoaded = false;
  TransportOrdersInfoPage() {
    //TODO resolver el problema del seteo de las claves de acceso
    /*PrestaShopWebServiceFactory.create(
            PathsService.prestaShopHost, PathsService.prestaShopKey)
        .load()
        .then((value) {
      value.fold((l) {
        log("Error en la conexión al comercio: ${.toString()}");
      }, (r) {
        log("Se ha establecido la conexión al comercio satisfactoriamente");
      });
    });*/
    dependencies();
    Get.lazyPut(() => this);
    usecase = applyRules(FilterOrderUseCase<OrderModel>(Get.find()));
  }
  UseCase applyRules(UseCase uc) {
    /*int page = Get.parameters.containsKey("page")
        ? int.parse(Get.parameters["page"]!)
        : 0;
    int count = Get.parameters.containsKey("count")
        ? int.parse(Get.parameters["count"]!)
        : 20;*/
    FilterUseCaseOrderParams params = uc.getParams();
    if (RoleModel.instance.isTransportista()) {
      log("Loading for Transportista...");
      params.addStatus([
        "Listo para entregar",
        "Transportándose",
      ]);
      uc.setParams(params);
    } else if (RoleModel.instance.isDependiente()) {
      log("Loading for Dependiente...");
      params.addStatus([
        "Listo para entregar",
        "Listo para recoger",
        "Preparándose",
        "Transportándose",
        "Entregado a Transportista",
        "Reembolso",
        "Pago aceptado",
      ]);
      uc.setParams(params);
    } else if (RoleModel.instance.isCliente()) {
      log("Loading for Cliente...");
      final service = ManagerAuthorizationService().get(defaultIdpKey);
      UserSession? usession = service?.getUserSession();
      ProfileModel? profile = usession?.getBy<ProfileModel>(
        "profile",
        converter: (data, key) {
          return ProfileModel.converter(data, key);
        },
      );
      params.setUserName(profile != null ? profile.userName : "-");
      uc.setParams(params);
    } else if (RoleModel.instance.isAdministrador()) {
      log("Loading for Dependiente or Administrator...");
      params.addStatus([
        "Listo para entregar",
        "Listo para recoger",
        "Preparándose",
        "Transportándose",
        "Entregado a Transportista",
        "Reembolso",
        "Pago aceptado",
      ]);
      uc.setParams(params);
    }
    log("Params===>${params.toJson()}");
    return uc;
    //ListOrderUseCase<OrderModel>(Get.find());
  }

  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  Widget createErrorPage(
      BuildContext context, Widget body, PreferredSizeWidget? appBar) {
    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: CustomBotoonNavBar.fromRoute(
            Get.currentRoute,
            listOfPages: getListOfPages,
          ),
          appBar: appBar,
          body: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(color: Colors.teal),
            ),
            child: SafeArea(
              minimum: EdgeInsets.only(top: 30),
              child: body,
            ),
          ),
        )
      ],
    );
  }

  Widget createPage(
      BuildContext context, Widget body, PreferredSizeWidget? appBar) {
    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
        ),
        Scaffold(
          //resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: CustomBotoonNavBar.fromRoute(
            Get.currentRoute,
            listOfPages: getListOfPages,
          ),
          appBar: appBar,
          body: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(color: Colors.teal),
            ),
            child: SafeArea(
              minimum: EdgeInsets.only(top: 30),
              child: body,
            ),
          ),
        )
      ],
    );
  }

  createWidgetFromOrders(ProfileModel? profile, {Widget? child}) {
    remoteLoaded = false;
    final avatarUrl = (remoteLoaded =
            (profile != null && profile.userName.isNotEmpty))
        ? "${PathsService.mediaHost}images/user/avatar/${profile!.userName}.png"
        : Assets.ASSETS_IMAGES_ICONS_APP_CUENTA_PNG.getPath;
    bool isValid = profile != null;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20, bottom: 30),
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
              )*/
              ,
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

  dependencies() {
    log("Iniciando dependencias externas...");
    OrderHistoryBinding();
    StatusBinding();
    ProductBinding();
  }

  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    if (uc is ListOrderUseCase) return getListOrdersBuilder<A>();
    return getListOrdersBuilder();
  }

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }

  AsyncWidgetBuilder<A> getListOrdersBuilder<A>() {
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
      EntityModelList<OrderModel> orderList = DefaultEntityModelList();
      Widget? result;
      Widget? child;
      SearchText searchInput = SearchText(
        onChanged: (context, textField, text) {
          //filter(text);
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
          hintText: "Buscar órdenes...",
          //prefixIcon: icon,
          labelStyle: TextStyle(color: Colors.white70),
          hintStyle: TextStyle(color: Colors.white70),
        ),
      );
      PreferredSizeWidget appbar = CustomAppBar(
        leading: Icon(Icons.menu),
        keyStore: "appBar",
        title: Text(RoleModel.instance.isCliente() ? 'Pedidos' : 'Órdenes'),
        actions: [
          //Icon(Icons.favorite),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SwithcWidget(
              primary: CustomBaseBotton(
                hitTestBehavior: HitTestBehavior.translucent,
                icon: Icon(Icons.search),
                onHover: <T>(_, event, btn) {
                  /*setState(() {
                        activateSearch = true;
                      });*/
                },
                onExit: <T>(_, event, btn) {
                  /*setState(() {
                        activateSearch = false;
                      });*/
                },
                onTap: <T>(_, btn) {
                  /* setState(() {
                    activateSearch = !activateSearch;
                  });*/
                  final cbtn = (btn as CustomBaseBotton);
                  final container = (cbtn.container as SwithcWidget);
                  container.toggle();
                },
              ),
              secundary: searchInput,
              isToggled: false,
            ),
          ),
          UserProfileAvatar(),
        ],
        backgroundColor: Color(0xFF00b1a4),
      );
      final loadingSms = RoleModel.instance.isCliente()
          ? "Cargando pedidos..."
          : "Cargando órdenes...";
      if (snapshot.connectionState == ConnectionState.waiting) {
        result = EmptyDataSearcherResult(
          child: Loading.fromText(key: key, text: loadingSms),
        );
      }
      if (isDone(snapshot)) {
        final dartz.Right resultData = snapshot.data as dartz.Right;
        orderList = resultData.value;
        EventStatus eventStatus = EventStatus.of(context);
        eventStatus.fire(orderList);
        remoteLoaded = true;
        if (!isValid) {
          child = EmptyDataCard(
              text: "No se inició correctamente el perfil del usuario.",
              margin: EdgeInsets.only(top: 20),
              onPressed: () {});
        }
        if (isValid && orderList.getList().isEmpty) {
          child = EmptyDataCard(
              text: "No hay datos para mostrar.",
              margin: EdgeInsets.only(top: 20),
              onPressed: () {});
        }
        if (isValid && orderList.getTotal > 0) {
          child = TransportOrdersInfoView(
            controller: controller,
            uc: usecase,
          );
        }
        result = createPage(
          context,
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20, bottom: 30),
              child: Column(
                children: <Widget>[
                  child!,
                ],
              ),
            ),
          ),
          appbar,
        );
      } else if (isError(snapshot) && snapshot.data is dartz.Left) {
        final data = snapshot.data as dartz.Left;
        final fail = FailureExtractor.failure(data);

        child = EmptyDataCard(
            text: fail.getMessage(), // "No hay datos para mostrar.",
            margin: EdgeInsets.only(top: 20),
            onPressed: () {});

        result = createPage(
          context,
          createWidgetFromOrders(
            profile,
            child: child,
          ),
          appbar,
        );
      }
      return result ?? Loading.fromText(key: key, text: loadingSms);
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

  Widget rebuild(BuildContext context, UseCase uc) {
    return TransportOrdersInfoView(
      uc: uc,
      controller: controller,
    );
  }

  Future<void> syncProducts(EntityModelList<OrderModel> orderList) async {
    orderList.getList().forEach((element) async {
      final idOrder = element.id;
      log("Cargando detalles de orden.");
      final order = await OrderController().getOrder.setParamsFromMap({
        "id": idOrder,
      }).call(null);
      if (order != null) {
        order.fold((l) => null, (orderModel) async {
          final orderDetail =
              await PrestaShopOrderDetailWebService.getOrderDetails(
            PrestaShopWebServiceFactory.instance.getActiveWebService!.getApi,
            orderModel.idOrder,
          );
          List<OrderDetailModel> detailsList = [];
          for (var element in orderDetail) {
            log("Datos de detalles de la orden");

            final orderD = OrderDetailModel.fromJson({
              "idOrderDetail": element.idOrderDetail.toString(),
              "product": {
                "idProduct": element.idProduct.toString(),
                "idOrder": element.idOrder.toString(),
                "name": element.productName,
                "mark": "",
                "model": "",
                "price": element.productPrice,
                "code": "",
                "productQuantity": element.productQuantity
              }
            });
            /*if (orderD.product.idOrder == null) {
              info("Testing órden:\n${orderD.toJson()}");
            }*/
            detailsList.add(orderD);
          }
          orderModel.orderDetail =
              OrderDetailList<OrderDetailModel>(orderDetail: detailsList);
          orderModel.driver = "prestashop";
          //log(orderDetail.toJson());
          final orderUpdated =
              await OrderController().updateOrder.setParamsFromMap({
            "id": orderModel.id,
            "entity": orderModel,
          }).call(null);

          orderUpdated.fold((error) {
            log("Orden no actualizada.");
            log(error);
          }, (model) {
            model.orderDetail = orderModel.orderDetail;
            log("Orden ${model.id} actualizada.");
            model.orderDetail.getList().forEach((element) async {
              element.product.idOrderService = model.id;
              /*if (element.product.idOrder == null) {
                info(
                    "Salvando productos de la orden ${model.idOrder}. Producto:\n${element.product.toJson()}");
              }*/
              log("Imagen del producto======>${element.product.toJson()}");
              final productCreated = await ProductController()
                  .addProduct
                  .setParamsFromMap(element.product.toJson())
                  .call(null);
              productCreated.fold((l) {
                log("Producto no creado. ${l.toString()}");
              }, (producto) {
                log("Producto  de la orden ${element.product} ${producto.idOrder} creado satisfactoriamente.");
              });
            });
          });
        });
      }
    });
  }
}

class TransportOrdersInfoView extends StatefulWidget {
  final UseCase uc;
  final OrderController controller;
  const TransportOrdersInfoView({
    Key? key,
    required this.controller,
    required this.uc,
  }) : super(key: key);

  @override
  _TransportOrdersInfoViewState createState() =>
      _TransportOrdersInfoViewState();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }
}

class _TransportOrdersInfoViewState extends State<TransportOrdersInfoView> {
  bool activateSearch = false;
  SearchText? searchInput;
  late EntityModelList<OrderModel> orderList;
  List<OrderModel> _foundOrders = [];
  List<OrderModel> _selectedOrders = [];

  Color onEnterDropZoneColor = Colors.transparent;

  CustomItemCounter? counter;

  OptionItem? optionItemSelected;

  List<Widget> updateDialogStateWidgets = [];

  CustomDialogBox? updateDialogStateBox;

  String? enteredOrderPin;

  bool pinIsValid = false;

  bool isValid = false;

  bool failded = false;

  bool isLoading = false;

  Failure? fail;

  @override
  Widget build(BuildContext context) {
    // final constraint = SizeConstraints(context: context);
    enteredOrderPin = null;
    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
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
            title: Text(RoleModel.instance.isCliente() ? 'Pedidos' : 'Órdenes'),
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: CustomDragTarget<OrderModel>(
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
                        return data is OrderModel;
                      },
                      onAccept: (data) {
                        _itemDroppedOn(order: data);
                      },
                      onLeave: (data) {
                        setState(() {
                          onEnterDropZoneColor = Colors.transparent;
                        });
                      },
                    ),
                  ),
                  isLoading ? onLoading() : (failded ? onFailed() : onLoaded()),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void filter(String enteredKeyword) {
    List<OrderModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = orderList.getList();
    } else {
      final list = orderList.getList();
      results = list
          .where((user) =>
              user.address
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user.idOrder
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user.status.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      log("Orders founds:${results.map((e) => e.toJson()).toString()}");
      _foundOrders = results;
    });
  }

  Widget getAcceptBotton(Function() handler) {
    return Container(
      height: 40,
      width: 250,
      margin: EdgeInsets.only(top: 100),
      child: MaterialButton(
        onPressed: () {
          //log("pinIsValid=$pinIsValid y isValid=$isValid");
          if (pinIsValid || isValid) {
            handler();
          } else {}
        },
        shape: StadiumBorder(),
        color: aceptBottonColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3.0,
            //horizontal: 24.0,
          ),
          child: Text(
            "Aceptar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  CustomDialogBox getCustomDialogBoxInstance({
    Key? key,
    required BuildContext context,
    required String title,
    required String description,
    required List<Widget> actions,
    required Image logo,
    Widget? content,
  }) {
    return updateDialogStateBox = updateDialogStateBox != null
        ? updateDialogStateBox!.show()
        : CustomDialogBox(
            context: context,
            title: "Actualizar estado de la orden",
            description: description,
            content: Column(
              children: updateDialogStateWidgets,
            ),
            actions: actions,
            logo: Image.asset(ASSETS_IMAGES_LOGOS_WARRANTY_WARRANTY_LOGO_PNG),
          ).show();
  }

  getWidgetByState(CustomState<String>? state, OrderModel order) {
    pinIsValid = isValid = false;
    if (state == null) {
      return Container();
    }

    final toCloseOrderWidget = CustomStyledInput(
      hintText: "Introduzca el PIN de la orden",
      icon: Icon(
        Icons.pin,
        color: Color(0xFF00b1a4),
      ),
      listeners: [
        (input) {
          enteredOrderPin = input.getValue;

          if (enteredOrderPin != null &&
              order.pin.toString().toLowerCase() ==
                  enteredOrderPin!.toLowerCase()) {
            pinIsValid = true;
          }
          log("Pin válido para cerrar la orden=$pinIsValid");
        }
      ],
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.min(6),
        //FormBuilderValidators.numeric(),
        if (order.pin != null) FormBuilderValidators.match(order.pin!),
      ]),
    );

    switch (state.value) {
      case "Entregado":
        isValid = true;
        return toCloseOrderWidget;
      case "Entregado domicilio":
        isValid = true;
        return toCloseOrderWidget;
      case "Listo para entregar":
        isValid = true;
        return Container(
          color: Colors.transparent,
          height: 20,
        );
      case "Pago aceptado":
        isValid = true;
        return Container(
          color: Colors.transparent,
          height: 20,
        );
      case "Entregado a Transportista":
        isValid = true;
        return Container(
          color: Colors.transparent,
          height: 20,
        );

      case "Transportándose":
        isValid = true;
        return Container(
          color: Colors.transparent,
          height: 20,
        );
      case "Preparándose":
        isValid = true;
        return Container(
          color: Colors.transparent,
          height: 20,
        );
      case "Listo para recoger":
        isValid = true;
        return Container(
          color: Colors.transparent,
          height: 20,
        );
      case "Reembolso":
        isValid = true;
        return Container(
          color: Colors.transparent,
          height: 20,
        );
    }
    return Container(
      color: Colors.transparent,
      height: 20,
    );
  }

  @override
  initState() {
    super.initState();
    isLoading = false;
    activateSearch = failded = false;
    orderList = DefaultEntityModelList();
    _foundOrders = orderList.getList();
    _selectedOrders = [];
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
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
          width: 1.0,
        )),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        hintText: "Buscar órdenes...",
        //prefixIcon: icon,
        labelStyle: TextStyle(color: Colors.white70),
        hintStyle: TextStyle(color: Colors.white70),
      ),
    );

    counter = CustomItemCounter(
      value: _selectedOrders.isEmpty ? "" : _selectedOrders.length.toString(),
      padding: EdgeInsets.only(left: 6, top: 9),
      margin: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
    );
    load();
  }

  Future<T> load<T>() async {
    if (isLoading) {
      return Future.value(null);
    }
    setState(() {
      isLoading = true;
    });
    return widget.getFutureByUseCase(widget.uc).then((result) {
      if (result is dartz.Right && result.value is OrderList) {
        final OrderList list = result.value;
        setState(() {
          isLoading = false;
          orderList = list;
          _foundOrders = orderList.getList();
          _selectedOrders = [];
          failded = false;
        });
      } else {
        if (result is dartz.Left) {
          setState(() {
            isLoading = false;
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

  Widget onLoaded() {
    return _foundOrders.isEmpty
        ? EmptyDataCard(
            text: "No hay datos para mostrar.",
            margin: EdgeInsets.only(top: 20),
            onPressed: () {})
        : Expanded(
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 20,
                  );
                },
                itemCount: _foundOrders.length,
                itemBuilder: (_, i) {
                  final order = _foundOrders.elementAt(i);
                  //log("Datos de la orden:\n${order.toJson()}");

                  return Draggable<OrderModel>(
                    childWhenDragging: Container(),
                    data: order,
                    feedback: Container(
                      height: 120.0,
                      width: 120.0,
                      child: Center(
                        child: Icon(
                          Icons.shopping_bag,
                          color: Color(0xFF00b1a4),
                        ),
                      ),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFf4f4f4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        final encoded = json.encode(order.toJson());
                        StoreService()
                            .createStore("order")
                            .add("selectedOrder", encoded);
                        //credential
                        String? merchantUrl = order.merchantUrl;
                        String credential = await order.getUncypherCredential();
                        if (merchantUrl != null && credential.isNotEmpty) {
                          final conect =
                              await PrestaShopWebServiceFactory.create(
                            merchantUrl, //PathsService.prestaShopHost,
                            credential, //PathsService.prestaShopKey,
                          ).load();
                          conect.fold((l) {
                            //TODO mostrar error de conexión con la tienda/merchant de la orden
                          }, (r) {
                            //TODO aquí hacer lo que se debe si hay conexión con la tienda/merchant
                          });
                        }
                        Get.toNamed(Routes.getInstance.getPath("ORDER_INFO"),
                            parameters: {
                              "id": order.id,
                              "idOrder": order.idOrder,
                            });
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
                                  child: Icon(
                                    Icons.shopping_bag,
                                    color: Color(0xFF00b1a4),
                                  )),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    order.idOrder,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      order.address,
                                      overflow: TextOverflow.visible,
                                      style: GoogleFonts.roboto(
                                        fontSize:
                                            12, // constraint.getWidthByPercent(2),
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                      //textScaleFactor: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      //code for change status widget

                                      final acceptBtn =
                                          getAcceptBotton(() async {
                                        final ctlOrderHistory =
                                            Get.find<OrderHistoryController>();

                                        final ctlOrderStatus =
                                            StatusController();
                                        if (order.merchantUrl != null) {
                                          String credential = await order
                                              .getUncypherCredential();
                                          PrestaShopWebServiceFactory.create(
                                            order.merchantUrl!,
                                            credential,
                                          );
                                        }
                                        final state = await ctlOrderStatus
                                            .getStateByField(
                                          "name",
                                          optionItemSelected!.title,
                                        );

                                        if (enteredOrderPin != null &&
                                            !pinIsValid) {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Error'),
                                                content: SingleChildScrollView(
                                                  child: Text(
                                                      "El PIN que ha introducido es incorrecto, vuelva a intentarlo."),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Cerrar'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else if (optionItemSelected != null) {
                                          state.fold((l) {
                                            log("Error al intentar cargar el estado seleccionado. Función 'getStateByField'");
                                          }, (stateList) {
                                            if (stateList
                                                .getList()
                                                .isNotEmpty) {
                                              ctlOrderHistory.addOrderHistory
                                                  .setParamsFromMap({
                                                    "entity": {
                                                      "idEmployee": 0,
                                                      "idOrder": order.idOrder,
                                                      "idOrderState": stateList
                                                          .getList()
                                                          .first
                                                          .id
                                                    }
                                                  })
                                                  .call(null)
                                                  .then((response) {
                                                    response.fold((error) {
                                                      log(error.message);
                                                    }, (orderHistory) {
                                                      //TODO implementar notificación en el AppBar y actualizar la orden en el listado
                                                      Navigator.of(context)
                                                          .pop();

                                                      //TODO Send sms and update order state on microservice.

                                                      /*final ctlOrder =
                                                                  Get.find<
                                                                      OrderController>();
                                                              order.status =
                                                                  optionItemSelected!
                                                                      .title;
                                                              ctlOrder
                                                                  .updateOrder
                                                                  .setParamsFromMap({
                                                                    "id": order
                                                                        .id,
                                                                    "entity": order
                                                                        .toJson()
                                                                  })
                                                                  .call(null)
                                                                  .then(
                                                                      (orderResponse) {
                                                                    orderResponse
                                                                        .fold(
                                                                            (error) {
                                                                      log(error
                                                                          .message);
                                                                    }, (orderUpdated) {
                                                                      //TODO implementar módulo de notificación
                                                                      final sms =
                                                                          "La orden No. ${order.idOrder} ha sido actualizada al estado: '${order.status}'.";
                                                                      log(sms);
                                                                      notify.Notification
                                                                          .fromJson({
                                                                        "message":
                                                                            sms,
                                                                        "phone":
                                                                            [
                                                                          "52155289",
                                                                          "59983703"
                                                                        ]
                                                                      }).send();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    });
                                                                  });*/
                                                    });
                                                  });
                                            }
                                          });
                                        }
                                      });
                                      final description =
                                          "La orden está en estado: ${order.status}.\n Usted solamente podrá actualizar el estado de la orden actual a los valores siguientes:";
                                      CustomStateMachine<String,
                                              CustomState<String>> machine =
                                          CustomStateMachine.loadStateMachine(
                                        startOnValue: order.status,
                                      );

                                      final targets =
                                          machine.targetStatesValues(
                                        searchValue: order.status,
                                      );

                                      List<OptionItem> items = [];
                                      int count = 1;
                                      targets.map((String value) {
                                        items.add(OptionItem(
                                          id: count++,
                                          title: value,
                                        ));
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList();

                                      CustomDropListModel dropListModel =
                                          CustomDropListModel(items);

                                      /*optionItemSelected =
                                                OptionItem(
                                              id: items.isNotEmpty
                                                  ? items.elementAt(0).id
                                                  : null,
                                              title: items.isNotEmpty
                                                  ? items.elementAt(0).title
                                                  : "Sin valor",
                                            );*/

                                      final list = SelectDropList(
                                        name: "",
                                        focus: FocusNode(),
                                        storeKey: "warranty",
                                        dropListModel: dropListModel,
                                        itemSelected: optionItemSelected,
                                        textController: TextEditingController(
                                            text: optionItemSelected != null
                                                ? optionItemSelected!.title
                                                : ""),
                                        icon: Icon(
                                          Icons.shopping_bag,
                                          color: Color(0xFF00b1a4),
                                        ),
                                        onOptionSelected:
                                            (objectList, optionItem) {
                                          optionItemSelected = optionItem;
                                          final state = machine.getByValue(
                                              machine.start,
                                              optionItemSelected!.title);

                                          /*setState(() {
                                                  updateDialogStateWidgets = [
                                                    objectList,
                                                    getWidgetByState(state)
                                                  ];
                                                });*/
                                          log(state!.value);
                                          updateDialogStateBox!
                                              .setContent(Column(
                                            children:
                                                updateDialogStateWidgets = [
                                              objectList,
                                              getWidgetByState(state, order)
                                            ],
                                          ));
                                        },
                                      );
                                      updateDialogStateWidgets = [list];
                                      getCustomDialogBoxInstance(
                                        context: context,
                                        title: "Actualizar estado de la orden",
                                        description: description,
                                        content: Column(
                                          children: updateDialogStateWidgets,
                                        ),
                                        actions: [
                                          acceptBtn,
                                        ],
                                        logo: Image.asset(
                                            ASSETS_IMAGES_LOGOS_WARRANTY_WARRANTY_LOGO_PNG),
                                      );
                                    },
                                    icon: Icon(Icons.edit_attributes),
                                    color: const Color(0xFF00b1a4),
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      Get.toNamed(
                                          Routes.getInstance.getPath("QR_INFO"),
                                          parameters: {
                                            "idOrder": order.id,
                                          });
                                    },
                                    icon: Icon(Icons.qr_code),
                                    color: const Color(0xFF00b1a4),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
  }

  Widget onLoading() {
    return EmptyDataSearcherResult(
      child: Loading.fromText(text: "Cargando listado de órdenes..."),
    ); /*ClockLoading(
      textLoading: Text("Cargando listado de órdenes..."),
    );*/
  }

  void _itemDroppedOn({
    required OrderModel order,
  }) {
    setState(() {
      _foundOrders.removeWhere((element) => order.id == element.id);
      _selectedOrders.add(order);
      counter!.setValue(_selectedOrders.length.toString());
      counter!.start();
    });
  }
}
