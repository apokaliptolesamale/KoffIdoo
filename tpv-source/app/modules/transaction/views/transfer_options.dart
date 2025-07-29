import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bindings/transfer_binding.dart';
import 'find_account_view.dart';
import 'transfer_card_view.dart';

class TransferOptionsView extends StatefulWidget {
  const TransferOptionsView({Key? key}) : super(key: key);

  @override
  TransferOptionsViewState createState() => TransferOptionsViewState();
}

class TransferOptionsViewState extends State<TransferOptionsView> {
  bool chkbx1 = false;

  bool? chkbx2 = false;
  bool? chkbx3 = false;
  bool? chkbx4 = false;
  @override
  Widget build(BuildContext context) {
    // TransferController transferController = Get.find<TransferController>();
    //SizeConstraints size = SizeConstraints(context: context);
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
              child: Text("Seleccione como desea realizar su transferencia.")),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close_rounded))
        ],
      ),
      scrollable: true,
      content: Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
                leading: Container(
                  height: 35,
                  width: 35,
                  child: Image.asset(
                    "assets/images/backgrounds/enzona/transferir_amigo.png",
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("A un amigo"),
                onTap: () {
                  // Get.toNamed("/desarrollo");
                  // Get.toNamed("/transferFriendsView");
                }),
            ListTile(
                leading: Container(
                  height: 35,
                  width: 35,
                  child: Image.asset(
                    "assets/images/backgrounds/enzona/cuenta.png",
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("A un usuario"),
                onTap: () {
                  Get.back();
                  Get.to(() => FindAccountView(), binding: TransferBinding());
                  // Get.toNamed(Routes.getInstance.getPath("FIND_ACCOUNT_PAGE"));
                  // Get.to(() => FindAccountPageImpl(
                  //     name: "/transfer/findAccountPage",
                  //     page: FindAccountPageImpl.getPageBuilder(
                  //         "/transfer/findAccountPage")));
                }),
            ListTile(
                leading: Container(
                  height: 35,
                  width: 35,
                  child: Image.asset(
                    "assets/images/backgrounds/enzona/transferir_tarjeta.png",
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text("A una tarjeta"),
                onTap: () {
                  Get.to(() => TransferCardView(), binding: TransferBinding());
                }),
            ListTile(
                leading: Container(
                  height: 35,
                  width: 35,
                  child: Image.asset(
                    "assets/images/backgrounds/enzona/tarjeta_azul.png",
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text(
                  "A una de mis tarjetas",
                ),
                onTap: () {
                  Get.toNamed("/transferFriendsView");
                }),
          ],
        ),
      ),
    );

    /* CustomSafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Configuración de pago"),
          leading: IconButton(
              iconSize: 25,
              splashRadius: 25,
              onPressed: (() => Get.back()),
              icon: const Icon(Icons.arrow_back_ios)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
        ),
        body: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Divider(
                height: 12,
                color: Colors.transparent,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Get.snackbar("ListTitle", "Tapped");
                      },
                      leading:
                          Image.asset("assets/images/transferir_amigo.png"),
                      title: Text("A un amigo"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      height: 10,
                    ),
                    ListTile(
                      leading: Image.asset("assets/images/cuenta.png"),
                      title: Text("A un usuario"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      height: 10,
                    ),
                    ListTile(
                      leading:
                          Image.asset("assets/images/transferir_tarjeta.png"),
                      title: Text("A una tarjeta"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      height: 10,
                    ),
                    ListTile(
                      leading: Image.asset("assets/images/tarjeta_azul.png"),
                      title: Text("A una de mis tarjetas"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );*/
  }

  @override
  void initState() {
    // TransferBinding();

    super.initState();
  }
}
