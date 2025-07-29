// // ignore_for_file: must_be_immutable

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// import '/app/modules/card/domain/entities/card.dart' as BankCard;
// import '/app/modules/card/domain/entities/cordenate.dart';
// import '../../../widgets/botton/rounded_button.dart';
// import '../../../widgets/utils/loading.dart';
// import '../../../widgets/utils/size_constraints.dart';
// import '../controllers/account_controller.dart';

// class EzResetPaymentPasswordView extends GetView<AccountController> {
//   AccountController accountController = Get.find<AccountController>();

//   late BankCard.Card? cardF;
//   late Cordenate cordenate;
//   String image = "";
//   String carnetMilitar = "";
//   TextEditingController carneM = TextEditingController();
//   TextEditingController coord1 = TextEditingController();
//   TextEditingController coord2 = TextEditingController();
//   TextEditingController pin1 = TextEditingController();
//   TextEditingController pin2 = TextEditingController();

//   EzResetPaymentPasswordView({
//     Key? key,
//     this.cardF,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     SizeConstraints size = SizeConstraints(context: context);

//     log(cardF!.bankName);
//     switch (cardF!.bankName) {
//       case "Banco Popular de Ahorro (BPA)":
//         image = "assets/cards/bpa.png";
//         break;
//       case "Banco Metropolitano S.A":
//         image = "assets/cards/banmet.png";
//         break;
//       case "Banco Internacional de Comercio S.A.(BICSA)":
//         image = "assets/cards/bicsa.png";
//         break;
//       case "Banco de Crédito y Comercio (BANDEC)":
//         image = "assets/cards/bandec.png";
//         break;
//       default:
//     }

//     return Scaffold(
//       // scrollable: true,
//       appBar: AppBar(
//         title: const Text("Resetear Contraseña de Pago"),
//         leading: IconButton(
//             iconSize: 25,
//             splashRadius: 25,
//             onPressed: (() => Get.back()),
//             icon: const Icon(Icons.arrow_back_ios)),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage("assets/images/fondo_inicio_2.png"),
//                   fit: BoxFit.fill)),
//         ),
//       ),
//       body: Column(children: [
//         // Image.asset("$image"),
//         // BankCard(card: card),
//         Stack(
//           children: <Widget>[
//             Image.asset(image),
//             Positioned(
//               left: size.getWidthByPercent(12.5),
//               top: size.getHeightByPercent(11),
//               child: Text(
//                 "**** **** **** ${cardF!.last4}",
//                 textAlign: TextAlign.center,
//                 style:
//                     const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//               ),
//             ),
//             Positioned(
//               bottom: size.getHeightByPercent(2),
//               left: size.getWidthByPercent(87),
//               child: Text(
//                 cardF!.currency.toUpperCase(),
//                 textAlign: TextAlign.start,
//                 style: const TextStyle(fontSize: 24),
//               ),
//             ),
//             Positioned(
//               bottom: size.getHeightByPercent(2),
//               left: size.getWidthByPercent(4.5),
//               child: Text(
//                 cardF!.cardholder,
//                 textAlign: TextAlign.start,
//                 style: const TextStyle(fontSize: 24),
//               ),
//             ),
//           ],
//         ),
//         TextFormField(
//           keyboardType: TextInputType.number,
//           inputFormatters: [
//             FilteringTextInputFormatter.digitsOnly,
//             LengthLimitingTextInputFormatter(11),
//           ],
//           controller: carneM,
//           decoration: InputDecoration(
//               hintText: "Carnet Militar o Pasaporte(Opcional)",
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0),
//                 child: Icon(Icons.badge),
//               )),
//           onChanged: (texto) {
//             carnetMilitar = texto;
//             print(carnetMilitar);
//           },
//         ),
//         Divider(
//           height: 12,
//         ),

//         // telebancaAsociada(),
//         FutureBuilder(
//             // initialData: null,
//             // future: controller.getCordenates(),
//             builder: ((context, snapshot) {
//           if (!snapshot.hasData) {
//             return Loading(
//               text: "Cargando",
//             );
//           } else {
//             cordenate = snapshot.data as Cordenate;
//             return telebancaAsociada();
//           }
//         })),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             RoundedButton(
//               text: "Cancelar",
//               press: () {
//                 Get.back();
//                 carneM.clear();
//                 coord1.clear();
//                 coord2.clear();
//                 pin1.clear();
//                 pin2.clear();
//               },
//             ),
//             RoundedButton(
//               text: "Aceptar",
//               press: () {
//                 // await controller.resetPayPass();
//                 prepareResetPaymentPassword(cordenate);
//                 carneM.clear();
//                 coord1.clear();
//                 coord2.clear();
//                 pin1.clear();
//                 pin2.clear();
//               },
//             ),
//           ],
//         )
//       ]),
//     );
//   }

//   // pintarTarjeta() {
//   //   String image = "";
//   //   switch (card.bankName) {
//   //     case "BANCO_POPULAR_DE_AHORRO_BPA":
//   //       image = "assets/cards/bpa.png";
//   //       break;
//   //     case "BANCO_METROPOLITANO_S_A":
//   //       image = "assets/cards/banmet.png";
//   //       break;
//   //     case "BANCO_INTERNACIONAL_DE_COMERCIO_S_A_BICSA":
//   //       image = "assets/cards/bicsa.png";
//   //       break;
//   //     case "BANCO_DE_CRDITO_Y_COMERCIO_BANDEC":
//   //       image = "assets/cards/bandec.png";
//   //       break;
//   //     default:
//   //   }
//   //   return image;
//   // }

//   prepareResetPaymentPassword(Cordenate cordenate) async {
//     AccountController accountController = Get.find<AccountController>();

//     var vC1 = cordenate.c1;
//     var tC1 = coord1.text;
//     var vC2 = cordenate.c2;
//     var tC2 = coord2.text;
//     var vP1 = cordenate.p1;
//     var tP1 = pin1.text;
//     var vP2 = cordenate.p2;
//     var tP2 = pin2.text;
//     var cadenaEncript = vC1 + tC1 + vC2 + tC2 + vP1 + tP1 + vP2 + tP2;

//     log("ESTE ES CADENAENCRIPT ANTES DE SER CIFRADA>>>>>>>>>>>>$cadenaEncript");
//     var fSUuid = cardF!.fundingSourceUuid;
//     // await getFundingSourceUuidFirstCard();
//     var cadena = await accountController.cifrarBank(cadenaEncript);
//     var cm = carnetMilitar;
//     log("FUNDINGGGGGGGGGGGGGGGGGGGGGGGGG>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$fSUuid");
//     log("CADENA ENCRIPTADA>>>>>>>>>>>>>>>>$cadena");
//     log("CM>>>>>>>>>>>>>>>>>$cm");
//     await accountController.resetPaymentPassword(fSUuid, cadena, cm);
//   }

//   telebancaAsociada() {
//     return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//       Text(
//         "Telebanca asociada",
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 18,
//         ),
//         textAlign: TextAlign.left,
//       ),
//       TextFormField(
//         keyboardType: TextInputType.number,
//         inputFormatters: [
//           FilteringTextInputFormatter.digitsOnly,
//           LengthLimitingTextInputFormatter(2),
//         ],
//         controller: coord1,
//         decoration: InputDecoration(
//             hintText: "Coordenada ${cordenate.c1}",
//             prefixIcon: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10.0),
//               child: Icon(Icons.crop),
//             )),
//         // onChanged: (texto) {
//         //   controller.cord1 = texto;
//         //   controller.vC1 = cordenate.c1;
//         //   print(controller.cord1);
//         // },
//       ),
//       TextFormField(
//         keyboardType: TextInputType.number,
//         inputFormatters: [
//           FilteringTextInputFormatter.digitsOnly,
//           LengthLimitingTextInputFormatter(2),
//         ],
//         controller: coord2,
//         decoration: InputDecoration(
//             hintText: "Coordenada ${cordenate.c2}",
//             prefixIcon: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10.0),
//               child: Icon(Icons.crop),
//             )),
//         // onChanged: (texto) {
//         //   controller.cord2 = texto;
//         //   controller.vC2 = cordenate.c2;
//         //   print(controller.cord2);
//         // },
//       ),
//       TextFormField(
//         keyboardType: TextInputType.number,
//         inputFormatters: [
//           FilteringTextInputFormatter.digitsOnly,
//           LengthLimitingTextInputFormatter(1),
//         ],
//         controller: pin1,
//         decoration: InputDecoration(
//             hintText: "Posición ${cordenate.p1} del pin",
//             prefixIcon: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10.0),
//               child: Icon(Icons.pin),
//             )),
//         // onChanged: (texto) {
//         //   controller.posPin1 = texto;
//         //   controller.vP1 = cordenate.p1;
//         //   print(controller.posPin1);
//         // },
//       ),
//       TextFormField(
//         keyboardType: TextInputType.number,
//         inputFormatters: [
//           FilteringTextInputFormatter.digitsOnly,
//           LengthLimitingTextInputFormatter(1),
//         ],
//         controller: pin2,
//         decoration: InputDecoration(
//             hintText: "Posición ${cordenate.p2} del pin",
//             prefixIcon: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10.0),
//               child: Icon(Icons.pin),
//             )),
//         // onChanged: (texto) {
//         //   controller.posPin2 = texto;
//         //   controller.vP2 = cordenate.p2;
//         //   print(controller.posPin2);
//         // },
//       )
//     ]);
//   }
// }
