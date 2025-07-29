import 'dart:convert';

// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/config/errors/errors.dart';
import '/app/core/helpers/extract_failure.dart';
import '/app/core/helpers/snapshot.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/interfaces/use_case.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/store_service.dart';
import '/app/modules/card/bindings/card_binding.dart';
import '/app/modules/card/card_exporting.dart';
import '/app/modules/card/domain/models/card_model.dart';
import '/app/modules/transaction/clientinvoice_exporting.dart';
import '/app/modules/transaction/domain/models/clientinvoice_model.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '/app/modules/transaction/domain/usecases/get_client_id_usecase.dart';
import '/app/modules/transaction/domain/usecases/list_clientinvoice_usecase.dart';
import '/app/modules/transaction/widgets/drop_down_button.dart';
import '/app/modules/transaction/widgets/payments_widgets/invoice_detail_widget.dart';
import '/app/widgets/botton/custom_flat_botton.dart';
import '/app/widgets/field/custom_get_view.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '/app/widgets/utils/loading.dart';
import '../../../routes/app_routes.dart';
import '../domain/models/payment_model.dart';
import '../domain/usecases/pay_service_usecase.dart';

class ElectricityPayServiceView extends GetView<ClientInvoiceController> {
  ClientInvoiceList<ClientInvoiceModel> clientInvoiceModel;
  String icono;
  ElectricityPayServiceView(
      {required this.clientInvoiceModel, required this.icono});

  @override
  Widget build(BuildContext context) {
    //ClientInvoiceModel clientInvoice = clientInvoiceModel.clientinvoices[0];
    Widget icon = getPictureProfile(icono, context);
    List<Widget> widgets = getMapByInfo(context);
    return Scaffold(
      appBar: AppBar(
        //foregroundColor: ,
        backgroundColor: Colors.grey,
        surfaceTintColor: Colors.red,
        title: Text("Detalles"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            child: Expanded(
              child: ListView(children: [
                icon,
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "Empresa ELectrica",
                          //"${clientInvoice.merchantAlias}",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).size.width / 30,
                              fontFamily: "Roboto"),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                getNumberAmount(context),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.1,
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: ListView(
                        children: widgets,
                      )),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget enterPaymentPassword(BuildContext context) {
    TextEditingController controllerEdit = TextEditingController();
    ClientInvoiceModel clientInvoice = clientInvoiceModel.clientinvoices[0];
    return AlertDialog(
      actions: [
        Align(
          alignment: Alignment.center,
          child: TextButton(
              onPressed: () {
                Map<String, dynamic> metadataJson = {
                  "route": clientInvoice.invoices!.invoices[0].route,
                  "folio": clientInvoice.invoices!.invoices[0].folio,
                };
                String metadataString = json.encode(metadataJson);
                //metadata.toString();
                final form = StoreService().getStore("payElectricityService");
                form.add(
                    'service_code', ServicesPayment.byCodeName("Electricidad"));
                form.add(
                    'client_id', clientInvoice.invoices!.invoices[0].clientId);
                form.add('owner', clientInvoice.invoices!.invoices[0].owner);
                form.add('metadata', metadataString);
                form.add('automatic', "0");
                form.add('funding_source_uuid', "");
                form.add('amount', clientInvoice.invoices!.invoices[0].amount);
                controller.addClientInvoice.setParamsFromMap(form.getMapFields);
                controller.addClientInvoice.addClientId();
                Get.toNamed(
                    Routes.getInstance.getPath("ELECTRICITY_PAY_SERVICE"));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.30,
                height: MediaQuery.of(context).size.height * 0.070,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Aceptar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.white),
                  ),
                ),
              )),
        )
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      scrollable: true,
      titlePadding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
      title: Center(child: Text("Pagar factura")),
      contentPadding: EdgeInsets.only(
          left: 5, right: 5, top: MediaQuery.of(context).size.height / 30),
      elevation: 10,
      //title: Text('Material Dialog'),
      // ignore: sized_box_for_whitespace
      content: Container(
          //color: Colors.red,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Form(
            child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  value = controllerEdit.text;
                  //log(controllerEdit.text);
                },
                controller: controllerEdit,
                decoration: InputDecoration(
                    errorBorder: InputBorder.none,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          controllerEdit.clear();
                        },
                        child: Icon(Icons.close)),
                    label: Text("Introduzca su contraseña de pago"),
                    border: OutlineInputBorder())),
          )),
    );
  }

  Widget getButton(BuildContext context, ClientInvoiceModel clientInvoice) {
    Get.put<CardBinding>(CardBinding());
    //CardController cardController = Get.find<CardController>();
    //final cards = cardController.listCardUseCard.call(null);
    return CustomFlatBotton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height / 50,
      color: Colors.blue,
      child: Text('Aceptar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          )),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return enterPaymentPassword(context);
            });
      },
    );
  }

  Widget getCard() {
    CardController cardController = Get.find<CardController>();
    return Container(
      color: Colors.transparent,
      height: 50,
      width: double.infinity,
      child: FutureBuilder(
          future: cardController.getCards(),
          //AsyncSnapshot<Either<Failure, EntityModelList<CardModel>>
          builder: (context,
              AsyncSnapshot<dart.Either<Failure, EntityModelList<CardModel>>>
                  snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return snapshot.data!.fold((l) {
                l.toString();
                return AlertDialog();
              }, (r) {
                List<CardModel> list = r.getList();
                return DropDownButton(
                  listCard: list,
                );
              });
            }
          }),
    );
  }

  List<Widget> getMapByInfo(
    BuildContext context,
  ) {
    ClientInvoiceModel clientInvoice = clientInvoiceModel.clientinvoices[0];
    bool isCharged = false;
    if (clientInvoice.invoices!.invoices[0].charged! == "true") {
      isCharged = true;
    } else if (clientInvoice.invoices!.invoices[0].charged! == "false") {
      isCharged = false;
    }

    bool isTrue = true;
    List<Widget> mapWidgets = [];
    Map<String, dynamic> map = {};
    map.addIf(
        clientInvoice.clientId != null, "Id. Cliente", clientInvoice.clientId);
    map.addIf(clientInvoice.invoices!.invoices[0].owner != "", "Titular",
        clientInvoice.invoices!.invoices[0].owner);
    map.addIf(clientInvoice.invoices!.invoices[0].month != "", "Fecha",
        clientInvoice.invoices!.invoices[0].month);
    map.addIf(clientInvoice.invoices!.invoices[0].consumption != "", "Consumo",
        clientInvoice.invoices!.invoices[0].consumption);
    map.addIf(clientInvoice.invoices!.invoices[0].route != "", "Ruta",
        clientInvoice.invoices!.invoices[0].route);
    map.addIf(clientInvoice.invoices!.invoices[0].folio != "", "Folio",
        clientInvoice.invoices!.invoices[0].folio);
    /*  Map<String,dynamic> mapString = {
     "Id. Cliente": "486686846846",
     "Titular": "fjksadjfs;kla",
     "Fecha": "kdajdfsk",
     "Consumo": "12341234 kw",
     "Ruta": "fjslkjfklsa",
     "Folio": "fsaklfj;sa",
     };
     
     map.addAll(mapString);*/

    log(map.entries);
    for (var entry in map.entries) {
      ListTile listile = ListTile();
      if (map.containsKey("Bonficacion REDSA") &&
          map.containsKey("Bonficacion ")) {
        listile = ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 1),
          leading: Text(
            "${entry.key}:",
            maxLines: 5,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: MediaQuery.of(context).size.width / 23,
                fontWeight: FontWeight.w500),
          ),
          trailing: Text(
            entry.value,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: TextStyle(
                color: Colors.grey.shade600,
                fontFamily: 'Roboto',
                fontSize: MediaQuery.of(context).size.width / 30,
                fontWeight: FontWeight.w500),
          ),
        );
      } else {
        listile = ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 1),
          leading: Text(
            "${entry.key}:",
            maxLines: 5,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: MediaQuery.of(context).size.width / 23,
            ),
          ),
          trailing: Text(
            entry.value,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontFamily: 'Roboto',
              fontSize: MediaQuery.of(context).size.width / 30,
            ),
          ),
        );
      }
      mapWidgets.add(listile);
      mapWidgets.add(Divider(
        thickness: 1,
      ));
    }
    if (isTrue) {
      mapWidgets.add(getButton(context, clientInvoice));
    }
    return mapWidgets;
  }

  Widget getNumberAmount(BuildContext context) {
    bool boolean = true;
    ClientInvoiceModel clientInvoice = clientInvoiceModel.clientinvoices[0];
    // CardController cardController = Get.find<CardController>();
    if (boolean == false) {
      return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Stack(children: [
          Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: MediaQuery.of(context).size.height / 400),
              Text(
                "-400 CUP",
                //"${transaction.amount} ${transaction.currency!.toUpperCase()}",
                //"${transaction.amount}",
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: MediaQuery.of(context).size.width / 24,
                    fontFamily: "Roboto",
                    color: Colors.grey),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Text(
                    "-200 CUP",
                    //"${transaction.bankDebtitDetail!.debited} ${transaction.currency!.toUpperCase()}",
                    //  "${transaction.bankDebtitDetail!.debited}",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 18,
                        fontFamily: "Roboto"),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  Chip(
                    label: Text(
                      "-10%",
                      // "-${plusBonus(transaction)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 24,
                          fontFamily: "Roboto"),
                    ),
                    backgroundColor: Colors.red,
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
            ]),
          )
        ]),
      );
    } else {
      return Container(
        child: Column(
          children: [
            Text(
              "Factura pagada",
              //"${clientInvoice.invoices!.invoices[0].charged}",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 18,
                  fontFamily: "Roboto"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Text(
              "${clientInvoice.invoices!.invoices[0].amount}",
              //"${transaction.bankDebtitDetail!.debited} ${transaction.currency!.toUpperCase()}",
              //  "${transaction.bankDebtitDetail!.debited}",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 18,
                  fontFamily: "Roboto"),
            ),
          ],
        ),
      );
    }
  }

  Widget getPictureProfile(String icon, BuildContext context) {
    if (icon == "Electricidad") {
      return Container(
          width: MediaQuery.of(context).size.width * 0.18,
          height: MediaQuery.of(context).size.width * 0.18,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            child: Image.asset(getPicureService(context, icono)),
            radius: 15,
          ));
    } else {
      return Container(
          width: MediaQuery.of(context).size.width * 0.18,
          height: MediaQuery.of(context).size.width * 0.18,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            child: Container(),
            radius: 15,
          ));
    }
  }

  String getPicureService(
    BuildContext context,
    String icono,
  ) {
    String picture;
    switch (icono) {
      case "Activación de tarjetas":
        picture = "assets/images/backgrounds/enzona/im_foto_tarjeta.png";
        break;
      case "Pagos a Comercios":
        picture = "assets/images/backgrounds/enzona/ic_pago_comercio.png";
        break;
      case "Donaciones":
        picture = "assets/images/backgrounds/enzona/ic_tranferencia.png";
        break;
      case "Electricidad":
        picture = "assets/images/backgrounds/enzona/electricidad.png";
        break;
      case "Pago de factura ETECSA":
        picture = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
        break;
      case "Pago de servicio nauta ETECSA":
        picture = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
        break;
      case "Pago del servicio propia ETECSA":
        picture = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
        break;
      case "Giros de Correos de Cuba":
        picture = "assets/images/backgrounds/enzona/correos.png";
        break;
      case "Pago de Factura del Gas":
        picture = "assets/images/backgrounds/enzona/ic_pago_gas.png";
        break;
      case "Pago de Tributo a la ONAT ":
        picture = "assets/images/backgrounds/enzona/ic_onat.png";
        break;
      case "Regalo":
        picture = "assets/images/backgrounds/enzona/im_foto_tarjeta.png";
        break;
      default:
        return "";
    }
    return picture;
  }
}

class PayElectricityServiceFrame extends CustomView<ClientInvoiceController> {
  late CustomFutureBuilder fututeBuilder;
  late UseCase usecase;
  Map<dynamic, dynamic>? parameters;
  late ClientInvoiceList<ClientInvoiceModel> client;
  PayElectricityServiceFrame({Key? key, this.parameters}) {
    Get.lazyPut(() => this);
    //usecase = GetClientIdUseCase<ClientInvoiceModel>(Get.find());
    usecase = apply(ListClientInvoiceUseCase<ClientInvoiceModel>(Get.find()));
  }
  UseCase apply(UseCase uc) {
    Store store = StoreService().getStore("InvoiceForm");
    Store payStore = StoreService().getStore("payElectricityService");
    if (store.getMapFields.isNotEmpty) {
      uc = GetClientIdUseCase<ClientInvoiceModel>(Get.find());
      uc = uc.setParamsFromMap(store.getMapFields);
    } else if (payStore.getMapFields.isNotEmpty) {
      /* uc = PayServiceUseCase<InvoiceModel>(Get.find());
       uc = uc.setParamsFromMap(payStore.getMapFields);*/
    }
    return uc;
  }

  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  @override
  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    if (uc is PayServiceUseCase) return payInvoiceBuilder<A>();
    if (uc is GetClientIdUseCase) return getInvoiceBuilder<A>();
    return getInvoiceBuilder();
  }

  @override
  Future<T> getFutureByUseCase<T>(UseCase uc) async {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }

  AsyncWidgetBuilder getInvoiceBuilder<A>() {
    // ignore: prefer_function_declarations_over_variables
    var builder = (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return EmptyDataSearcherResult(
            child: Loading(
          text: "Cargando listado de transacciones...",
          backgroundColor: Colors.lightBlue.shade700,
          animationColor:
              AlwaysStoppedAnimation<Color>(Colors.lightBlue.withOpacity(0.8)),
          containerColor: Colors.lightBlueAccent.withOpacity(0.2),
        ));
      } else if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data is dart.Left) {
        // final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Center(
            child: Container(
          height: MediaQuery.of(context).size.height / 2,
        ));
      } else if (isDone(snapshot)) {
        Store store = StoreService().getStore("InvoiceForm");
        store.flush();
        log(store.getMapFields);
        final resultData = snapshot.data as dart.Right;
        if (resultData.value is ClientInvoiceList<ClientInvoiceModel>) {
          ClientInvoiceList<ClientInvoiceModel> client = resultData.value;
          return ElectricityPayServiceView(
            icono: "Electricidad",
            clientInvoiceModel: client,
          );
        }
      } else if (isError(snapshot)) {
        //final dart.Left  resultData = snapshot.data as dart.Left;
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Center(child: Text(fail));
      }
      return ElectricityPayServiceView(
        icono: "Electricidad",
        clientInvoiceModel: client,
      );
    };
    return builder;
  }

  AsyncWidgetBuilder payInvoiceBuilder<A>() {
    // ignore: prefer_function_declarations_over_variables
    var builder = (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return EmptyDataSearcherResult(
            child: Loading(
          text: "Cargando factura",
          backgroundColor: Colors.lightBlue.shade700,
          animationColor:
              AlwaysStoppedAnimation<Color>(Colors.lightBlue.withOpacity(0.8)),
          containerColor: Colors.lightBlueAccent.withOpacity(0.2),
        ));
      } else if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data is dart.Left) {
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Center(
            child: Container(
          height: MediaQuery.of(context).size.height / 2,
        ));
      } else if (isDone(snapshot)) {
        Store store = StoreService().getStore("payElectricityService");
        store.flush();
        log(store.getMapFields);
        final resultData = snapshot.data as dart.Right;
        if (resultData.value is InvoiceList<InvoiceModel>) {
          InvoiceList<InvoiceModel> invoice = resultData.value;
          return InvoiceDetailWidget(
            invoice: invoice.invoices[0],
          );
        }
      } else if (isError(snapshot)) {
        Store store = StoreService().getStore("payElectricityService");
        store.flush();
        //final dart.Left  resultData = snapshot.data as dart.Left;
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Center(child: Text(fail));
      }
      return ElectricityPayServiceView(
        icono: "Electricidad",
        clientInvoiceModel: client,
      );
    };
    return builder;
  }

  Widget rebuild(BuildContext context, UseCase uc) =>
      fututeBuilder = CustomFutureBuilder(
        future: getFutureByUseCase(uc),
        builder: getBuilderByUseCase(uc),
        context: context,
      );
}
