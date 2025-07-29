import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/helpers/snapshot.dart';
import '/app/modules/transaction/clientinvoice_exporting.dart';
import '/app/modules/transaction/domain/models/clientinvoice_model.dart';
import '/app/widgets/utils/size_constraints.dart';
import '../../../core/helpers/extract_failure.dart';
import '../../../core/services/store_service.dart';
import '../../../routes/app_routes.dart';
import '../domain/models/invoice_model.dart';
import '../widgets/payments_widgets/invoice_month_gas_widget.dart';

// ignore: must_be_immutable
class GetListFacturaGasView extends GetView<ClientInvoiceController> {
  ClientInvoiceList<ClientInvoiceModel>? clienIds;
  String? clientId;
  int? code;
  Map<dynamic, dynamic>? map;
  GetListFacturaGasView({this.clienIds, this.clientId, this.code, this.map});

  @override
  Widget build(BuildContext context) {
    ClientInvoiceController controllerC = Get.find<ClientInvoiceController>();
    controllerC.getCliendIdUseCase.setParamsFromMap(map!);
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mis ID cliente'),
          titleSpacing: sizeConstraints.getHeightByPercent(-2),
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
              final form = StoreService().getStore("InvoiceForm");
              form.flush();
              Get.offNamed(Routes.getInstance.getPath("GAS"));
              //Get.back();
            },
          ),
        ),
        body: Container(
            // color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
                future: controller.getCliendIdUseCase.getClientId(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else if (isDone(snapshot)) {
                    final resultData = snapshot.data as dart.Right;
                    if (resultData.value
                        is ClientInvoiceList<ClientInvoiceModel>) {
                      ClientInvoiceList<ClientInvoiceModel> lista =
                          resultData.value;
                      /*  return InvoiceWidget(
                        invoices: lista.clientinvoices[0].invoices,
                      );*/
                      return ListView.builder(
                          itemCount: lista.clientinvoices[0].invoices!.getTotal,
                          itemBuilder: (BuildContext context, int index) {
                            InvoiceModel invoice = lista
                                .clientinvoices[0].invoices!.invoices[index];
                            bool isPayed =
                                lista.clientinvoices[0].invoices!.invoices[0] ==
                                    invoice;
                            return Column(
                              children: [
                                InvoiceMonthGasWidget(
                                  invoice: invoice,
                                  isPayed: isPayed,
                                  mensualidad: invoice.mensualidad!,
                                  amount: invoice.importe!,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 50,
                                )
                              ],
                            );
                          });
                    } else if (snapshot.connectionState ==
                            ConnectionState.done ||
                        snapshot.connectionState == ConnectionState.none &&
                            snapshot.data is dart.Left) {
                      final fail =
                          FailureExtractor.message(snapshot.data as dart.Left);
                      return Text(fail);
                    }
                  }
                  return Center(
                      child: Container(
                    child: Text("no existen facturas"),
                  ));
                })));
  }
}
