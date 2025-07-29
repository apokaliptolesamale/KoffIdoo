import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/app/modules/transaction/clientinvoice_exporting.dart';
import '../../../core/services/logger_service.dart';
import '../../../widgets/botton/rounded_button.dart';
import '../../../widgets/utils/size_constraints.dart';

class EtecsaFindClientIdView extends GetView<ClientInvoiceController> {
  EtecsaFindClientIdView({
    Key? key,
    this.contexto,
    this.textoToFindAccount,
    // required this.invoices,
  }) : super(key: key);

  BuildContext? contexto;
  TextEditingController findAccountText = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? textoToFindAccount = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConstraints sizeConst = SizeConstraints(context: context);
    contexto = context;
    return Scaffold(
        appBar: AppBar(
          titleSpacing: sizeConst.getHeightByPercent(-2),
          title: Text(
            "Buscar una cuenta",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: sizeConst.getWidthByPercent(5.5),
              color: Colors.white,
            ),
            textAlign: TextAlign.start,
          ),
          leading: IconButton(
              iconSize: 25,
              splashRadius: 25,
              onPressed: () {
                Get.back();
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
        body: Container(
            color: Colors.transparent,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    height: size.height / 8,
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   width: 50,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Identificador de pago:",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: sizeConst.getWidthByPercent(5),
                              color: Colors.black,
                            ),
                            //TextStyle(fontSize: 22),
                          ),
                        ),
                        // SizedBox(
                        //   width: 7,
                        // ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // alignment: Alignment.centerLeft,
                              width: sizeConst.getWidthByPercent(70),
                              color: Colors.transparent,
                              child: TextFormField(
                                controller: findAccountText,
                                onChanged: (texto) {
                                  textoToFindAccount = texto;

                                  // setState(() {
                                  //   color = Colors.blue;
                                  // });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Campo requerido";
                                  }
                                  if (value.trim().contains(" ")) {
                                    return "No puede contener espacios en blanco";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        findAccountText.clear();
                                      },
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintStyle: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          sizeConst.getWidthByPercent(3.5),
                                      color: Colors.grey,
                                    ),
                                    // TextStyle(
                                    //     fontSize: 20, color: Colors.grey[400]),
                                    hintText: "ID"),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      // height: 50,
                    ),
                  ),
                  RoundedButton(
                    color: Colors.blue,
                    // textColor: Colors.,
                    text: "Aceptar",
                    press: () {
                      if (formKey.currentState!.validate()) {
                        log("Me voy a mover");
                        // Get.to(() => FindAccountView());
                        // Get.toNamed("/transfer/findAccountPage");
                        // Get.to(
                        //     () =>
                        //         TransferAccountView(param: textoToFindAccount),
                        // setState(() {
                        //   // initState();
                        // });

                        log("Me movi");
                      } else {
                        // setState(() {
                        //   color = Colors.red;
                        // });
                      }
                      // CircularProgressIndicator();
                      // Get.to(Loading(
                      //   txt: "Buscando cuenta.",
                      //   style: TextStyle(color: Colors.amber),
                      // ));.

                      findAccountText.clear();
                    },
                  )
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (formKey.currentState!.validate()) {
                  //       log("Me voy a mover");
                  //       // Get.to(() => FindAccountView());
                  //       // Get.toNamed("/transfer/findAccountPage");
                  //       // Get.to(
                  //       //     () =>
                  //       //         TransferAccountView(param: textoToFindAccount),
                  //       Get.to(
                  //           () => TransferAccountView(
                  //               param: textoToFindAccount, contexto: contexto),
                  //           binding: TransferBinding());
                  //       log("Me movi");
                  //     }
                  //     // CircularProgressIndicator();
                  //     // Get.to(Loading(
                  //     //   txt: "Buscando cuenta.",
                  //     //   style: TextStyle(color: Colors.amber),
                  //     // ));.

                  //     findAccountText.clear();
                  //   },
                  //   child: Text("Aceptar"),
                  // )
                ],
              ),
            )));
  }
}
