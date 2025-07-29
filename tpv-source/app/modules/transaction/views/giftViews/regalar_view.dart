import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../widgets/utils/loading.dart';
import '../../../security/domain/models/account_model.dart';
import '../../../security/domain/usecases/get_account_usecase.dart';
import '../../controllers/gift_controller.dart';
import '../../widgets/donation_widgets/importe_widget.dart';
import '../../widgets/gift_widgets/button_enviar.dart';
import '../../widgets/gift_widgets/description_widget.dart';
import '../../widgets/gift_widgets/postales_widget.dart';
import '../../widgets/gift_widgets/tarjeta_widget.dart';

class RegalarView extends GetView<GiftController> {
  final String param;
  const RegalarView(this.param, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKeyImporte = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    final importeController = TextEditingController();
    final descriptionController = TextEditingController();
    return GetBuilder<GiftController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  //Get.toNamed(Routes.HISTORIALVIEW);
                },
                child: Text(
                  'Historial',
                  style: TextStyle(
                      color: Colors.blue.shade200, fontSize: size.width / 20),
                ))
          ],
          title: Text(
            'Regalo',
            style: TextStyle(fontSize: size.width / 20),
          ),
          leading: IconButton(
              iconSize: size.width / 20,
              splashRadius: 20,
              onPressed: (() => Get.back()),
              icon: const Icon(Icons.arrow_back_ios)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
        ),
        body: FutureBuilder(
          future: controller
              .findAccountParam2(GetUseCaseAccountParams(data: param)),
          //initialData: InitialData,
          builder: (BuildContext context,
              AsyncSnapshot<Either<Failure, AccountModel>> snapshot) {
            if (!snapshot.hasData) {
              return Loading(
                text: "Esperando datos de la cuenta...",
                backgroundColor: Colors.lightBlue.shade700,
                animationColor: AlwaysStoppedAnimation<Color>(
                    Colors.lightBlue.withOpacity(0.8)),
                containerColor: Colors.lightBlueAccent.withOpacity(0.2),
              );
            } else {
              //late AccountModel accountModel;
              return snapshot.data!
                  .fold((l) => Container(child: Text(l.toString())), (account) {
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey,
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 5)
                            ],
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Emitido a ',
                              style: TextStyle(
                                fontSize: size.width / 25,
                              ),
                            ),
                            Text(
                              '${account.name} ${account.lastname}',
                              style: TextStyle(
                                  fontSize: size.width / 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: size.width / 80,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: size.height / 80,
                    ),
                    ImporteWidget(
                      formKeyImporte: formKeyImporte,
                      controllerImp: importeController,
                    ),
                    DescriptionWidget(controllerDesc: descriptionController),
                    TarjetaWidget(),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    PostalesWidget(
                      importe: importeController.text,
                      description: descriptionController.text,
                    ),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    Container(
                      width: size.width / 1.1,
                      child: TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.grey),
                        onPressed: () {
                          //Aqui se debe levantar el alertDialog para introducir la contraseña de pago
                          showDialog(
                              context: context,
                              builder: (context) {
                                return ButtonEnviarGift();
                              });
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height / 90,
                            ),
                            Row(
                              children: [
                                Expanded(child: Container()),
                                Text(
                                  'ENVIAR',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: size.width / 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                            SizedBox(
                              height: size.height / 90,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'El banco emisor aplicará la tasa de cambio vigente en el momento de la transacción',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ));
              });
            }
          },
        ),
      ),
    );
  }
}
