// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '/app/core/services/logger_service.dart';
import '/app/modules/security/controllers/security_controller.dart';
import '/app/modules/warranty/views/colors.dart';
import '/app/modules/warranty/widgets/warranty_logo.dart';
import '/app/widgets/field/custom_get_view.dart';
import '../../../../app/core/config/assets.dart';
import '../../../../app/modules/warranty/controllers/warranty_controller.dart';
import '../../../../app/widgets/images/background_image.dart';
import '../../../core/helpers/snapshot.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/components/clock_loading.dart';
import '../../../widgets/promise/custom_future_builder.dart';

class AuthenticationForm extends StatefulWidget {
  AuthenticationForm({
    Key? key,
  }) : super(key: key);

  @override
  AuthenticationFormState createState() => AuthenticationFormState();
}

class AuthenticationFormState extends State<AuthenticationForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isOk = false;
  StreamController<AsyncSnapshot<Object?>> snapshotController =
      StreamController<AsyncSnapshot<Object?>>();
  @override
  Widget build(BuildContext context) {
    final ctl = Get.find<SecurityController>();

    final defaultView = Center(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 10, top: 20),
        child: Column(
          children: [
            WarrantyLogo(
              margin: EdgeInsets.only(top: 100),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF00b1a4),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFF00b1a4),
                  )),
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  hintText: 'Usuario',
                  hintStyle: TextStyle(
                    color: Color(0xFF00b1a4),
                    fontSize: 22,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(
                      Icons.perm_contact_calendar,
                      color: Color(0xFF00b1a4),
                      size: 30,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Color(0xFF00b1a4),
                  fontSize: 22,
                ),
              ),
            ),
            //END OF FIRST TEXT FIELD
            Container(
              height: 10,
            ),
            Container(
              child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF00b1a4),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: const Color(0xFF00b1a4),
                  )),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  hintText: 'Contraseña',
                  hintStyle: TextStyle(
                    color: const Color(0xFF00b1a4),
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(
                      Icons.lock_rounded,
                      color: const Color(0xFF00b1a4),
                      size: 30,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: const Color(0xFF00b1a4),
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            //END OF SECOND TEXT FIELD
            /*Container(
                height: 80,
              ),*/
            Container(
              margin: EdgeInsets.only(top: 30),
              width: double.infinity,
              height: 40,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () => _onLogin(),
                    shape: CircleBorder(),
                    color: Color(0xFF00b1a4),
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Image(
                        image:
                            AssetImage(ASSETS_IMAGES_LOGOS_ENZONA_EZ_LOGO_PNG),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              margin: EdgeInsets.only(top: 25),
              child: MaterialButton(
                onPressed: () => _onLogin(),
                shape: StadiumBorder(),
                color: aceptBottonColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 3.0,
                    //horizontal: 24.0,
                  ),
                  child: Text(
                    "INICIAR SESIÓN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            //END OF BUTTON
            Container(
              margin: EdgeInsets.all(10),
              child: TextButton(
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {},
              ),
            ),
            //END OF FIRST TEXT BUTTON
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextButton(
                child: Text(
                  'Regístrate ahora',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Get.toNamed(Routes.getInstance.getPath("REGISTRY_LOGIN"));
                },
              ),
            ),
          ],
        ),
      ),
    );
    final checking = Future.wait([ctl.isAuthenticated(), ctl.loadProfile()]);
    final body = CustomFutureBuilder(
      context: context,
      initialData: AsyncSnapshot.withData(ConnectionState.none, null),
      future: checking,
      builder: (context, snapshot) {
        final clockLoading = ClockLoading(
          durationSeconds: 3,
          width: 80,
          height: 80,
          textLoading: createFromSnapshot(snapshot),
          onComplete: () {
            if (isDone(snapshot) && snapshot.data is List<Object?>) {
              final futures = snapshot.data as List<Object?>;
              isOk = futures.elementAt(0) is bool;
              final profile = futures.elementAt(1);
              if (isOk && profile != null) {
                Routes.getInstance.goTo("WARRANTY_HOME");
              } else {
                //
              }
            }
          },
        );
        if (isWaiting(snapshot)) {
          return clockLoading;
        } else if (isDone(snapshot)) {
          if (snapshot.data is List<Object?>) {
            final futures = snapshot.data as List<Object?>;
            isOk = futures.elementAt(0) is bool;
            final profile = futures.elementAt(1);
            if (isOk && profile != null) {
              return clockLoading;
            } else {
              log("Profile is null");
              return defaultView;
            }
          }
          //Get.toNamed(Routes.getInstance.getPath("WARRANTY_HOME"));
        } else {
          return defaultView;
        }
        return Container();
      },
    );
    return Center(
      child: body,
    );
  }

  Widget? createFromSnapshot(AsyncSnapshot<Object?> snapshot) {
    final theme = Theme.of(context);
    final labelMedium = theme.textTheme.labelMedium;
    if (isWaiting(snapshot)) {
      return Text(
        "Espere por favor...",
        style: labelMedium,
      );
    }
    if (isError(snapshot)) {
      return Text(
        "Ha ocurrido un error.",
        style: labelMedium,
      );
    }
    if (isDone(snapshot)) {
      return Text(
        "Usuario autenticado",
        style: labelMedium,
      );
    }
    return null;
  }

  @override
  initState() {
    isOk = false;
    super.initState();
  }

  _onLogin() async {
    // Get.toNamed(Routes.getInstance.getPath("WARRANTY_HOME"));

    final ctl = Get.find<SecurityController>();
    final authenticated = await ctl.isAuthenticated();
    log("Authenticated: $authenticated");

    if (!authenticated) {
      //Get.toNamed(Routes.getInstance.getPath("AUTHENTICATION"));
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          final theme = Theme.of(context);
          final titleLarge = theme.textTheme.titleLarge;
          final bodyLarge = theme.textTheme.bodyLarge;
          final btx = theme.textTheme.labelLarge;
          return AlertDialog(
            title: Text(
              'Error de autenticación',
              style: titleLarge,
            ),
            content: SingleChildScrollView(
              child: Text(
                "Usuario o contraseña incorrecta",
                style: bodyLarge,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cerrar',
                  style: btx,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  //Get.toNamed(Routes.getInstance.getPath("WARRANTY_HOME"));
                },
              ),
            ],
          );
        },
      );
    } else {
      final profile = await ctl.loadProfile();
      if (profile != null) {
        log("${profile.sub} already authenticated");
        Get.toNamed(Routes.getInstance.getPath("WARRANTY_HOME"));
      } else {
        log("Profile is null");
      }
    }
  }
}

class WarrantyView extends CustomView<WarrantyController> {
  WarrantyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body = Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: SingleChildScrollView(
        child: Center(
          heightFactor: 1,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: AuthenticationForm(),
          ),
        ),
      ),
    );
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          BackGroundImage(
            backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
          ),
          body,
        ],
      ),
    );
  }
}
