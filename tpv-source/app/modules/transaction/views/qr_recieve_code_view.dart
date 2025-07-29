import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/qrflutter/qr_flutter.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../../security/domain/models/account_model.dart';
import '../controllers/transfer_controller.dart';

class QrRecieveCodeView extends StatefulWidget {
  QrRecieveCodeView({Key? key}) : super(key: key);

  @override
  State<QrRecieveCodeView> createState() => _QrRecieveCodeViewState();
}

class _QrRecieveCodeViewState extends State<QrRecieveCodeView> {
  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    AccountModel accountModel = Get.find<AccountModel>();
    return GetBuilder<TransferController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Recibir"),
          leading: IconButton(
              iconSize: 25,
              splashRadius: 25,
              onPressed: (() => Get.back()),
              icon: const Icon(Icons.arrow_back_ios)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                      'assets/images/backgrounds/enzona/fondo_pagar.png'))),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              height: size.getHeightByPercent(50),
              width: size.getWidthByPercent(65),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(accountModel.receiveCode),
                  QrImage(
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(30, 30),
                    ),
                    embeddedImage:
                        AssetImage('assets/images/backgrounds/enzona/ez.png'),
                    data: accountModel.receiveCode,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  // TextButton(onPressed: () {}, child: Text("Especificar Monto"))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
