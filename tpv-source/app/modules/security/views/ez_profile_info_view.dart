import 'dart:convert' as dartConvert;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../globlal_constants.dart';
import '../../../core/services/logger_service.dart';
import '../../../core/services/manager_authorization_service.dart';
import '../../../core/services/paths_service.dart';
import '../../../widgets/dataview/custom_list_title.dart';
import '../../../widgets/utils/loading.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../../home/controllers/ez_home_controller.dart';
import '../../security/domain/entities/account.dart' as accountA;
import '../controllers/account_controller.dart';
import '../domain/models/account_model.dart';
import '../domain/models/profile_model.dart';
import '../widgets/main_app_bar.dart';
import 'ez_profile_edit_view.dart';

updateAvatar(BuildContext context, Map<String, dynamic> params,
    AccountController accountController) async {
  accountController.updateAccount.setParamsFromMap(params);
  return await accountController
      .getFutureByUseCase(accountController.updateAccount);
}

class AccountDataInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    return Align(
      alignment: Alignment.center,
      // top: 50.0,
      // bottom: 80.0,
      // left: 50,
      // right: 50,
      child: Container(
        // color: Colors.amber,
        height: size.getHeightByPercent(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                // color: Colors.red,
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios, size: 30, color: Colors.white),
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        "Atrás",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Get.to(EditarDatosView());

                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return EzProfileInfoEditView();
                    });
              },
              child: Container(
                // color: Colors.green,
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        "Editar",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Icon(Icons.edit_rounded, size: 30, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountListTile extends StatelessWidget {
  accountA.Account? account;

  AccountListTile({this.account});

  @override
  Widget build(BuildContext context) {
    //  ProfileController profileController =  Get.put(SecurityLocalDataSourceImpl(FlutterSecureStorage()));
    // SecurityLocalDataSource localDataSource =
    //     Get.put(SecurityLocalDataSourceImpl(FlutterSecureStorage()));
    return GetBuilder<AccountController>(builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            // color: Colors.green,
            child: CustomListTitleWidget(
              rutaAsset: 'assets/images/backgrounds/enzona/correo.png',
              texto: 'Correo',
              subtexto: Text(
                  // "agurri@xetid.cu"
                  account!.email),
            ),
          ),
          Card(
            child: CustomListTitleWidget(
              rutaAsset: 'assets/images/backgrounds/enzona/telefono.png',
              texto: 'Teléfono',
              rutaAssetTrailing: account!.verifiedPhone == "1"
                  ? "assets/images/icons/app/enzona/confir.png"
                  : null,
              subtexto: Text(
                  // "53875958"
                  account!.phone),
            ),
          ),
          Card(
            child: CustomListTitleWidget(
              rutaAsset: 'assets/images/backgrounds/enzona/direccion.png',
              texto: 'Dirección',
              subtexto: Text(
                  // "Calle 40 entre Avenida 1ra y Avenida 3ra, número 112(int), Miramar, Playa, La Habana, Cuba."
                  account!.address),
            ),
          ),
          Card(
            child: CustomListTitleWidget(
              rutaAsset:
                  'assets/images/backgrounds/enzona/verificar_identidad.png',
              texto: 'Carnet de Identidad',
              subtexto: Text(
                  // "97090108788"
                  account!.identification),
            ),
          ),
          Card(
            child: CustomListTitleWidget(
              rutaAsset: 'assets/images/backgrounds/enzona/sexo.png',
              texto: "Sexo",
              subtexto: account!.gender == "M"
                  ? Text("Masculino(${account!.gender})")
                  : Text("Femenino(${account!.gender})"),
            ),
          ),
          FutureBuilder(
              future: getProfile(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                  // return Center(
                  //   child: CircularProgressIndicator(),
                  // );
                  // return CustomListTitleWidget(
                  //   rutaAsset: 'assets/images/backgrounds/enzona/fecha.png',
                  //   texto: 'Fecha de nacimiento',
                  //   subtexto: Text("1-09-1997"
                  //       // ${profileModel.birthday.toString().substring(0, 10)}"
                  //       ),
                  // );
                } else {
                  // profileE.Profile profile = snapshot.data as profileE.Profile;
                  var profileModel = snapshot.data as ProfileModel;
                  return Card(
                    child: CustomListTitleWidget(
                      rutaAsset: 'assets/images/backgrounds/enzona/fecha.png',
                      texto: 'Fecha de nacimiento',
                      subtexto: Text(
                          profileModel.birthday.toString().substring(0, 10)),
                    ),
                  );
                }
              })
          // FutureBuilder(
          //     future: accountController.getProfileModel(),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData) {
          //         return CircularProgressIndicator();
          //         // return Center(
          //         //   child: CircularProgressIndicator(),
          //         // );
          //         // return CustomListTitleWidget(
          //         //   rutaAsset: 'assets/images/backgrounds/enzona/fecha.png',
          //         //   texto: 'Fecha de nacimiento',
          //         //   subtexto: Text("1-09-1997"
          //         //       // ${profileModel.birthday.toString().substring(0, 10)}"
          //         //       ),
          //         // );
          //       } else {
          //         // profileE.Profile profile = snapshot.data as profileE.Profile;
          //         var profileModel = snapshot.data as ProfileModel;
          //         return Card(
          //           child: CustomListTitleWidget(
          //             rutaAsset: 'assets/images/backgrounds/enzona/fecha.png',
          //             texto: 'Fecha de nacimiento',
          //             subtexto: Text(
          //                 "${profileModel.birthday.toString().substring(0, 10)}"),
          //           ),
          //         );
          //       }
          //     })
        ],
      );
    });
  }

  getProfile() async {
    final mas = ManagerAuthorizationService().get(defaultIdpKey);
    ProfileModel? profile =
        mas!.getUserSession().getBy<ProfileModel>("profile");
    // var forRead = await LocalSecureStorage.storage.read("identity_profile");
    // var profile = profileModelFromJson(forRead!);
    return profile;
  }
}

class AvatarEZ extends StatefulWidget {
  String? avatar = "";

  AvatarEZ({
    Key? key,
    // required this.size,
    this.avatar,
  }) : super(key: key);

  // final SizeConstraints size;

  @override
  State<AvatarEZ> createState() => _AvatarEZState();
}

class EzProfileInfoView extends GetView<AccountController> {
  String mensaje = "";
  late AccountModel? account;

  @override
  Widget build(BuildContext context) {
    var contexto = context;
    account = Get.find<AccountModel>();
    // EzHomeController ezHomeController = Get.find<EzHomeController>();
    // AccountController accountController = Get.find<AccountController>();
    SizeConstraints size = SizeConstraints(context: context);
    return GetBuilder<AccountController>(
        id: "InfoView",
        builder: (context) {
          return FutureBuilder(
              future: getLocalAccount(),
              builder: (context, snapshots) {
                if (!snapshots.hasData) {
                  return Loading(
                    text: "Esperando datos de la cuenta...",
                    backgroundColor: Colors.lightBlue.shade700,
                    animationColor: AlwaysStoppedAnimation<Color>(
                        Colors.lightBlue.withOpacity(0.8)),
                    containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                  );
                } else {
                  account = snapshots.data as AccountModel;
                  // snapshots.data!.fold((l) {
                  //   mensaje = l.message;
                  // }, (r) {
                  //   Get.put<AccountModel>(r);
                  //   account = r;
                  // });
                  //  profileE.Profile profile = snapshots.data as profileE.Profile;
                  // Account account = snapshots.data as Account;

                  return GetBuilder<AccountController>(builder: (builder) {
                    return mensaje == ""
                        ? Scaffold(
                            body: Container(
                              color: Colors.transparent,
                              child: Column(children: [
                                MainAppBar(
                                  size: size,
                                  widgets: [
                                    AvatarEZ(
                                      // size: size,
                                      avatar: account!.avatar,
                                    ),
                                    AccountDataInfo(),
                                    /* Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                       backgroundColor: Colors.white70,
                       radius: size.getHeightByPercent(7),
                      child: CircleAvatar(
                        radius: size.getHeightByPercent(6),
                      ),
                    ),
                    ),*/
                                  ],
                                ),
                                Container(
                                  // color: Colors.red,
                                  // margin: EdgeInsets.only(top: 50),
                                  height: MediaQuery.of(context).size.width / 6,
                                  width: double.maxFinite,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          // "Andres"
                                          // " Gurri Naranjo ",
                                          "${account!.name} "
                                          "${account!.lastname}",
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.getWidthByPercent(5),
                                            // color: Colors.white.withOpacity(0.8),
                                          ),
                                          // TextStyle(
                                          //     fontSize: 18,
                                          //     color: Colors.black,
                                          //     decoration: TextDecoration.none,
                                          //     decorationStyle:
                                          //         TextDecorationStyle.solid),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              100,
                                        ),
                                        Text(
                                          // "anaranjo",
                                          "${account!.username} ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              decoration: TextDecoration.none,
                                              decorationStyle:
                                                  TextDecorationStyle.solid),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: ListView(
                                    children: [
                                      AccountListTile(
                                        account: account,
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          )
                        : Center(
                            child: Text(
                              mensaje,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: size.getWidthByPercent(4),
                                color: Colors.black,
                              ),
                            ),
                          );
                  });
                }
              });
        });
  }

  Future<AccountModel> getLocalAccount() async {
    late AccountModel? tmp;
    // controller.getAccount.setParamsFromMap({});
    // return await controller.getFutureByUseCase(controller.getAccount);
    // final storage = FlutterSecureStorage();
    if (!Get.isRegistered<AccountModel>()) {
      EzHomeController ezHomeController = Get.find<EzHomeController>();
      // var aux = await ezHomeController.getAccountModel();
      log("La busque en el Api");
      var aux = await ezHomeController.getAccountModel();
      // Get.put<dartz.Either<Failure, AccountModel>>(aux);
      aux.fold((l) {
        mensaje = l.message;
      }, (r) {
        Get.put<AccountModel>(r);
        tmp = r;
        // return tmp;
      });
      // aux.fold((l) {
      //   mensaje = l.message;
      //   return mensaje;
      // }, (r) {
      //   account = r;
      //   return account;
      // });
    } else {
      tmp = Get.find<AccountModel>();
      log("La busque en GetX");
      tmp;
    }
    return tmp!;
    // var accountModel = Get.find<AccountModel>();
    // var temp =
    //     await LocalSecureStorage.storage.existsOnSecureStorage("account");
    // if (temp.toString() == "false") {
    //   var cuenta = await getAccount.call(null);
    //   final dartz.Right resultData = cuenta as dartz.Right;
    //   if (!Get.isRegistered<AccountModel>()) {
    //     Get.put<AccountModel>(resultData.value);
    //     log("GUARDO LA CUENTA EN GETX x si no lo ha hecho");
    //   }
    //   final aux = resultData.value as Account;
    //   // update(["InfoView"]);
    //   return aux;
    // } else {
    //   if (!Get.isRegistered<AccountModel>()) {
    //     Either<Failure, AccountModel> cuenta = await getAccount.call(null);
    //     cuenta.fold((l) {
    //       Get.snackbar("Atencion!!!", "Problemas al cargar su cuenta");
    //     }, (r) {
    //       Get.put<AccountModel>(r);
    //       log("GUARDO LA CUENTA EN GETX x si no lo ha hecho");
    //     });
    //   }
    //   var aux = Get.find<AccountModel>();
    //   // await LocalSecureStorage.storage.read("account");
    //   log("ESTE ES ACCOUNTMODEL GUARDADO EN GETX EN GETLOCALACCOUNT DE ACCOUNTCONTROLLER${accountModelToJson(aux)}");
    //   // log("Arriba de GETX y ABAJO DEL LOCALSECURESTORAGE");
    //   log("ESTE ES AUX DEL LOCALSTORE EN GETLOCALACCOUNT$aux");
    //   // var tmp = accountModelFromJson(aux!);
    //   // update(["InfoView"]);
    //   return aux;
    // }

    // var aux = await LocalSecureStorage.storage.read("account");
    // var tmp = accountModelFromJson(aux!);
    // // update(["InfoView"]);
    // return tmp;
    // var test = Get.find<Account>(tag: aux);
    // log("ESTE ES TEST>>>>>>>>>>>>>>>>$test");
  }
}

class SelectAvatar extends StatefulWidget {
  @override
  State<SelectAvatar> createState() => _SelectAvatarState();
}

class _AvatarEZState extends State<AvatarEZ> {
  String? avatarState = "";
  bool errorOcurred = false;
  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: avatarState == "" && errorOcurred == true
          ? Stack(
              // fit: StackFit.expand,
              children: <Widget>[
                CircleAvatar(
                  radius: size.getWidthByPercent(11),
                  backgroundColor: Colors.lightBlue[300],
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'assets/images/backgrounds/enzona/im_foto_usuario.png',
                        width: size.getWidthByPercent(20),
                      )),
                ),
                Positioned(
                    right: 8,
                    top: 50,
                    height: MediaQuery.of(context).size.height / 25,
                    width: MediaQuery.of(context).size.height / 25,
                    child: Container(
                      // height: 500,
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return SelectAvatar();
                              });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: size.getWidthByPercent(11),
                          child: CircleAvatar(
                            radius: size.getWidthByPercent(4),
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: size.getHeightByPercent(3),
                              color: Colors.white,
                              // 'assets/photo-camera.png',
                              // width: 20.9,
                              // height: 19.9,
                            ),
                          ),
                        ),
                      ),
                    )),
                // Padding(
                //   padding: const EdgeInsets.all(2.0),
                //   child: Icon(Icons.camera
                //       // 'assets/photo-camera.png',
                //       // width: 20.9,
                //       // height: 19.9,
                //       ),
                // ),
              ],
            )
          : Stack(
              // fit: StackFit.passthrough,
              children: <Widget>[
                CircleAvatar(
                  radius: size.getWidthByPercent(11),
                  backgroundColor: Colors.lightBlue[300],
                  // foregroundColor: Colors.amber,
                  child: CircleAvatar(
                    radius: size.getWidthByPercent(10),
                    backgroundImage: NetworkImage("${PathsService.mediaHost}"
                        "$avatarState"),
                    onBackgroundImageError: (exception, stackTrace) {
                      setState(() {
                        errorOcurred = !errorOcurred;
                      });
                    },
                  ),
                ),
                Positioned(
                    right: 8,
                    top: 50,
                    height: MediaQuery.of(context).size.height / 25,
                    width: MediaQuery.of(context).size.height / 25,
                    child: Container(
                      // height: 500,
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return SelectAvatar();
                              });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: size.getWidthByPercent(11),
                          child: CircleAvatar(
                            radius: size.getWidthByPercent(4),
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: size.getHeightByPercent(3),
                              color: Colors.white,
                              // 'assets/photo-camera.png',
                              // width: 20.9,
                              // height: 19.9,
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
    );
    // ? CircleAvatar(
    //     radius: widget.size.getWidthByPercent(8),
    //     backgroundColor: Colors.blue[800],
    //     child: Padding(
    //         padding: const EdgeInsets.all(5.0),
    //         child: Image.asset(
    //             'assets/images/backgrounds/enzona/im_foto_usuario.png')),
    //   )
    // : CircleAvatar(
    //     radius: widget.size.getWidthByPercent(8),
    //     backgroundColor: Colors.blue[800],
    //     foregroundColor: Colors.amber,
    //     backgroundImage: NetworkImage("${PathsService.mediaHost}"
    //         "$avatarState"),
    //     onBackgroundImageError: (exception, stackTrace) {
    //       setState(() {
    //         errorOcurred = !errorOcurred;
    //       });
    //     },
    //   ),
  }

  @override
  void initState() {
    avatarState = widget.avatar!;
    errorOcurred = false;
    super.initState();
  }
}

class _SelectAvatarState extends State<SelectAvatar> {
  // int _getImageAngle(File imageFile) {
  //   final bytes = imageFile.readAsBytesSync();
  //   final image = img.decodeImage(bytes)!;
  //                   ui.Image
  //   int angle = 0;
  //   switch (image.exif.orientation) {
  //     case img.Orientation.rightTop:
  //       angle = -90;
  //       break;
  //     case img.Orientation.bottomRight:
  //       angle = 180;
  //       break;
  //     case img.Orientation.leftBottom:
  //       angle = 90;
  //       break;
  //     default:
  //       angle = 0;
  //   }
  //   return angle;
  // }

  @override
  Widget build(BuildContext context) {
    AccountController accountController = Get.find<AccountController>();
    return AlertDialog(
      title: Text("Seleccionar desde:"),
      content: Container(
        // color: Colors.amber,
        height: MediaQuery.of(context).size.height / 6,
        child: Column(
          children: [
            ListTile(
              title: Text("Galería"),
              leading:
                  Image.asset("assets/images/icons/app/enzona/emptyimg.jpeg"),
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                // XFile?
                var pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 100,
                  // maxHeight: 150,
                  // maxWidth: 150,
                );

                if (pickedFile == null) {
                  // Navigator.pop(context);
                  Get.snackbar("Atencion!!!",
                      "Debe tomar una foto para actualizar su avatar.");
                } else {
                  // var aux = await _pickedFile.readAsString();
                  // log("ESTE ES AUX>>>>>>>>$aux");
                  // var imageFile = File(_pickedFile.path);
                  // _getImageAngle(imageFile);
                  var image = await rotateAndCompressImage(pickedFile);
                  // var image = await _pickedFile.readAsBytes();

                  var forSend = dartConvert.base64Encode(image);
                  log("ESTE ES PICKEDFILE>>>>>>>>>>$pickedFile");
                  log("ESTE ES IMAGE>>>>>>>>>>$image");
                  log("ESTE ES FORSEND>>>>>>>>>>$forSend");
                  Map<String, dynamic> params = {"avatar": forSend};
                  log("ESTE ES PARAMS>>>>>>>>>>$params");
                  Navigator.pop(context);

                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return Loading(
                          text: "Actualizando su avatar...",
                          backgroundColor: Colors.lightBlue.shade700,
                          animationColor: AlwaysStoppedAnimation<Color>(
                              Colors.lightBlue.withOpacity(0.8)),
                          containerColor:
                              Colors.lightBlueAccent.withOpacity(0.2),
                        );
                      });
                  await updateAvatar(context, params, accountController);
                  Get.back();
                  accountController.update(["InfoView"]);
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text("Cámara"),
              leading:
                  Image.asset("assets/images/icons/app/enzona/elegir_foto.png"),
              onTap: () async {
                final ImagePicker picker = ImagePicker();

                XFile? pickedFile = await picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 100,
                  maxHeight: 150,
                  maxWidth: 150,
                );

                if (pickedFile == null) {
                  // Navigator.pop(context);
                  Get.snackbar("Atencion!!!",
                      "Debe tomar una foto para actualizar su avatar.");
                } else {
                  // var aux = await _pickedFile.readAsString();
                  // log("ESTE ES AUX>>>>>>>>$aux");
                  var image = await pickedFile.readAsBytes();

                  var forSend = dartConvert.base64Encode(image);
                  log("ESTE ES PICKEDFILE>>>>>>>>>>$pickedFile");
                  log("ESTE ES IMAGE>>>>>>>>>>$image");
                  log("ESTE ES FORSEND>>>>>>>>>>$forSend");
                  Map<String, dynamic> params = {"avatar": forSend};
                  log("ESTE ES PARAMS>>>>>>>>>>$params");
                  Navigator.pop(context);

                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return Loading(
                          text: "Actualizando su avatar...",
                          backgroundColor: Colors.lightBlue.shade700,
                          animationColor: AlwaysStoppedAnimation<Color>(
                              Colors.lightBlue.withOpacity(0.8)),
                          containerColor:
                              Colors.lightBlueAccent.withOpacity(0.2),
                        );
                      });
                  await updateAvatar(context, params, accountController);
                  Get.back();
                  accountController.update(["InfoView"]);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<Uint8List> rotateAndCompressImage(XFile file) async {
    final originalFile = await file.readAsBytes();
    final originalImage = await decodeImageFromList(originalFile);

    final image = await FlutterImageCompress.compressWithFile(
      file.path,
      quality: 100,
      // minHeight: 150,
      rotate: 45,
      // minWidth: 150,
    );

    // final tempDir = await getTemporaryDirectory();
    // final tempPath =
    //     '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // final compressedImage = await FlutterImageCompress.compressWithFile(
    //   file.absolute.path,
    //   minWidth: 800,
    //   minHeight: 800,
    //   quality: 90,
    //   rotate: orientation,
    // );

    // final tempFile = await File(tempPath).writeAsBytes(compressedImage);

    return image!;
  }
}
