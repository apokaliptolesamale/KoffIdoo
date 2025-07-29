import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/services/logger_service.dart';
import '../../../widgets/botton/rounded_button.dart';
import '../../../widgets/utils/loading.dart';
import '../../security/controllers/account_controller.dart';
import '../controllers/transfer_controller.dart';
import '../domain/entities/transfer.dart';
import '../domain/models/transfer_model.dart';
import 'transfer_to_account_detail_view.dart';

typedef FunctionToTransfer = Function(Transfer, Map<String, dynamic>);

class TransferToAccountPassView extends StatelessWidget {
  // Future<dynamic> function;
  // Account? accountt;
  Map<String, dynamic>? params;
  Either<Failure, TransferModel>? tmp;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Transfer? transfer;
  BuildContext? contexto;
  TextEditingController transferPass = TextEditingController();
  String passTransfer = "";

  // FunctionToTransfer func;
  TransferToAccountPassView(
      {
      // required this.function,
      required this.params,
      // required this.func,
      this.contexto});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Teclee su contraseña de pago."),
      content: Form(
        key: formKey,
        child: TextFormField(
          obscureText: true,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          controller: transferPass,
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
          onChanged: (texto) {
            passTransfer = texto;
          },
        ),
      ),
      actions: [
        RoundedButton(
            text: "Cancelar",
            press: () {
              // Get.toNamed("/home");
              Get.back();
              transferPass.clear();
              // transferController.noTarjeta.clear();
              // transferController.importe.clear();
              // transferController.confirmCel.clear();
              // transferController.description.clear();
              // transferController.transferPass.clear();
            }),
        RoundedButton(
            text: "Aceptar",
            press: () async {
              if (formKey.currentState!.validate()) {
                Get.back();
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Loading(
                        text: "Esperando resultado de su transferencia...",
                        backgroundColor: Colors.lightBlue.shade700,
                        animationColor: AlwaysStoppedAnimation<Color>(
                            Colors.lightBlue.withOpacity(0.8)),
                        containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                      );
                    });
                await transferToAccount();
                await forValidate(tmp, contexto!);
              }
              // transferController.errorText = "";
              // await Future.delayed(Duration(milliseconds: 200), () {
              // transferController.noTarjeta.clear();
              // transferController.importe.clear();
              // transferController.confirmCel.clear();
              // transferController.description.clear();
              // transferController.transferPass.clear();
              //   Get.to(TransferDetailsView());

              // });

              // if (tmp.isLeft()) {
              //   tmp.fold((l) {
              //     l.message;
              //     Get.back();

              //     return AlertDialog(
              //       title: Text("Error"),
              //       content: Text(l.message),
              //     );
              //   }, (r) {
              //     transfer = r as Transfer;
              //   });
              // } else if (tmp.isRight()) {
              //   tmp.fold((l) {
              //     l.message;
              //     showDialog(
              //         barrierDismissible: false,
              //         context: context,
              //         builder: (context) {
              //           return AlertDialog(
              //             title: Text("Error"),
              //             content: Text(l.message),
              //           );
              //         });
              //   }, (r) {
              //     transfer = r as Transfer;
              //     Get.to(() => TransferDetailsView(
              //           transfer: transfer,
              //           isVerified: transfer!.recipient.verified!,
              //         ));
              //   });
              // }
            })
      ],
    );
  }

  forValidate(
      Either<Failure, TransferModel>? tmp, BuildContext contexto) async {
    tmp!.fold((l) {
      l.toString();

      Get.back();
      // return AlertDialog(
      //   title: Text("Error!!!"),
      //   content: Text(l.toString()),
      // );
      Get.defaultDialog(middleText: l.toString());
      // showDialog(
      //     context: contexto,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: Text("Error!!!"),
      //         content: Text(l.toString()),
      //       );
      //     });
    }, (r) {
      transfer = r;
      Navigator.pushReplacement(
        contexto,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => TransferAccountDetailsView(
            contexto: contexto,
            transfer: transfer,
            isVerified: transfer!.recipient.verified!,
            // isVerified: ,
            // transfer: r,
            // contexto: contexto,
            // recipientBank: transfer!.recipient.bank,
            // createAt: transfer!.createAt,
            // currency: transfer!.currency,
            // description: transfer!.description,
            // monto: transfer!.amount,
            // movilToConfirm: movilToConfirm,
            // uncipherPan: pan!,
            // operationNumber: transfer!.transactionSignature,
            // sourceBank: transfer!.source.bank,
            // sourceLast4: transfer!.source.last4,
            // transferStatus: transfer!.statusDenom,
          ),
        ),
      );
      // Get.to(() => TransferAccountDetailsView(
      //       transfer: transfer,
      //       isVerified: transfer!.recipient.verified!,
      //     ));
    });
    // if (tmp!.isLeft()) {
    //   // Get.back();
    //   tmp!.fold((l) {
    //     l.toString();
    //     showDialog(
    //         context: context,
    //         builder: (context) {
    //           return AlertDialog(
    //             title: Text("Error!!!"),
    //             content: Text(l.toString()),
    //           );
    //         });
    //     // Get.off(TransferOptionsView());
    //     // Get.snackbar(
    //     //   "Error!!!",
    //     //   l.toString(),
    //     //   backgroundColor: Colors.red,
    //     //   onTap: (snack) {
    //     //     snack.isDismissible;
    //     //   },
    //     // );
    //     // transfer!.statusDenom = "Fallida";
    //     // transfer!.amount = params!["amount"];
    //     // transfer!.recipientUsername = params!["funding_recipient_username"];
    //     // Get.to(() => TransferDetailsView(
    //     //       transfer: transfer,
    //     //       isVerified: transfer!.recipient.verified!,
    //     //     ));
    //     // Get.back();
    //     AlertDialog(
    //       title: Text("Error!!!"),
    //       content: Text(l.toString()),
    //     );
    //     // showDialog(
    //     //     barrierDismissible: false,
    //     //     context: context,
    //     //     builder: (context) {
    //     //       return AlertDialog(
    //     //         title: Text("Error!!!"),
    //     //         content: Text(l.toString()),
    //     //       );
    //     //     });
    //     // return AlertDialog(
    //     //   title: Text("Error!!!"),
    //     //   content: Text(l.toString()),
    //     // );
    //   }, (r) {
    //     transfer = r as Transfer;
    //     return AlertDialog(
    //       title: Text(transfer!.recipientUsername),
    //       content: Text(transfer!.statusDenom),
    //     );
    //   });
    // } else if (tmp!.isRight()) {
    //   tmp!.fold((l) => null, (r) {
    //     transfer = r as Transfer;
    //     Get.to(() => TransferDetailsView(
    //           transfer: transfer,
    //           isVerified: transfer!.recipient.verified!,
    //         ));
    //   });
    // }
  }

  // Future<Either<Failure, TransferModel>>
  transferToAccount() async {
    AccountController accountController = Get.find<AccountController>();
    TransferController transferController = Get.find<TransferController>();
    // Either<Failure, TransferModel> tmp;

    var payPass = await accountController.cifrar(passTransfer);
    var forParams = <String, String>{"payment_password": payPass};
    params!.addEntries(forParams.entries);
    log("ESTE ES PARAMS EN TRANSFERPASS>>>>>>>>>>>>>>>$params");
    transferController.transferToAccountUseCase.setParamsFromMap(params!);
    tmp = await transferController.transferToAccount();

    return tmp!;
  }
}
