// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/transaction/controllers/clientinvoice_controller.dart';
import '/app/modules/transaction/domain/entities/invoice.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '/app/modules/transaction/domain/models/payment_model.dart';
import '/app/modules/transaction/widgets/option_widget.dart';
import '/app/modules/transaction/widgets/payments_widgets/pay_electricity_invoice_widget.dart';
import '/app/widgets/utils/size_constraints.dart';
import '../../../routes/app_routes.dart';
import 'invoice_list_frame.dart';

class DataWidget extends StatelessWidget {
  final List<String> data;

  DataWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    // Crear una lista de widgets a partir de los datos
    List<Widget> widgets = data.map((item) => Text(item)).toList();

    return Column(
      children: [
        Text('Datos:'),
        Text(data.join(', ')), // Mostrar la lista de datos
        SizedBox(height: 16), // Espacio vertical
        Expanded(
          child: ListView.builder(
            itemCount: widgets.length,
            itemBuilder: (BuildContext context, int index) {
              return widgets[index];
            },
          ),
        ),
      ],
    );
  }
}

class ElectricityMainView extends StatefulWidget {
  const ElectricityMainView({Key? key});

  @override
  State<ElectricityMainView> createState() => _ElectricityMainViewState();
}

class listInvoiceSimpleWidget extends StatefulWidget {
  int? total;
  InvoiceList<InvoiceModel> invoices;
  listInvoiceSimpleWidget({Key? key, required this.invoices, this.total});

  @override
  State<listInvoiceSimpleWidget> createState() =>
      _listInvoiceSimpleWidgetState();
}

class _ElectricityMainViewState extends State<ElectricityMainView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConstraints sizeContrains = SizeConstraints(context: context);
    //ElectricityServiceController controller = ElectricityServiceController(Get.find());
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Get.toNamed(
                      Routes.getInstance.getPath("ELECTRICITY_HISTORICAL"));
                  ClientInvoiceController controller =
                      Get.find<ClientInvoiceController>();
                  controller.getInvoiceByClientIdUseCase.setParamsFromMap({});
                },
                child: Text(
                  'Historial',
                  style: TextStyle(
                      color: Colors.blue.shade200, fontSize: size.width / 40),
                ))
          ],
          title: const Text('Electricidad'),
          titleSpacing: sizeContrains.getHeightByPercent(-2),
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
              // Get.toNamed(Routes.getInstance.getPath("ezhome"));
              Get.offAndToNamed(Routes.getInstance.getPath("ezhome"));
            },
          ),
        ),
        body: ListView(
          children: [
            OptionWidget(
                icono: Icon(Icons.arrow_forward_ios),
                rutaAsset: "assets/images/icons/app/enzona/pagar_factura.png",
                texto: "Pagar factura",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        //return Container();
                        return PayElectricityInvoiceWidget(
                          serviceCode:
                              ServicesPayment.byCodeName("Electricidad"),
                          context: context,
                        );
                      });
                }),
            OptionWidget(
                icono: Icon(Icons.arrow_forward_ios),
                rutaAsset: "assets/images/backgrounds/enzona/mis_facturas.png",
                texto: "Mis ID Cliente",
                onPressed: () {
                  //  InvoiceBinding.loadPages();
                  final named =
                      Routes.getInstance.getPath("ELECTRICITY_CLIENT_ID");
                  Get.toNamed(named);
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: Card(
                elevation: 2,
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        "Mis facturas a pagar",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                    ),

                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.691,
                        child:
                            /* FutureBuilder(
                            future: ,
                            builder: ,)*/
                            InvoiceListFrameView(
                          serviceCode: "2222",
                        )) // InvoiceListFrameView())
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

/*class _ElectricityMainViewState extends State<ElectricityMainView> {
  @override
  Widget build(BuildContext context) {
    //ElectricityServiceController controller = ElectricityServiceController(Get.find());
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'Historial',
              onPressed: () {
                Get.toNamed(
                    Routes.getInstance.getPath("ELECTRICITY_HISTORICAL"));
              },
            ),
          ],
          title: const Text('Electricidad'),
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
              Get.toNamed(Routes.getInstance.getPath("ezhome"));
            },
          ),
        ),
        body: ListView(
          children: [
            OptionWidget(
                icono: Icon(Icons.arrow_forward_ios),
                rutaAsset: "assets/images/icons/app/enzona/pagar_factura.png",
                texto: "Pagar factura",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        //return Container();
                        return PayElectricityInvoiceWidget(context: context,);
                      });
                }),
            OptionWidget(
                icono: Icon(Icons.arrow_forward_ios),
                rutaAsset: "assets/images/backgrounds/enzona/mis_facturas.png",
                texto: "Mis ID Cliente",
                onPressed: () {
                  //  InvoiceBinding.loadPages();
                  final named =
                      Routes.getInstance.getPath("ELECTRICITY_ADD_CLIENT_ID");
                  Get.toNamed(named);
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: Card(
                elevation: 2,
                child: ListView(
                  children: [
                    Text(
                      "Mis facturas a pagar",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),

                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.691,
                        child:
                            InvoiceListFrameView()) // InvoiceListFrameView())
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}*/

class _listInvoiceSimpleWidgetState extends State<listInvoiceSimpleWidget> {
  @override
  Widget build(BuildContext context) {
    List<Invoice> invoiceList = widget.invoices.invoices;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            //controller: controller,
            itemCount: invoiceList.length,
            padding: const EdgeInsets.all(2.0),
            itemBuilder: (context, index) {
              return Container(
                child: Center(
                    child: Text(
                  invoiceList[index].last4!,
                  style: TextStyle(fontSize: 10),
                )),
              );
            },
          ),
        ),
      ],
    );
  }
}
