import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/app/core/services/logger_service.dart';
import '/app/modules/transaction/controllers/invoice_controller.dart';
import '/app/modules/transaction/payment_exporting.dart';
import '/app/widgets/field/custom_get_view.dart';
import '../../../core/config/errors/errors.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/dataview/facturas_mensuales.dart';
import '../../../widgets/dataview/option_widget.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../controllers/clientinvoice_controller.dart';
import '../domain/models/etecsa_invoice_model.dart' as etecsa;

class EtecsaServiceView extends CustomView<InvoiceController> {
  // late UseCase useCase;
  // late CustomFutureBuilder customFutureBuilder;
  // late InvoiceModel invoiceModel;
  // late InvoiceList<InvoiceModel> invoices;
  // late String limit, start, startDate, endDate;
  // late bool getall;
  // GlobalViewMode? mode;

  EtecsaServiceView(/*{
  Key? key,
  required this.transactionList}*/
      ) {
    // Get.lazyPut(() => this);
    // limit = Get.parameters.containsKey("limit")
    //     ? Get.parameters["limit"] ?? ""
    //     : "10";
    // start = Get.parameters.containsKey("start")
    //     ? Get.parameters["limit"] ?? ""
    //     : "0";
    // useCase = ListInvoiceUseCase<InvoiceModel>(Get.find());
    // if (startDate != "" || endDate != "") {
    //   useCase = FilterInvoiceUseCase<InvoiceModel>(Get.find());
    //   useCase = useCase.setParamsFromMap(Get.parameters);
    // }
    // log(useCase);
  }

  @override
  Widget build(BuildContext context) {
    return EtecsaServiceWidget();
    // rebuild(context, useCase);
  }
}

class EtecsaServiceWidget extends GetView<ClientInvoiceController> {
  // InvoiceList invoices;
  EtecsaServiceWidget({
    Key? key,
    // required this.invoices,
  }) : super(key: key);

  String? mensajeError = "";
  // ClientInvoiceController controller = Get.find<ClientInvoiceController>();
  List<etecsa.Datum>? list;
  List<etecsa.Datum>? listTelFijo = [];
  List<etecsa.Datum>? listTelMin = [];
  List<etecsa.Datum>? listCuentaNauta = [];
  List<etecsa.Datum>? listNautaHogar = [];
  List<etecsa.Datum>? listTargPropia = [];

  Future<dartz.Either<Failure, etecsa.EtecsaModel>> buscarFacturas() async {
    Map<String, dynamic> params = {
      // "client_id": "0111411728070904",
      "service_code": "444"
    };

    controller.getFactMensualEtecsaUseCase.setParamsFromMap(params);
    return await controller
        .getFutureByUseCase(controller.getFactMensualEtecsaUseCase);
  }

  List<bool> expansionPanelExpanded = [false, false, false];

  // final TabController? tabController = TabController(length: tabBar.length, vsync: true);

  final tabBar = <Tab>[
    Tab(
      text: "Teléfono Fijo",
    ),
    Tab(
      text: "Teléfono de Minutos",
    ),
    Tab(
      text: "Cuenta Nauta",
    ),
    Tab(
      text: "Nauta Hogar",
    ),
    Tab(
      text: "Tarjeta Propia",
    ),
  ];

  // List<ExpansionPanel> expansionPanelItems = list;
  // [
  //   ExpansionPanel(
  //     headerBuilder: (BuildContext context, bool isExpanded) {
  //       return ListTile(
  //         title: Text('Título del panel 1'),
  //       );
  //     },
  //     body: Container(
  //       height: 150,
  //       width: 300,
  //       padding: EdgeInsets.all(16.0),
  //       child: Text('Contenido del panel 1'),
  //     ),
  //     isExpanded: false,
  //   ),
  //   ExpansionPanel(
  //     headerBuilder: (BuildContext context, bool isExpanded) {
  //       return ListTile(
  //         title: Text('Título del panel 2'),
  //       );
  //     },
  //     body: Container(
  //       height: 150,
  //       width: 300,
  //       padding: EdgeInsets.all(16.0),
  //       child: Text('Contenido del panel 2'),
  //     ),
  //     isExpanded: false,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<PaymentController>(() => PaymentController());
    /*FloatingActionButtonAnimator myButton =
        FloatingActionButtonAnimator.scaling;*/
    SizeConstraints sizeConst = SizeConstraints(context: context);
    return DefaultTabController(
      length: tabBar.length,
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: sizeConst.getWidthByPercent(-2),
            title: const Text('ETECSA'),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                      fit: BoxFit.fill)),
            ),
            actions: [
              TextButton(
                child: Text("Historial"),
                onPressed: () {},
              )
            ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                //Get.toNamed(Routes.HOME);
                Get.back();
              },
            ),
          ),
          body: Container(
            child: Column(
              children: [
                OptionWidget(
                  onPressed: () {},
                  rutaAsset:
                      "assets/images/backgrounds/enzona/pagar_factura.png",
                  texto: "Pagar",
                  icono: const Icon(Icons.arrow_forward_ios),
                ),
                OptionWidget(
                  onPressed: () {
                    Get.toNamed(
                        Routes.getInstance.getPath("ETECSA_CLIENT_ID_VIEW"));
                  },
                  rutaAsset:
                      "assets/images/backgrounds/enzona/mis_facturas.png",
                  texto: "Mis ID cliente",
                  icono: const Icon(Icons.arrow_forward_ios),
                ),
                Container(
                  height: 15,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: sizeConst.getHeightByPercent(3),
                    width: double.infinity,
                    color: Colors.transparent,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mis facturas a pagar",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: sizeConst.getWidthByPercent(5),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 12,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      height:
                          //  500,
                          sizeConst.getHeightByPercent(90),
                      width:
                          // 350,
                          sizeConst.getWidthByPercent(90),
                      child: FutureBuilder(
                        future: buscarFacturas(),
                        builder: (context,
                            AsyncSnapshot<
                                    dartz.Either<Failure, etecsa.EtecsaModel>>
                                snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            snapshot.data!.fold((l) {
                              mensajeError = l.message;
                              // return AlertDialog();
                            }, (r) {
                              list = r.datalist!.data;

                              log("ESTE ES LIST>>>>>>>>>$list");

                              if (list!.isEmpty) {
                                mensajeError = "No tiene facturas añadidas";
                              } else {
                                for (var i = 0; i < list!.length; i++) {
                                  String serviceType = list![i].serviceType!;
                                  switch (serviceType) {
                                    case "tb":
                                      listTelFijo!.add(list![i]);

                                      break;
                                    case "ca":
                                      listTelMin!.add(list![i]);
                                      break;
                                    case "nauta":
                                      listCuentaNauta!.add(list![i]);
                                      break;
                                    case "adsl_nauta":
                                      listNautaHogar!.add(list![i]);
                                      break;
                                    default:
                                  }
                                }
                              }
                            });
                          }
                          return mensajeError == ""
                              ? Column(
                                  children: [
                                    TabBar(
                                      isScrollable: true,
                                      indicatorColor: Colors.blue,
                                      labelColor: Colors.blue,
                                      labelStyle: TextStyle(
                                          fontSize:
                                              sizeConst.getWidthByPercent(4)),
                                      unselectedLabelColor: Colors.grey,
                                      padding: EdgeInsets.zero,
                                      tabs: tabBar,
                                    ),
                                    Flexible(
                                      child: TabBarView(children: [
                                        ListView.builder(
                                            itemCount: listTelFijo!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              etecsa.Datum datum =
                                                  listTelFijo!.elementAt(index);
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FacturasMensuales(
                                                  backgroundImagePagado:
                                                      "assets/images/backgrounds/enzona/ic_pagado.png",
                                                  backgroundImage:
                                                      "assets/images/backgrounds/enzona/factura_mensual_etecsa_elect.png",
                                                  buttonText: "Pagar",
                                                  onPressed: () {},
                                                  title: datum.serviceName!,
                                                  subtitle: datum.partnerName!,
                                                  realImport: datum.realImport!,
                                                  serviceType:
                                                      datum.serviceType!,
                                                ),
                                              );
                                              // OptionWidget(
                                              //   rutaAsset:
                                              //       "assets/images/backgrounds/enzona/mis_facturas.png",
                                              //   texto: datum.serviceName,
                                              //   onPressed: () {},
                                              // );
                                            }),
                                        ListView.builder(
                                            itemCount: listTelMin!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              etecsa.Datum datum =
                                                  listTelMin!.elementAt(index);
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FacturasMensuales(
                                                  backgroundImagePagado:
                                                      "assets/images/backgrounds/enzona/ic_pagado.png",
                                                  backgroundImage:
                                                      "assets/images/backgrounds/enzona/factura_mensual_etecsa_elect.png",
                                                  buttonText: "Pagar",
                                                  onPressed: () {},
                                                  title: datum.serviceName!,
                                                  subtitle: datum.partnerName!,
                                                  realImport: datum.realImport!,
                                                  serviceType:
                                                      datum.serviceType!,
                                                ),
                                              );
                                              // OptionWidget(
                                              //   rutaAsset:
                                              //       "assets/images/backgrounds/enzona/mis_facturas.png",
                                              //   texto: datum.serviceName,
                                              //   onPressed: () {},
                                              // );
                                            }),
                                        ListView.builder(
                                            itemCount: listCuentaNauta!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              etecsa.Datum datum =
                                                  listCuentaNauta!
                                                      .elementAt(index);
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FacturasMensuales(
                                                  backgroundImagePagado:
                                                      "assets/images/backgrounds/enzona/ic_pagado.png",
                                                  backgroundImage:
                                                      "assets/images/backgrounds/enzona/factura_mensual_etecsa_elect.png",
                                                  buttonText: "Pagar",
                                                  onPressed: () {},
                                                  title: datum.serviceName!,
                                                  subtitle: datum.partnerName!,
                                                  realImport: datum.realImport!,
                                                  serviceType:
                                                      datum.serviceType!,
                                                ),
                                              );
                                              // OptionWidget(
                                              //   rutaAsset:
                                              //       "assets/images/backgrounds/enzona/mis_facturas.png",
                                              //   texto: datum.serviceName,
                                              //   onPressed: () {},
                                              // );
                                            }),
                                        ListView.builder(
                                            itemCount: listNautaHogar!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              etecsa.Datum datum =
                                                  listNautaHogar!
                                                      .elementAt(index);
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FacturasMensuales(
                                                  backgroundImagePagado:
                                                      "assets/images/backgrounds/enzona/ic_pagado.png",
                                                  backgroundImage:
                                                      "assets/images/backgrounds/enzona/factura_mensual_etecsa_elect.png",
                                                  buttonText: "Pagar",
                                                  onPressed: () {},
                                                  title: datum.serviceName!,
                                                  subtitle: datum.partnerName!,
                                                  realImport: datum.realImport!,
                                                  serviceType:
                                                      datum.serviceType!,
                                                ),
                                              );
                                              // OptionWidget(
                                              //   rutaAsset:
                                              //       "assets/images/backgrounds/enzona/mis_facturas.png",
                                              //   texto: datum.serviceName,
                                              //   onPressed: () {},
                                              // );
                                            }),
                                        ListView.builder(
                                            itemCount: listTargPropia!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              etecsa.Datum datum =
                                                  listTargPropia!
                                                      .elementAt(index);
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FacturasMensuales(
                                                  backgroundImagePagado:
                                                      "assets/images/backgrounds/enzona/ic_pagado.png",
                                                  backgroundImage:
                                                      "assets/images/backgrounds/enzona/factura_mensual_etecsa_elect.png",
                                                  buttonText: "Pagar",
                                                  onPressed: () {},
                                                  title: datum.serviceName!,
                                                  subtitle: datum.partnerName!,
                                                  realImport: datum.realImport!,
                                                  serviceType:
                                                      datum.serviceType!,
                                                ),
                                              );
                                              // OptionWidget(
                                              //   rutaAsset:
                                              //       "assets/images/backgrounds/enzona/mis_facturas.png",
                                              //   texto: datum.serviceName,
                                              //   onPressed: () {},
                                              // );
                                            })
                                      ]),
                                    )
                                  ],
                                )
                              // ListView.builder(
                              //     itemCount: list!.length,
                              //     itemBuilder: (BuildContext context, int index) {
                              //       etecsa.Datum datum = list!.elementAt(index);
                              //       return InvoiceWidget(
                              //         // rutaAsset:
                              //         //     "assets/images/backgrounds/enzona/mis_facturas.png",
                              //         clientId: datum.serviceName,
                              //         // onPressed: () {},
                              //       );
                              //     },

                              //     // listCard: list,
                              //   )
                              : Center(
                                  child: Text(
                                    mensajeError!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
          //  OnatServiceInvoices()
          ),
    );
  }
}
