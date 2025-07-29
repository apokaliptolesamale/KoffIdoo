import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '/app/modules/transaction/bindings/donation_binding.dart';
import '/app/modules/transaction/bindings/gift_binding.dart';
import '/app/modules/transaction/views/donationViews/donation_view.dart';
import '/app/modules/transaction/views/giftViews/gift_view.dart';
import '../../../widgets/tools/custom_movile_scaner.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../../card/bindings/card_binding.dart';
import '../../card/views/card_view.dart';
import '../../security/widgets/main_app_bar.dart';
import '../../transaction/bindings/transfer_binding.dart';
import '../../transaction/views/ez_qr_scan_view.dart';
import '../../transaction/views/qr_recieve_code_view.dart';
import '../../transaction/views/transfer_options.dart';
import '../controllers/ez_home_controller.dart';
import '../domain/entities/ez_item.dart';
import '../domain/models/ez_items_model.dart';

class EzDashboardView extends GetView<EzHomeController> {
  const EzDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    return Container(
      color: Colors.white,
      height: size.getHeight,
      child: Column(
        children: [
          MainAppBar(size: size, widgets: [
            LogoEZ(size: size),
            WidgetsDashboard(),
          ]),
          Expanded(
            flex: 5,
            child: FutureBuilder(
                future: getItems(),
                builder: (context, snapshots) {
                  if (!snapshots.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    // Loading(
                    //   text: "Cargando datos",
                    //   backgroundColor: Colors.lightBlue.shade700,
                    //   animationColor: AlwaysStoppedAnimation<Color>(
                    //       Colors.lightBlue.withOpacity(0.8)),
                    //   containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                    // );
                  } else {
                    List<EzItem> items = snapshots.data as List<EzItem>;
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return _itemAccesModule(item: items[index]);
                        });
                  }
                }),
          )
        ],
      ),
    );
  }

  Future<List<EzItemModel>> getItems() async {
    List<EzItemModel> result;
    String items = await rootBundle.loadString("assets/models/items.json");
    result = itemModelFromJson(items);
    return result;
  }
}

class WidgetsDashboard extends StatelessWidget {
  late String callBack = "";
  //final SizeConstraints size;
  WidgetsDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          splashRadius: 38.0,
          onPressed: () {
            // Get.to(() => QRCodeView(
            //     onScan: QrScanPage.onScan ?? onEmptyScanCallBack,
            //     callBack: callBack));
            Get.to(() => QrScanner());
            // Get.toNamed("/qrscan");
          },
          icon: Image.asset(
              "assets/images/backgrounds/enzona/escanear_transparente.png"),
          iconSize: MediaQuery.of(context).size.height / 15,
        ),
        IconButton(
          onPressed: () {
            Get.to(() => QrRecieveCodeView(), binding: TransferBinding());
          },
          icon: Image.asset("assets/images/backgrounds/enzona/qr.png"),
          iconSize: MediaQuery.of(context).size.height / 15,
        ),
      ],
    ));
  }
}

class _itemAccesModule extends StatelessWidget {
  final EzItem item;

  const _itemAccesModule({
    required this.item,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //AccountController accountController = Get.find<AccountController>();
    //EzHomeController ezHomeController = Get.find<EzHomeController>();
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          IconButton(
              onPressed: () {
                switch (item.name) {
                  case "Transferir":
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return TransferOptionsView();
                        });
                    // showDialog(
                    //     barrierDismissible: false,
                    //     context: context,
                    //     builder: (context) {
                    //       return Loading(
                    //         text: "Probando...",
                    //         backgroundColor: Colors.lightBlue.shade700,
                    //         animationColor: AlwaysStoppedAnimation<Color>(
                    //             Colors.lightBlue.withOpacity(0.8)),
                    //         containerColor:
                    //             Colors.lightBlueAccent.withOpacity(0.2),
                    //       );
                    //       // return TransferOptionsView();
                    //     });
                    break;
                  case "Saldo":
                    Get.to(() => CardView(),
                        binding: CardBinding(), arguments: item.name);

                    break;
                  case "Operaciones":
                    Get.to(() => CardView(),
                        binding: CardBinding(), arguments: item.name);

                    break;
                  case "Bulevar":
                    break;
                  case "Regalo":
                    Get.to(() => GiftView(), binding: GiftBinding());
                    // Get.toNamed(Routes.GIFTVIEW);
                    break;
                  case "Donar":
                    Get.to(() => DonationView(), binding: DonationBinding());
                    // Get.toNamed(Routes.DONACIONESVIEW);
                    break;
                  case "Electricidad":
                    /* Get.to(() => ElectricityMainView(),
                        binding: InvoiceBinding());
                         TransactionBinding.loadPages();
                   final named = Routes.getInstance.getPath("TRANSACTIONS");
                   Get.toNamed(named);*/
                    Get.toNamed(Routes.getInstance.getPath("ELECTRICITY"));
                    break;
                  case "ETECSA":
                    // Get.toNamed(Routes.getInstance.getPath("ETECSA_SERVICE"),
                    //     arguments: item.name);
                    Get.toNamed(
                      Routes.getInstance.getPath("ETECSA"),
                    );
                    break;
                  case "Impuestos":
                    // Get.toNamed(Routes.ONAT_TAXES, arguments: item.name);
                    break;
                  case "Gas":
                    Get.toNamed(Routes.getInstance.getPath("GAS"));
                    break;
                  case "Correos de Cuba":
                    // Get.toNamed(Routes.CUBAN_EMAIL_SERVICE,
                    // arguments: item.name);
                    break;
                  case "Efectivo":
                    Get.to(() => EzQrScanView());
                    break;
                }
              },
              iconSize: size.width / 7,
              icon: Image.asset(item.image)),
          Container(
            //color: Colors.red,
            child: Text(
              item.name,
              style: TextStyle(
                  fontSize: size.height / 70, overflow: TextOverflow.ellipsis),
            ),
          )
        ],
      ),
    );
  }
}
