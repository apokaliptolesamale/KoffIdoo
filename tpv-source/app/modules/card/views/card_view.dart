import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/widgets/utils/loading.dart';
import '../controllers/card_controller.dart';
import '../widgets/card_list.dart';
import '/app/widgets/utils/size_constraints.dart';

class CardView extends GetResponsiveView<CardController> {
  CardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConstraints sizeC = SizeConstraints(context: context);
    final captureArguments = ModalRoute.of(context)!.settings.arguments;

    return GetBuilder<CardController>(
      id: 'CardView',
      builder: (controller) => Scaffold(
          appBar: AppBar(
            leadingWidth: size.width / 20,
            title: captureArguments.toString() != 'Saldo' &&
                    captureArguments.toString() != 'Operaciones'
                ? Text(
                    'Tarjetas de banco',
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: sizeC.getWidthByPercent(5),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Text(
                    captureArguments.toString(),
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: sizeC.getWidthByPercent(5),
                        fontWeight: FontWeight.w500),
                  ), //const Text("Tarjetas de banco"),
            leading: IconButton(
                iconSize: size.width / 20,
                splashRadius: 25,
                onPressed: () {
                  Get.back();

                  switch (captureArguments.toString()) {
                    case "Saldo":
                      Get.back();
                      //Get.to(()=> EzDashboardView());
                      break;
                    case "Operaciones":
                      Get.back();
                      //Get.to(() => EzDashboardView());
                      break;
                    default:
                      Get.back();
                    //Get.to(() => EzProfileView());
                  }
                },
                icon: const Icon(Icons.arrow_back_ios)),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                      fit: BoxFit.fill)),
            ),
          ),
          body: FutureBuilder(
              future: controller.getCards(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return Loading(
                    text: "Cargando Tarjetas...",
                    backgroundColor: Colors.lightBlue.shade700,
                    animationColor: AlwaysStoppedAnimation<Color>(
                        Colors.lightBlue.withOpacity(0.8)),
                    containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                  );
                } else {
                  return CardList();
                }
              }))),
    );
  }
}
