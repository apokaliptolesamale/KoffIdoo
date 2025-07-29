import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/config/errors/errors.dart';
import '../../../widgets/botton/rounded_button.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../domain/entities/transfer.dart';
import '../domain/models/transfer_model.dart';
import 'transfer_to_account_pass_view.dart';
import 'transfer_to_card_pass_view.dart';

typedef FunctionToTransfer = Function(Transfer, Map<String, dynamic>);

class TransferAlertView extends StatelessWidget {
  // Future<dynamic> function;
  // Account? accountt;
  Map<String, dynamic>? params;
  Either<Failure, TransferModel>? tmp;
  Transfer? transfer;
  BuildContext contexto;
  String? movilToConfirm;
  String? nombre;
  String? pan;
  // String? phone;
  String? cardNumber;
  String? parsedAmount;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // FunctionToTransfer func;
  TransferAlertView(
      {
      // required this.function,
      required this.params,
      // required this.func,
      this.nombre,
      this.pan,
      this.cardNumber,
      // this.phone,
      this.parsedAmount,
      this.movilToConfirm,
      required this.contexto});

  @override
  Widget build(BuildContext context) {
    SizeConstraints sizeConst = SizeConstraints(context: context);
    return AlertDialog(
      title: Text(
        "Alerta",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.bold,
          fontSize: sizeConst.getWidthByPercent(5),
          color: Colors.red,
        ),
        // TextStyle(color: Colors.red),
      ),
      content: Container(
        child: Text.rich(TextSpan(
                text: "¿Esta seguro que desea transferir ",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: sizeConst.getWidthByPercent(4),
                  color: Colors.black,
                ),
                children: [
              TextSpan(
                text: parsedAmount,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: sizeConst.getWidthByPercent(4),
                  color: Colors.red,
                ),
              ),
              nombre == null || nombre == ""
                  ? TextSpan(
                      text: " CUP a la tarjeta ",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: sizeConst.getWidthByPercent(4),
                        color: Colors.black,
                      ),
                    )
                  : TextSpan(
                      text: " CUP a la cuenta de ",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: sizeConst.getWidthByPercent(4),
                        color: Colors.black,
                      ),
                    ),
              nombre == null || nombre == ""
                  ? TextSpan(
                      text: "$pan",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: sizeConst.getWidthByPercent(4),
                        color: Colors.red,
                      ),
                    )
                  : TextSpan(
                      text: "$nombre",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: sizeConst.getWidthByPercent(4),
                        color: Colors.red,
                      ),
                    ),
              TextSpan(
                text: "?",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: sizeConst.getWidthByPercent(4),
                  color: Colors.black,
                ),
              ),
            ])
            // "¿Esta seguro que desea transferir $parsedAmount CUP a la tarjeta $pan?",

            ),
      ),
      actions: [
        RoundedButton(
            text: "Cancelar",
            press: () {
              // Get.toNamed("/home");
              Get.back();

              // transferController.noTarjeta.clear();
              // transferController.importe.clear();
              // transferController.confirmCel.clear();
              // transferController.description.clear();
              // transferController.transferPass.clear();
            }),
        RoundedButton(
            text: "Aceptar",
            press: () async {
              Get.back();
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    // transferPass.clear();
                    return movilToConfirm == null
                        ? TransferToAccountPassView(
                            params: params,
                            contexto: contexto,
                          )
                        : TransferToCardPassView(
                            contexto: contexto,
                            params: params,
                            movilToConfirm: movilToConfirm!,
                            pan: pan,
                            // function: transferController.transferCard(),
                          );
                  });
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
              //     l.toString();
              //     Get.back();

              //     return AlertDialog(
              //       title: Text("Error"),
              //       content: Text(l.toString()),
              //     );
              //   }, (r) {
              //     transfer = r as Transfer;
              //   });
              // } else if (tmp.isRight()) {
              //   tmp.fold((l) {
              //     l.toString();
              //     showDialog(
              //         barrierDismissible: false,
              //         context: context,
              //         builder: (context) {
              //           return AlertDialog(
              //             title: Text("Error"),
              //             content: Text(l.toString()),
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
}
