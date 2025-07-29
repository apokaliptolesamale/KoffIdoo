import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/dataview/option_widget.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../controllers/account_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EzProfileConfigView extends GetView<AccountController> {
  const EzProfileConfigView({Key? key}) : super(key: key);

  @override
  //implementar getbuilder<ConfigController>
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: size.getHeightByPercent(-2),
        title: Text(
          "Configuración",
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
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          /*  ProfileOpt(
                image: 'assets/images/configuracion.png',
                text: 'Configuracion de pago',
                onPress: () {
                   
                },
              ),*/
          OptionWidget(
            rutaAsset:
                'assets/images/backgrounds/enzona/configuracion_de_pago.png',
            texto: 'Configuración de Pago',
            icono: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              // Get.to(PayConfigurationView());
              Get.toNamed(
                  "/security/ezprofileview/ezprofileconfig/ezprofilepaymentconfig");
            },
          ),
          OptionWidget(
            rutaAsset: 'assets/images/backgrounds/enzona/seguridad.png',
            texto: 'Seguridad y Privacidad',
            icono: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Get.toNamed(
                  "/security/ezprofileview/ezprofileconfig/securityProfileview");
            },
          ),
          //const SizedBox(height: 50,),
          OptionWidget(
            rutaAsset: 'assets/images/backgrounds/enzona/actualizar.png',
            texto: 'Actualización',
            icono: const Icon(Icons.arrow_forward_ios),
            onPressed: () {},
          ),
          OptionWidget(
            rutaAsset: 'assets/images/backgrounds/enzona/contactenos.png',
            texto: 'Contactenos',
            icono: const Icon(Icons.arrow_forward_ios),
            onPressed: () {},
          ),
          OptionWidget(
            rutaAsset: 'assets/images/backgrounds/enzona/ayuda.png',
            texto: 'Ayuda',
            icono: const Icon(Icons.arrow_forward_ios),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
