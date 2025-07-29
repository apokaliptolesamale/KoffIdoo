import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/config/errors/errors.dart';
import '/app/core/services/store_service.dart';
import '/app/modules/transaction/bindings/invoice_binding.dart';
import '/app/modules/transaction/clientinvoice_exporting.dart';
import '/app/modules/transaction/domain/models/clientinvoice_model.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '/app/modules/transaction/widgets/payments_widgets/invoice_detail_widget.dart';
import '/app/widgets/utils/loading.dart';

class SearchInvoiceView extends GetView<ClientInvoiceController> {
  String? clientId;
  int? codeService;

  SearchInvoiceView({Key? key, this.clientId, required this.codeService});

  @override
  Widget build(BuildContext context) {
    return fetchAndDisplayData();
  }

  FutureBuilder fetchAndDisplayData() {
    final form = StoreService().getStore("InvoiceForm");
    Get.put<InvoiceBinding>(InvoiceBinding());
    ClientInvoiceController controller = Get.find<ClientInvoiceController>();
    ClientInvoiceList<ClientInvoiceModel> dataClientInvoiceModel;
    if (form.getMapFields != {}) {
      controller.getCliendIdUseCase.setParamsFromMap(form.getMapFields);
    } else {
      controller.getInvoiceByClientIdUseCase
          .setParamsFromMap({"clientId": clientId, "serviceCode": codeService});
    }
    return FutureBuilder(
      future: controller
          .getClient(), // función que devuelve una Future con los datos del servidor
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Loading(
              text: "Buscando factura",
              backgroundColor: Colors.lightBlue.shade700,
              animationColor: AlwaysStoppedAnimation<Color>(
                  Colors.lightBlue.withOpacity(0.8)),
              containerColor: Colors.lightBlueAccent.withOpacity(0.2),
            ),
          );
          // mientras se espera la respuesta del servidor, se muestra un indicador de carga
        } else if (snapshot.hasError) {
          return Text('Ha ocurrido un error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final eitherData = snapshot.data;
          if (eitherData is dart.Right) {
            final data = eitherData.value;
            if (data is ClientInvoiceList<ClientInvoiceModel>) {
              dataClientInvoiceModel = data;
              // si "data" es un ClientInvoiceModel, se revisa el valor de "charged"
              if (dataClientInvoiceModel
                          .clientinvoices[0].invoices!.invoices[0].charged ==
                      "false" ||
                  dataClientInvoiceModel
                          .clientinvoices[0].invoices!.invoices[0].pagado ==
                      "0") {
                Store store = StoreService().getStore("InvoiceForm");
                store.flush();
                // si "charged" es true, se muestra un widget personalizado con los datos recibidos
                return InvoiceDetailWidget(
                  invoice: dataClientInvoiceModel
                      .clientinvoices[0].invoices!.invoices[0],
                );
              } else {
                // si "charged" es false, se hace otra petición al servidor para obtener datos diferentes
                Map<String, dynamic> idCliente = {
                  "clientId": form.getMapFields["clientId"],
                };

                controller.getInvoiceByClientIdUseCase
                    .setParamsFromMap(idCliente);
                return FutureBuilder(
                  future: controller
                      .getInvoiceByClientId(), // función que devuelve una Future con los datos de la otra API
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Loading(
                        text: "Buscando factura",
                        backgroundColor: Colors.lightBlue.shade700,
                        animationColor: AlwaysStoppedAnimation<Color>(
                            Colors.lightBlue.withOpacity(0.8)),
                        containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Ha ocurrido un error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final data = snapshot.data;
                      if (data is dart.Right) {
                        final dataR = data.value;
                        if (dataR is InvoiceList<InvoiceModel> &&
                            dataR.getTotal > 0) {
                          final invoiceByClient = dataR;
                          String consumption = dataClientInvoiceModel
                              .clientinvoices
                              .first
                              .invoices!
                              .invoices
                              .first
                              .consumption!;
                          String charged = dataClientInvoiceModel.clientinvoices
                              .first.invoices!.invoices.first.charged!;
                          Store store = StoreService().getStore("InvoiceForm");
                          store.flush();
                          return InvoiceDetailWidget(
                            chargedI: charged,
                            consumption: consumption,
                            invoice: invoiceByClient.invoices.first,
                          );
                        } else if (dataR is InvoiceList<InvoiceModel> &&
                            dataR.getTotal == 0) {
                          Store store = StoreService().getStore("InvoiceForm");
                          store.flush();

                          return InvoiceDetailWidget(
                            invoice: dataClientInvoiceModel
                                .clientinvoices[0].invoices!.invoices[0],
                          );
                        }
                      } else {
                        return Text('No se ha recibido ninguna información.');
                      }
                      return Text('No se ha recibido ninguna información.');
                    }
                    return Text('No se ha recibido ninguna información.');
                  },
                );
              }
            } else {
              // si "data" no es un ClientInvoiceModel, se muestra un mensaje de error
              return Text(
                  'Se esperaba un ClientInvoiceModel, pero se recibió: $data');
            }
          } else {
            // si el resultado de la función no es un Right, se muestra un mensaje de error
            return Text('No se ha recibido una respuesta válida del servidor.');
          }
        } else {
          return Text('No se ha recibido ninguna información.');
        }
      },
    );
  }

  Future<dart.Either<Failure, dynamic>> manageInvoice() async {
    bool isCharged = false;
    final form = StoreService().getStore("InvoiceForm");
    Get.put<InvoiceBinding>(InvoiceBinding());
    ClientInvoiceController controller = Get.find<ClientInvoiceController>();
    controller.getCliendIdUseCase.setParamsFromMap(form.getMapFields);
    var invoiceCharge = await controller.getClient();
    if (invoiceCharge is dart.Right) {
      final client = invoiceCharge as dart.Right;
      if (client.value is ClientInvoiceList<ClientInvoiceModel>) {
        ClientInvoiceList<ClientInvoiceModel> clientM = client.value;
        String charge =
            clientM.clientinvoices.first.invoices!.invoices.first.charged!;
        if (charge == "true") {
          isCharged = true;
        } else {
          isCharged = false;
          return dart.Right(clientM);
        }
      }
      if (isCharged == true) {
        Map<String, dynamic> idCliente = {
          "client_id": form.getMapFields["client_id"],
          "status": 1111,
        };
        controller.getInvoiceByClientIdUseCase.setParamsFromMap(idCliente);
        final invoiceCharged =
            await controller.getInvoiceByClientIdUseCase.getInvoiceByClientId();
        if (invoiceCharged is dart.Right) {
          final invoiceC = invoiceCharge as dart.Right;
          if (invoiceC.value is InvoiceList<InvoiceModel>) {
            InvoiceList<InvoiceModel> invoiceCharged = invoiceC.value;
            return dart.Right(invoiceCharged);
          }
        }
      }
    } else if (invoiceCharge is dart.Left) {
      final error = invoiceCharge as dart.Left;
      if (error.value is Failure) {
        return error.value;
      }
    }

    return invoiceCharge;
  }

  void mostrarDialogoCarga(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Evita que el usuario cierre el diálogo tocando fuera
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Cargando..."),
            ],
          ),
        );
      },
    );
  }
}
