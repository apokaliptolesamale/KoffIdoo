import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/app/modules/security/domain/models/profile_model.dart';
import '../../../../globlal_constants.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/services/manager_authorization_service.dart';
import '../../../widgets/dataview/option_widget.dart';
import '../../../widgets/utils/loading.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../controllers/account_controller.dart';
import '../controllers/security_controller.dart';
import '../domain/models/account_model.dart';
import 'ez_account_change_password_view.dart';
import 'ez_profile_email_privacity.dart';
import 'ez_profile_phone_privacity.dart';

desactivandoTotp(AccountController accountController) async {
  dartz.Either<Failure, AccountModel> resp =
      await accountController.disableToTPCode();

  resp.fold((l) {
    Get.back();
    Get.snackbar("Atencion!!!", l.toString());
  }, (r) {
    Get.back();

    Get.snackbar("Atencion!!!", "ToTP desactivado con exito.");
    accountController.update(["EzSecurityProfileView"]);
  });
}

class EzSecurityProfileView extends StatefulWidget {
  const EzSecurityProfileView({Key? key}) : super(key: key);

  @override
  _EzSecurityProfileViewState createState() => _EzSecurityProfileViewState();
}

class _EzSecurityProfileViewState extends State<EzSecurityProfileView> {
  bool swch = false;
  bool enable = false;
  AccountController controller = Get.find<AccountController>();
  var accountModel = Get.find<AccountModel>();

  // EzHomeController ctl = Get.find<EzHomeController>();
  SecurityController securityController = Get.find<SecurityController>();
  List<DropdownMenuEntry<dynamic>> dropdownMenuEntries = [];

  @override
  Widget build(BuildContext context) {
    // if (profileModel. == "true") {
    //   swch = true;
    // } else {
    //   swch = false;
    // }
    // print(accountModelToJson(accountModel));
    SizeConstraints size = SizeConstraints(context: context);
    return GetBuilder<AccountController>(
        id: "EzSecurityProfileView",
        builder: (context) {
          return FutureBuilder(
            future: getProfile(),
            builder: (context, snapshots) {
              if (!snapshots.hasData) {
                return Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                var profile = snapshots.data as ProfileModel;

                if (profile.secondFactor == "true") {
                  swch = true;
                  enable = true;
                } else {
                  swch = false;
                  enable = false;
                }
                return Scaffold(
                    appBar: AppBar(
                      titleSpacing: size.getHeightByPercent(-2),
                      title: Text(
                        "Seguridad y privacidad",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: size.getWidthByPercent(5.5),
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
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
                    //backgroundColor: Color.fromARGB(255, 236, 230, 230),
                    backgroundColor: Colors.white,
                    body: Container(
                      child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(15),
                                    child: const Text(
                                      "Seguridad",
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    )),
                                //Container(height: 0.3,color: Colors.grey,),

                                OptionWidget(
                                  rutaAsset:
                                      "assets/images/backgrounds/enzona/contrasena_de_pago.png",
                                  texto: "Cambiar contraseña ",
                                  icono: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.arrow_forward_ios,
                                      )),
                                  onPressed: () {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return EzAccountChangePasswordView();
                                        });
                                    // Get.to(()=>PasswordView());
                                  },
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                        // tileColor: Colors.amber,
                                        // tileColor: Colors.white,
                                        enabled: true,
                                        title: Text(
                                            "Segundo factor de autenticación",
                                            style: TextStyle(fontSize: 19)),
                                        trailing: Container(
                                            height: 50,
                                            width: 50,
                                            // color: Colors.red,
                                            alignment: Alignment.centerRight,
                                            child: Switch(
                                                value: swch,
                                                onChanged:
                                                    (bool valueIn) async {
                                                  setState(() {
                                                    swch = valueIn;
                                                    enable = valueIn;
                                                  });
                                                  if (swch == true) {
                                                    Get.toNamed(
                                                        "/security/ezprofileview/ezprofileconfig/ezsecurityProfileview/ezProfileTOTPView"
                                                        //EzProfileToTPCodeView()
                                                        );
                                                  } else {
                                                    showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (context) {
                                                          return Loading(
                                                            text:
                                                                "Desactivando ToTP...",
                                                            backgroundColor:
                                                                Colors.lightBlue
                                                                    .shade700,
                                                            animationColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors
                                                                        .lightBlue
                                                                        .withOpacity(
                                                                            0.8)),
                                                            containerColor: Colors
                                                                .lightBlueAccent
                                                                .withOpacity(
                                                                    0.2),
                                                          );
                                                        });
                                                    await desactivandoTotp(
                                                        controller);
                                                    controller.update([
                                                      "EzSecurityProfileView"
                                                    ]);
                                                    // swch = false;
                                                  }
                                                }))),
                                    ListTile(
                                      tileColor: Colors.white,
                                      enabled: enable,
                                      onTap: () {
                                        if (enable == false) {
                                        } else {
                                          Get.toNamed(
                                              "/security/ezprofileview/ezprofileconfig/ezsecurityProfileview/ezProfileTOTPView");
                                        }
                                      },
                                      title: Text(
                                        "Código de autenticación",
                                        style: TextStyle(
                                            fontSize: 19,
                                            color: enable == false
                                                ? Colors.grey
                                                : Colors.indigo),
                                      ),
                                      leading: Image.asset(
                                        'assets/images/backgrounds/enzona/codigo_qr.png',
                                        scale: 2.6,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                        padding: EdgeInsets.all(15),
                                        child: const Text(
                                          "Privacidad",
                                          textAlign: TextAlign.left,
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        )),
                                    // PopupMenuButton()
                                    OptionWidget(
                                      rutaAsset:
                                          "assets/images/backgrounds/enzona/telefono.png",
                                      texto: "Teléfono",
                                      icono: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                barrierDismissible: true,
                                                context: context,
                                                builder: (context) {
                                                  return EzPhonePrivacity();
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                          )),
                                      onPressed: () {
                                        showDialog(
                                            barrierDismissible: true,
                                            context: context,
                                            builder: (context) {
                                              return EzPhonePrivacity();
                                            });

                                        // Get.toNamed(Routes.DESARROLLO);
                                      },
                                    ),
                                    OptionWidget(
                                      rutaAsset:
                                          "assets/images/backgrounds/enzona/correo.png",
                                      texto: "Correo",
                                      icono: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                barrierDismissible: true,
                                                context: context,
                                                builder: (context) {
                                                  return EzEmailPrivacity();
                                                });
                                          },
                                          //=> Get.toNamed('/desarrollo'),
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                          )),
                                      onPressed: () {
                                        showDialog(
                                            barrierDismissible: true,
                                            context: context,
                                            builder: (context) {
                                              return EzEmailPrivacity();
                                            });
                                        // Get.toNamed(Routes.DESARROLLO);
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ]),
                    ));
              }
            },
          );
        });
  }

  // Widget? body;

  getProfile() async {
    final mas = ManagerAuthorizationService().get(defaultIdpKey);
    ProfileModel? profile =
        mas!.getUserSession().getBy<ProfileModel>("profile");
    // var forRead = await LocalSecureStorage.storage.read("identity_profile");
    // var profile = profileModelFromJson(forRead!);
    return profile;
  }
}
