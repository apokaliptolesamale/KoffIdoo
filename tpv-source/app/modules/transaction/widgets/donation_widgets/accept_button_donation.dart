import 'package:dartz/dartz.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/services/logger_service.dart';
import '../../../../core/services/store_service.dart';
import '../../../../widgets/botton/rounded_button.dart';
import '../../../../widgets/utils/loading.dart';
import '../../../card/widgets/encrypt/encryptFromCrt.dart';
import '../../controllers/donation_controller.dart';
import '../../domain/models/donation_model.dart';
import '../../domain/usecases/add_donation_usecase.dart';

class ButtonAccept extends StatelessWidget {
  final String fundingSourceUuid;
  final DonationModel donationCtr;
  final TextEditingController importe;
  final GlobalKey<FormState> formKeyImporte;
  const ButtonAccept({
    key,
    required this.fundingSourceUuid,
    required this.donationCtr,
    required this.importe,
    required this.formKeyImporte,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKeyPass = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    TextEditingController paymentPassword = TextEditingController();
    //TextEditingController importe = TextEditingController();
    log('Este es el fundingUUID==> $fundingSourceUuid');
    /*  String encryptPaymentPassword() {
      String string = paymentPassword.text;
      var b64 = RSAEncrypt().getEncryptPublicKey(
          RSAEncoding.PKCS1, string, 'assets/config/pubkey.pem');
      return b64;
    } */

    final donationController = Get.find<DonationController>();

    Future<String> encryptPaymentPassword() async {
      String string = paymentPassword.text;
      log('este es el payment.text==> $string');
      var b64 = await RSAEncrypt().getEncryptPublicKey(RSAEncoding.PKCS1,
          string, 'assets/raw/enzona_assets_config_pubkey.pem');
      return b64;
    }

    Future<Either<Failure, DonationModel>> createDonation() async {
      final storeDonation = StoreService().getStore("donation");
      log(storeDonation.getMapFields.values.first.toString());
      final String fundingSourceUUID =
          storeDonation.getMapFields.values.first.toString();

      log('Este es el fundin ==> $fundingSourceUUID');
      log('Este es el fundin$fundingSourceUuid');
      log('Esta es la descriptcion==> ${donationCtr.description}');
      log('Este es el importe==> ${importe.text}');
      final donation = CreateDonationModel(
        fundingSourceUuid: fundingSourceUuid,
        description: donationCtr.description,
        donationUuid: donationCtr.uuid,
        amount: importe.text,
        currency: donationCtr.currency,
        paymentPassword: await encryptPaymentPassword(),
        fingerprint: '',
      );

      return await donationController
          .createDonation(AddUseCaseDonationParams(model: donation));
    }

    return GetBuilder<DonationController>(
      builder: (controller) => Container(
        width: size.width / 1.1,
        child: ElevatedButton(
            // style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            onPressed: () async {
              /* if (importe.text.isEmpty || importe.text == '0') {
                return await showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        backgroundColor: Colors.black,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Alerta',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(Icons.warning_amber_rounded, color: Colors.red)
                          ],
                        ),
                        content: Text(
                          'Introduzca el importe',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    });
              } */
              if (formKeyImporte.currentState!.validate()) {
                Future.delayed(Duration(milliseconds: 200), () {
                  return showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text('Teclee su contraseña de pago.'),
                          content: Form(
                            key: formKeyPass,
                            child: TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(6),
                              ],
                              //controller: transferPass,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.numbers),
                                label: Text("Contraseña de Pago."),
                                border: OutlineInputBorder(),
                                hintText: "******",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Campo requerido";
                                }
                                if (value.length < 6) {
                                  return "La contraseña de pago debe tener 6 dígitos";
                                }
                                if (!GetUtils.isNumericOnly(value)) {
                                  return "La contraseña de pago debe contener solamente números";
                                }
                                return null;
                              },
                            ),
                          ),
                          actions: [
                            RoundedButton(
                                text: "Cancelar",
                                press: () {
                                  Get.back();
                                }),
                            RoundedButton(
                                text: "Aceptar",
                                press: () async {
                                  if (formKeyPass.currentState!.validate()) {
                                    Navigator.pop(context);
                                    return await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return FutureBuilder(
                                              future: createDonation(),
                                              builder: ((context,
                                                  AsyncSnapshot<
                                                          Either<Failure,
                                                              DonationModel>>
                                                      snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Loading(
                                                    text: "Cargando...",
                                                    backgroundColor: Colors
                                                        .lightBlue.shade700,
                                                    animationColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.lightBlue
                                                                .withOpacity(
                                                                    0.8)),
                                                    containerColor: Colors
                                                        .lightBlueAccent
                                                        .withOpacity(0.2),
                                                  );
                                                } else {
                                                  String textDonation = '';
                                                  /* final textDonation =
                                                  snapshot.data as String; */
                                                  snapshot.data!.fold((l) {
                                                    log('Este es el mensaje==> ${l.toString()}');
                                                    textDonation = l.toString();
                                                  }, (r) {
                                                    if (r.statusCode != '200' ||
                                                        r.statusCode == null) {
                                                      textDonation =
                                                          'Fallo al donar';
                                                    } else {
                                                      textDonation =
                                                          'Se ha donado satisfactoriamente';
                                                    }
                                                  });
                                                  return AlertDialog(
                                                    title: textDonation !=
                                                            'Se ha donado satisfactoriamente'
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Alerta',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Icon(
                                                                  Icons
                                                                      .warning_amber_rounded,
                                                                  color: Colors
                                                                      .red)
                                                            ],
                                                          )
                                                        : Container(),
                                                    backgroundColor: textDonation ==
                                                            'Se ha donado satisfactoriamente'
                                                        ? Colors.green
                                                        : Colors.black,
                                                    content: Text(
                                                      textDonation,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                }
                                              }));
                                        });
                                  }

                                  importe.text = '';
                                  paymentPassword.text =
                                      ''; /* await controller.createDonation();
                                Navigator.pop(context); */
                                }),
                          ],
                        );
                      });
                });
              }
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
                      'Aceptar',
                      style: TextStyle(
                          //color: Colors.black,
                          fontSize: size.width / 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                SizedBox(
                  height: size.height / 90,
                ),
              ],
            )),
      ),
    );
  }
}
