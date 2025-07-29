// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/services/store_service.dart';
import '/app/modules/transaction/bindings/config_service_binding.dart';
import '/app/modules/transaction/controllers/clientinvoice_controller.dart';
import '/app/modules/transaction/domain/entities/clientinvoice.dart';
import '/app/modules/transaction/domain/models/clientinvoice_model.dart';
import '/app/modules/transaction/widgets/custom_detail_list_tile.dart';
import '/app/routes/app_pages.dart';
import '/app/widgets/botton/custom_flat_botton.dart';
import '../../../routes/app_routes.dart';
import '../domain/entities/config_service.dart';
import '../domain/entities/invoice.dart';
import '../domain/models/payment_model.dart';

class ClientIdDetailView extends StatelessWidget {
  ClientInvoiceList<ClientInvoiceModel>? clientModel;
  ClientInvoice? clientInvoice;
  ClientService? clientService;
  int? typeService;

  ClientIdDetailView(
      {this.clientModel,
      this.clientInvoice,
      this.clientService,
      this.typeService});

  @override
  Widget build(BuildContext context) {
    Get.put<ClientServiceBinding>(ClientServiceBinding());
    /* bool itHavesRoute = clientService!.metadata!["route"] != "";
    bool itHavesFolio = clientService!.metadata!["folio"] != "";*/
    ClientInvoiceModel clientInvoice = clientModel!.clientinvoices[0];
    String? owner = "";
    String? clientId = clientInvoice.clientId;
    String? folio = clientInvoice.invoices!.invoices[0].folio;
    String? ruta = clientInvoice.invoices!.invoices[0].route;
    bool itHavesRoute = false;
    bool itHavesFolio = false;
    if (typeService == ServicesPayment.byCodeName("Gas")) {
      owner = clientInvoice.invoices!.invoices[0].name;
      clientId = clientInvoice.gasClientId;
    } else if (typeService == ServicesPayment.byCodeName("Electricidad")) {
      owner = clientInvoice.invoices!.invoices[0].name;
      clientId = clientInvoice.clientId;
      folio = clientInvoice.invoices!.invoices[0].folio;
      ruta = clientInvoice.invoices!.invoices[0].route;
      itHavesRoute = ruta != "";
      itHavesFolio = folio != "";
    }
    ClientInvoiceController controller = Get.find<ClientInvoiceController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar nuevo'),
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
            //Get.toNamed(Routes.getInstance.getPath("ELECTRICITY"));
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Card(
            elevation: 1,
            child: IntrinsicHeight(
              child: Column(
                children: [
                  CustomDetailListTile(
                    titulo: "Id. Cliente",
                    value: clientId,
                    fontWeight: false,
                    context: context,
                  ),
                  CustomDetailListTile(
                    titulo: "Titular",
                    value: owner,
                    fontWeight: false,
                    context: context,
                  ),
                  itHavesRoute
                      ? CustomDetailListTile(
                          titulo: "Ruta",
                          value: ruta,
                          fontWeight: false,
                          context: context,
                        )
                      : Container(),
                  itHavesFolio
                      ? CustomDetailListTile(
                          titulo: "Folio",
                          value: folio,
                          fontWeight: false,
                          context: context,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          CustomFlatBotton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width * 0.80,
            height: MediaQuery.of(context).size.height / 50,
            color: Colors.blue,
            child: Text('Aceptar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
            onPressed: () async {
              ClientInvoiceModel clientInvoice = clientModel!.clientinvoices[0];
              if (typeService == ServicesPayment.byCodeName("Electricidad")) {
                String metadataString =
                    json.encode(clientInvoice.invoices!.invoices[0].metadata);
                //metadata.toString();
                final form = StoreService().getStore("addClientId");
                int codeName = ServicesPayment.byCodeName("Electricidad");
                form.add('service_code', codeName);
                form.add('client_id', clientService!.clientId);
                form.add('owner', clientService!.owner);
                form.add('metadata', metadataString);
                form.add('automatic', "0");
                controller.addClientInvoice.setParamsFromMap(form.getMapFields);
                await controller.addClientInvoice.addClientId();
                Get.toNamed(
                    Routes.getInstance.getPath("ELECTRICITY_CLIENT_ID"));
              } else if (typeService == ServicesPayment.byCodeName("Gas")) {
                Invoice invoice = clientInvoice.invoices!.invoices[0];
                Map<String, dynamic> meta = {
                  "cobrador": invoice.cobrador,
                  "Libro": invoice.libro,
                  "IdMunicipio": invoice.idMunicipio,
                  "Municipio": invoice.municipio,
                  "DatosContrato": invoice.datosContrato,
                  "Metro": invoice.metro
                };
                String metadataString = json.encode(meta);
                final form = StoreService().getStore("addClientId");
                int codeName = ServicesPayment.byCodeName("Gas");
                form.add('service_code', codeName);
                form.add('client_id', clientInvoice.gasClientId);
                form.add('owner', clientInvoice.invoices!.invoices[0].name);
                form.add('metadata', metadataString);
                form.add('automatic', "0");
                controller.addClientInvoice.setParamsFromMap(form.getMapFields);
                await controller.addClientInvoice.addClientId();
                Get.toNamed(Routes.getInstance.getPath("GAS_CLIENT_ID_LIST"));
              }
            },
          )
          /*FractionallySizedBox(
                         // heightFactor: 0.5,
                          widthFactor: 0.5,
                          child: ElevatedButton(
                          onPressed: () {
            
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            'Aceptar',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                                          ),
                        ),*/
        ],
      ),
    );
  }
}

/*class ClientIdListFrame extends CustomView<ClientInvoiceController> {
  late CustomFutureBuilder fututeBuilder;
  late UseCase usecase;
  int? codeS;
  String? type;
  Map<dynamic, dynamic>? parameters;
  late ClientInvoiceList<ClientInvoiceModel> client;
  ClientIdListFrame({Key? key, this.parameters, required this.codeS, required this.type}) {
    Get.lazyPut(() => this);
    // usecase = GetClientIdUseCase<ClientInvoiceModel>(Get.find());
    usecase = apply(ListClientConfigUseCase<ClientServiceModel>(Get.find()));
  }
  UseCase apply(UseCase uc) {
     Map<String,dynamic> code = { 
     "serviceCode": 2222,
   };
    Store store = StoreService().getStore("IdClientsForm");
    if (store.getMapFields.isNotEmpty) {
      uc = GetClientIdUseCase<ClientInvoiceModel>(Get.find());
    }else {
      // uc = ListClientConfigUseCase<ClientServiceModel>(Get.find)
    uc = uc.setParamsFromMap(code);
    }
    return uc;
  }

  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  @override
  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    if (uc is GetClientIdUseCase) return getTransactionListBuilder<A>();
    if (uc is ListClientConfigUseCase) return getTransactionListBuilder<A>();
    return getTransactionListBuilder();
  }

  @override
  Future<T> getFutureByUseCase<T>(UseCase uc) async {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }

  AsyncWidgetBuilder getTransactionListBuilder<A>() {
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
        //final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Center(
            child: Container(
          height: MediaQuery.of(context).size.height / 2,
        ));
      } else if (isDone(snapshot)) {
        Store store = StoreService().getStore("IdClientsForm");
        store.flush();
        log(store.getMapFields);
        final resultData = snapshot.data as dart.Right;
        if (resultData.value is ClientInvoiceList<ClientInvoiceModel>) {
          ClientInvoiceList<ClientInvoiceModel> client = resultData.value;
          return ClientIdDetailView(
            clientModel: client,
          );
        }
      } else if (isError(snapshot)) {
        //final dart.Left  resultData = snapshot.data as dart.Left;
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Center(
            child: Container(
          height: MediaQuery.of(context).size.height / 2,
          child: AlertDialog(
            actions: [
              Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
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
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.white),
                        ),
                      ),
                    )),
              )
            ],
            contentPadding: EdgeInsets.all(10),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                  child: Text(
                fail,
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
              )),
            ),
            title: Center(
              child: Text(
                "Error",
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
              ),
            ),
          ),
        ));
      }
      return ClientIdDetailView(
        clientModel: client,
      );
    };
    return builder;
  }
  AsyncWidgetBuilder getClientConfigList<A>() {
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
        //final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Center(
            child: Container(
          height: MediaQuery.of(context).size.height / 2,
        ));
      } else if (isDone(snapshot)) {
        Store store = StoreService().getStore("IdClientsForm");
        store.flush();
        log(store.getMapFields);
        final resultData = snapshot.data as dart.Right;
        if (resultData.value is ClientInvoiceList<ClientInvoiceModel>) {
          ClientInvoiceList<ClientInvoiceModel> client = resultData.value;
          return ClientIdDetailView(
            clientModel: client,
          );
        }
      } else if (isError(snapshot)) {
        //final dart.Left  resultData = snapshot.data as dart.Left;
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Center(child: Text(fail),);
      }
      return ClientIdDetailView(
        clientModel: client,
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
}*/
