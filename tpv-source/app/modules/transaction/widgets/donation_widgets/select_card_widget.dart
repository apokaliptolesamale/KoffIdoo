// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/services/logger_service.dart';
import '../../../../core/services/store_service.dart';
import '../../../card/domain/models/card_model.dart';
import '../../controllers/donation_controller.dart';

class SelectCardWidget extends StatefulWidget {
  final List<CardModel> listCard;
  String fundingSourceUUID = 'zzz';
  SelectCardWidget({
    Key? key,
    required this.listCard,
  }) : super(key: key);

  String get funding => fundingSourceUUID;

  @override
  State<SelectCardWidget> createState() => _SelectCardWidgetState();
}

class _SelectCardWidgetState extends State<SelectCardWidget> {
  DonationController controller = Get.find();
  final storeDonation = StoreService().createStore("donation");
  late CardModel dropDownValue;

  //String fundingSourceUUID = "";
  String moneda = "";

  int index = 0;
  // String? dropDownValue = "";
  // var card;
  // late var dropdownValue = widget.listCard.card;
  List<CardModel> cards = [];
  late var listSelectCards = widget.listCard;
  // List<String> menuItems = [];
  //var items=null;
  /*getDropdownItems() {
    // TransferController controller = Get.find();
    for (var index = 0; index < listSelectCards.length; index++) {
      widget.listCard[index];

      cards.add(listSelectCards[index]);
      // return menuItems;
      // items = menuItems;
    }

    //var donarView = Get.find<DonarView>();
    // log("loggggggggggggggggggggggggggggggggggggggggg${cards[0].currency}");
    dropDownValue = cards[0];
    setState(() {
      widget.fundingSourceUUID = dropDownValue.fundingSourceUuid;
      //donarView.fundingSourceUUID = dropDownValue.fundingSourceUuid;
      controller.fundingSourceUUID = dropDownValue.fundingSourceUuid;
      //controller.update(['Button']);
      log('Este es el founding source==> ${controller.fundingSourceUUID}');
    });

    //controller.fundingSourceUuid = fundingSourceUUID;
    moneda = dropDownValue.currency;
    //controller.tipoCurrency = moneda;
    return cards;
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //DonationController controller = Get.find();

    return Container(
        color: Colors.transparent,
        height: size.height / 8,
        width: size.width / 1,
        child: Center(
            child: DropdownButton(
          borderRadius: BorderRadius.circular(15),
          // underline: Container(
          //   color: Colors.transparent,
          // ),
          // hint: Text("Seleccione una tarjeta."),
          value: dropDownValue,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 0,
          elevation: 8,
          //style: TextStyle(color: Colors.black, fontSize: size.height / 40),
          items: cards.map((card) {
            return DropdownMenuItem<CardModel>(
                value: card, child: valueDropButton(card, index));
          }).toList(),
          onChanged: (CardModel? newValue) {
            setState(() {
              dropDownValue = newValue!;
              widget.fundingSourceUUID = dropDownValue.fundingSourceUuid;
              if (storeDonation.hasKey('fundingSourceUuid') &&
                  storeDonation.getMapFields.values.isNotEmpty) {
                storeDonation.set(
                    'fundingSourceUuid', dropDownValue.fundingSourceUuid);
              }
              //controller.fundingSourceUUID = dropDownValue.fundingSourceUuid;
              moneda = dropDownValue.currency;
              //controller.tipoCurrency = moneda;
              //print(controller.fundingSourceUuid);
            });
          },
        )));
  }

  //
  getDropdownItems() {
    // TransferController controller = Get.find();
    for (var index = 0; index < listSelectCards.length; index++) {
      cards.add(listSelectCards[index]);
      // return menuItems;
      // items = menuItems;
    }

    //var donarView = Get.find<DonarView>();
    // log("loggggggggggggggggggggggggggggggggggggggggg${cards[0].currency}");
    dropDownValue = cards[0];
    setState(() {
      widget.fundingSourceUUID = dropDownValue.fundingSourceUuid;
      //donarView.fundingSourceUUID = dropDownValue.fundingSourceUuid;
      //controller.fundingSourceUUID = dropDownValue.fundingSourceUuid;

      storeDonation.add('fundingSourceUuid', dropDownValue.fundingSourceUuid);
      //controller.update(['Button']);
      log('Este es el founding source==> ${controller.fundingSourceUUID}');
    });

    //controller.fundingSourceUuid = fundingSourceUUID;
    moneda = dropDownValue.currency;
    //controller.tipoCurrency = moneda;
    return cards;
  }

  @override
  void initState() {
    getDropdownItems();
    // getDropDownValue();

    super.initState();
  }

  Widget valueDropButton(CardModel card, int index) {
    var cardholder = card.cardholder;
    var last4 = card.last4;
    var currency = card.currency;
    Size size = MediaQuery.of(context).size;
    String image = "";
    switch (card.bankName) {
      case "Banco Popular de Ahorro (BPA)":
        image = "assets/images/backgrounds/enzona/bpa.png";
        break;
      case "Banco Metropolitano S.A":
        image = "assets/images/backgrounds/enzona/banmet.png";
        break;
      case "Banco Internacional de Comercio S.A.(BICSA)":
        image = "assets/images/backgrounds/enzona/bicsa.png";
        break;
      case "Banco de Crédito y Comercio (BANDEC)":
        image = "assets/images/backgrounds/enzona/bandec.png";
        break;
      default:
    }
    TextStyle styleSelect = TextStyle(
        color: Color.fromARGB(255, 129, 129, 129), fontSize: size.width / 28);

    return Column(
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                color: Colors.transparent,
                width: size.width / 10,
                height: size.height / 20,
                child: Image.asset(image)),
            SizedBox(
              width: size.width / 80,
            ),
            Text(
              cardholder,
              style: styleSelect,
            ),
            SizedBox(
              width: size.width / 80,
            ),
            Text(
              '($last4)',
              style: styleSelect,
            ),
            SizedBox(
              width: size.width / 80,
            ),
            Text(
              currency.toUpperCase(),
              style: styleSelect,
            ),
          ],
        ),
      ],
    );
  }
}
