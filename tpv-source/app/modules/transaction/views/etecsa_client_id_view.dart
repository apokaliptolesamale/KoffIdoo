// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/app/core/services/logger_service.dart';
import '/app/modules/transaction/clientinvoice_exporting.dart';
import '/app/modules/transaction/widgets/payments_widgets/add_user_electricity_id_client.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/dataview/facturas_mensuales.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../controllers/clientinvoice_controller.dart';
import '../domain/models/client_service_model.dart';
import '../domain/models/etecsa_invoice_model.dart' as etecsa;

class EtecsaClientIdView extends GetView<ClientInvoiceController> {
  EtecsaClientIdView({
    Key? key,
    // required this.invoices,
  }) : super(key: key);

  // ClientInvoiceList<ClientInvoiceModel>? clienIds;

  String? mensajeError = "";
  List<etecsa.Datum>? list;
  List<etecsa.Datum>? listTelFijo = [];
  List<etecsa.Datum>? listTelMin = [];
  List<etecsa.Datum>? listCuentaNauta = [];
  List<etecsa.Datum>? listNautaHogar = [];
  List<etecsa.Datum>? listTargPropia = [];

  Future<dartz.Either<Failure, EntityModelList<ClientServiceModel>>>
      buscarFacturas() async {
    Map<String, dynamic> params = {
      // "client_id": "0111411728070904",
      "service_code": "444"
    };

    controller.listClientConfigUseCase.setParamsFromMap(params);
    return await controller
        .getFutureByUseCase(controller.listClientConfigUseCase);
  }

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

  @override
  Widget build(BuildContext context) {
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    return Scaffold(
        appBar: AppBar(
          titleSpacing: sizeConstraints.getWidthByPercent(-2),
          title: Text(
            'Configurar ID clientes de Etecsa',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: sizeConstraints.getWidthByPercent(5),
                    fontWeight: FontWeight.bold)),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Get.offNamed(Routes.getInstance.getPath("ELECTRICITY"));
              Get.back();
            },
          ),
        ),
        body: Container(
          // color: Colors.red,
          width: double.infinity,
          //MediaQuery.of(context).size.width,
          height: sizeConstraints.getHeight,
          // MediaQuery.of(context).size.height,
          child: Column(children: [
            AddUserElectricityIdClientWidget(
              press: () {
                Get.toNamed(
                    Routes.getInstance.getPath("ETECSA_FIND_CLIENT_ID_VIEW"));
                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return SearchElectricityIdClientWidget(
                //         context: context,
                //       );
                //     });
              },
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.transparent,
                  height:
                      //  500,
                      sizeConstraints.getHeightByPercent(90),
                  width:
                      // 350,
                      sizeConstraints.getWidthByPercent(90),
                  child: FutureBuilder(
                    future: buscarFacturas(),
                    builder: (context,
                        AsyncSnapshot<
                                dartz.Either<Failure,
                                    EntityModelList<ClientServiceModel>>>
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
                          var lista = r.getList();

                          log("ESTE ES LIST>>>>>>>>>$lista");

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
                                          sizeConstraints.getWidthByPercent(4)),
                                  unselectedLabelColor: Colors.grey,
                                  padding: EdgeInsets.zero,
                                  tabs: tabBar,
                                ),
                                Flexible(
                                  child: TabBarView(children: [
                                    ListView.builder(
                                        itemCount: listTelFijo!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          etecsa.Datum datum =
                                              listTelFijo!.elementAt(index);
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                              serviceType: datum.serviceType!,
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
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          etecsa.Datum datum =
                                              listTelMin!.elementAt(index);
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                              serviceType: datum.serviceType!,
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
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          etecsa.Datum datum =
                                              listCuentaNauta!.elementAt(index);
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                              serviceType: datum.serviceType!,
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
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          etecsa.Datum datum =
                                              listNautaHogar!.elementAt(index);
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                              serviceType: datum.serviceType!,
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
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          etecsa.Datum datum =
                                              listTargPropia!.elementAt(index);
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                              serviceType: datum.serviceType!,
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
          ]),
        ));
  }
}
