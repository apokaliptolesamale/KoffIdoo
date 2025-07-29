// // ignore_for_file: no_leading_underscores_for_local_identifiers


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';

// class DropDownButton extends StatefulWidget {
//   final lc.ListCard listCard;

//   const DropDownButton({Key? key, required this.listCard}) : super(key: key);

//   @override
//   State<DropDownButton> createState() => _DropDownButtonState();
// }

// class _DropDownButtonState extends State<DropDownButton> {
//   TransferController controller = Get.find();
//   @override
//   void initState() {
//     getDropdownItems();
//     // getDropDownValue();

//     super.initState();
//   }

//   late lc.Card dropDownValue;
//   String fundingSourceUUID = "";
//   String moneda = "";
//   int index = 0;
//   // String? dropDownValue = "";
//   // var card;
//   // late var dropdownValue = widget.listCard.card;
//   List<lc.Card> cards = [];
//   late var listSelectCards = widget.listCard as lc.ListCard;

//   // List<String> menuItems = [];
//   var items;
//   getDropdownItems() {
//     // TransferController controller = Get.find();
//     for (var index = 0; index < listSelectCards.card.length; index++) {
//       var a = widget.listCard.card[index];

//       cards.add(listSelectCards.card[index]);
//       // return menuItems;
//       // items = menuItems;
//     }
//     print(cards);
//     // log("loggggggggggggggggggggggggggggggggggggggggg${cards[0].currency}");
//     dropDownValue = cards[0];
//     fundingSourceUUID = dropDownValue.fundingSourceUuid;
//     controller.fundingCardUUID = fundingSourceUUID;
//     moneda = dropDownValue.currency;
//     controller.tipoCurrency = moneda;
//     return cards;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     TransferController controller = Get.find();
//     return Container(
//         color: Colors.transparent,
//         height: size.height / 8,
//         width: size.width / 1,
//         child: Center(
//             child: DropdownButton(
//           borderRadius: BorderRadius.circular(15),
//           // underline: Container(
//           //   color: Colors.transparent,
//           // ),
//           // hint: Text("Seleccione una tarjeta."),
//           value: dropDownValue,
//           iconSize: 0,
//           elevation: 8,

//           items: cards.map((card) {
//             return DropdownMenuItem<lc.Card>(
//                 value: card, child: valueDropButton(card, index));
//           }).toList(),
//           onChanged: (lc.Card? newValue) {
//             setState(() {
//               dropDownValue = newValue!;
//               fundingSourceUUID = dropDownValue.fundingSourceUuid;
//               controller.fundingCardUUID = fundingSourceUUID;
//               moneda = dropDownValue.currency;
//               controller.tipoCurrency = moneda;
//             });
//           },
//         )));
//   }

//   Widget valueDropButton(lc.Card card, int index) {
//     var cardholder = card.cardholder;
//     var last4 = card.last4;
//     var currency = card.currency;
//     Size size = MediaQuery.of(context).size;
//     String image = "";
//     switch (card.bankName) {
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
//     TextStyle styleSelect = TextStyle(
//         color: Color.fromARGB(255, 129, 129, 129), fontSize: size.width / 28);

//     return Column(
//       children: [
//         Row(
//           // crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//                 color: Colors.transparent,
//                 width: size.width / 10,
//                 height: size.height / 20,
//                 child: Image.asset(image)),
//             SizedBox(
//               width: size.width / 80,
//             ),
//             Text(
//               cardholder,
//               style: styleSelect,
//             ),
//             SizedBox(
//               width: size.width / 80,
//             ),
//             Text(
//               '(${last4})',
//               style: styleSelect,
//             ),
//             SizedBox(
//               width: size.width / 80,
//             ),
//             Text(
//               currency.toUpperCase(),
//               style: styleSelect,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
