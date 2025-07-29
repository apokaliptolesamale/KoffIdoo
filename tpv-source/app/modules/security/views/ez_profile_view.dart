import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/app/core/services/logger_service.dart';
import '/app/core/services/paths_service.dart';
import '../../../core/services/local_storage.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/dataview/option_widget.dart';
import '../../../widgets/utils/loading.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../../card/bindings/card_binding.dart';
import '../../card/views/card_view.dart';
import '../../home/controllers/ez_home_controller.dart';
import '../../transaction/bindings/transaction_binding.dart';
import '../domain/models/account_model.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/my_qr_window.dart';
import 'ez_profile_destinatarios_view.dart';

class EzProfileInfo extends GetView<EzHomeController> {
  String? mensaje = "";

  late AccountModel? account;
  EzProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    // account = Get.lazyPut(() => AccountModel());
    // account = Get.find<AccountModel>();
    return FutureBuilder(
        future: getAccount(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading(
              text: "Esperando info de la cuenta...",
              backgroundColor: Colors.transparent,
              animationColor: AlwaysStoppedAnimation<Color>(
                  Colors.lightBlue.withOpacity(0.8)),
              containerColor: Colors.transparent,
            );
          } else {
            account = snapshot.data as AccountModel;
            // snapshot.data!.fold((l) {
            //   mensaje = l.message;
            // }, (r) {
            //   Get.put<AccountModel>(r);
            //   account = r;
            // });
            // profileE.Profile profile = snapshot.data as profileE.Profile;
            return mensaje == ""
                ? SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                                backgroundColor: Colors.lightBlue[300],
                                radius: size.getHeightByPercent(5.5),
                                child: account!.avatar != ""
                                    ? CircleAvatar(
                                        onBackgroundImageError:
                                            (exception, stackTrace) {
                                          Icon(Icons.person_rounded);
                                        },
                                        backgroundColor: Colors.blue,
                                        radius: size.getHeightByPercent(5),
                                        backgroundImage: NetworkImage(
                                          "${PathsService.mediaHost}"
                                          "${account!.avatar}",
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: size.getHeightByPercent(5),
                                        child: Icon(
                                          Icons.person_rounded,
                                          size: 80.0,
                                        ),
                                      )),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 50,
                        ),
                        Flexible(
                          child: Container(
                            // color: Colors.amber,
                            // height: MediaQuery.of(context).size.height / 6,
                            // width: MediaQuery.of(context).size.width / 2,
                            width: size.getWidthByPercent(70),
                            height: size.getHeightByPercent(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                //  FittedBox(
                                /*child:*/ Text(
                                  "${account!.name}"
                                  " ${account!.lastname} ",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.getWidthByPercent(4),
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.start,
                                  // style: TextStyle(
                                  //     color: Colors.white, fontSize: 18),
                                ),

                                SizedBox(
                                  height: 5,
                                ),
                                //  ),
                                Text(
                                  account!.username,

                                  style: GoogleFonts.roboto(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: size.getWidthByPercent(4),
                                    color: Colors.grey[400],
                                  ),
                                  textAlign: TextAlign.start,
                                  // style: TextStyle(
                                  //     color: Colors.grey[400], fontSize: 16)
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  account!.phone.toString(),
                                  style: GoogleFonts.roboto(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: size.getWidthByPercent(4),
                                    color: Colors.grey[400],
                                  ),
                                  textAlign: TextAlign.start,

                                  // style: TextStyle(
                                  //     color: Colors.grey[400], fontSize: 16)
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 10,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: IconButton(
                              color: Colors.white,
                              // splashRadius: 20.0,
                              // alignment: Alignment.center,
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                Get.to("/security/ezprofileview/ezprofileinfo");
                              },
                            ),
                          ),
                        ),
                        // Flexible(
                        //   child: Container(
                        //     color: Colors.red,
                        //     width: size.getWidthByPercent(10),
                        //     height: size.getHeightByPercent(15),
                        //     // margin: EdgeInsets.only(right: 10),
                        //     alignment: Alignment.centerRight,
                        //     child:
                        //     IconButton(
                        //       color: Colors.white,
                        //       // splashRadius: 20.0,
                        //       icon: Icon(Icons.arrow_forward_ios),
                        //       onPressed: () {
                        //         Get.toNamed("/security/ezprofileview/ezprofileinfo");
                        //       },
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                    mensaje!,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: size.getWidthByPercent(4),
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ));
          }
        });
  }

  Future<AccountModel> getAccount() async {
    EzHomeController ezHomeController = controller;
    AccountModel? tmp;
    // controller.getAccount.setParamsFromMap({});
    // return await controller.getFutureByUseCase(controller.getAccount);
    // final storage = FlutterSecureStorage();
    if (!Get.isRegistered<AccountModel>()) {
      // var aux = await ezHomeController.getAccountModel();
      var aux = await ezHomeController.getAccountModel();
      // Get.put<Either<Failure, AccountModel>>(aux);
      aux.fold((l) {
        mensaje = l.message;
      }, (r) {
        Get.put<AccountModel>(r);
        tmp = r;
        // return tmp;
      });
      log("La busque en el Api");

      // aux.fold((l) {
      //   mensaje = l.message;
      //   return mensaje;
      // }, (r) {
      //   account = r;
      //   return account;
      // });
    } else {
      var aux = Get.find<AccountModel>();
      log("La busque en GetX");
      tmp = aux;
    }
    return tmp!;

    // var tmp = await LocalSecureStorage.storage.existsOnSecureStorage("account");
    // if (tmp.toString() == "true" && !Get.isRegistered<AccountModel>()) {
    //   var account = await LocalSecureStorage.storage.read("account");
    //   var aux = accountModelFromJson(account!);

    //   Get.put<AccountModel>(aux);

    //   log("La busque en el local");
    //   return aux;
    // } else if (!Get.isRegistered<AccountModel>()) {
    //   var aux = await ezHomeController.getAccountModel();
    //   log("La busque en el Api");
    //   return aux;
    // } else {
    // }
  }
}

class EzProfileView extends GetView<EzHomeController> {
  const EzProfileView({Key? key}) : super(key: key);

  // Widget loadProfileData() {
  //   return DatosPerfilView();
  // }

  @override
  Widget build(BuildContext context) {
    // AccountBinding accountBinding = Get.put(AccountBinding());
    //AccountController accountController = Get.find<AccountController>();
    //EzHomeController ezHomeController = Get.find<EzHomeController>();
    SizeConstraints size = SizeConstraints(context: context);
    // accountBinding.dependencies();
    return Container(
      color: Colors.white,
      child: Column(children: [
        MainAppBar(
          size: size,
          widgets: [
            LogoEZ(size: size),
            GestureDetector(
                onTap: () {
                  // Get.toNamed("/security/ezprofileview/ezprofileinfo");
                  Get.toNamed(
                      Routes.getInstance.getPath("SECURITY_EZPROFILE_INFO"));
                  // Get.to(EzProfileInfoView(), binding: AccountBinding());
                },
                child: EzProfileInfo())
          ],
        ),
        Expanded(
            flex: 5,
            child: ListView(children: [
              OptionWidget(
                rutaAsset: 'assets/images/backgrounds/enzona/transacciones.png',
                texto: 'Transacciones',
                icono: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  TransactionBinding.loadPages();
                  final named = Routes.getInstance.getPath("TRANSACTIONS");
                  Get.toNamed(named);
                  /* Get.to(() => TransactionsWidget(),
                      binding: TransactionBinding());*/
                },
              ),
              OptionWidget(
                rutaAsset: 'assets/images/backgrounds/enzona/tarjeta_azul.png',
                texto: 'Tarjetas de banco',
                icono: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  //Get.toNamed(Routes.getInstance.getPath("CARD"));
                  Get.to(() => CardView(), binding: CardBinding());
                },
              ),
              OptionWidget(
                rutaAsset: 'assets/images/backgrounds/enzona/cuenta.png',
                texto: 'Destinatarios',
                icono: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Get.to(
                    () => EzProfileDestinatarioView(),
                  );
                },
              ),
              //const SizedBox(height: 50,),
              OptionWidget(
                rutaAsset: 'assets/images/backgrounds/enzona/codigo_qr.png',
                texto: 'Mi código QR',
                icono: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  // Get.to(() => MyQrWindow());
                  showDialog(
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.8),
                      context: context,
                      builder: (context) {
                        return MyQrWindow();
                      });
                },
              ),
              OptionWidget(
                rutaAsset: 'assets/images/backgrounds/enzona/configuracion.png',
                texto: 'Configuración',
                icono: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  // Get.offAndToNamed("/configview");
                  // Get.to(ConfigView());
                  Get.toNamed("/security/ezprofileview/ezprofileconfig");
                },
              ),
              OptionWidget(
                rutaAsset: 'assets/images/backgrounds/enzona/cerrar.png',
                texto: 'Cerrar Sesión',
                // icono: const Icon(Icons.arrow_forward_ios),
                onPressed: () async {
                  // await controller.logout();
                  LocalSecureStorage.storage.deleteAll();
                  Get.deleteAll();
                  Get.offAndToNamed("/security");
                },
              ),
            ]))
      ]),
    );
  }
}
