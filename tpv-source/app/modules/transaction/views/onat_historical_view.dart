import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../controllers/invoice_controller.dart';
import '../widgets/transactions_filter_widget.dart';
import 'historical_view_frame.dart';

class OnatHistoricalView extends GetView<InvoiceController> {
  OnatHistoricalView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* FloatingActionButtonAnimator myButton =
        FloatingActionButtonAnimator.scaling;*/

    SizeConstraints sizeContrains = SizeConstraints(context: context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return FilterTransactionsWidget(
                    context: context,
                  );
                });
          },
          child: const Icon(Icons.filter_alt_outlined),
        ),
        appBar: AppBar(
          title: const Text('Historial'),
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
              Get.offNamed(Routes.getInstance.getPath("ONAT"));
            },
          ),
        ),
        body: HistoricalInvoiceFrameView(
          typeInvoice: 19,
        )); //TransaccionesViewV(InvoiceList: InvoiceList,));
  }
}
