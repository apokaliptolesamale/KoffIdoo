import 'dart:developer';

import 'package:flutter/material.dart';

import 'card_type.dart';

class CardUtils {
  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    String bank = input.substring(4, 6);
    log("Bank $bank");
    switch (bank.toString()) {
      case "95":
      case "05":
        cardType = CardType.METRO;
        break;
      case "06":
        cardType = CardType.BANDEC;
        break;
      case "12":
        cardType = CardType.BPA;
        break;
      case "04":
        cardType = CardType.BICSA;
        break;
      default:
        cardType = CardType.Invalid;
    }

    return cardType;
  }

  static Widget gedCardIcon(CardType cardType) {
    String img = "";
    Icon? icon;
    switch (cardType) {
      case CardType.METRO:
        img = "assets/images/backgrounds/enzona/banmet.png";
        break;
      case CardType.BANDEC:
        img = "assets/images/backgrounds/enzona/bandec_new.png";
        break;
      case CardType.BPA:
        img = "assets/images/backgrounds/enzona/bpa_new.png";
        break;
      case CardType.BICSA:
        img = "assets/images/backgrounds/enzona/bicsa_new.png";
        break;
      default:
        icon = const Icon(Icons.warning);
    }

    if (img.isEmpty) {
      return icon!;
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          img,
          // height: 25,
          width: 20,
        ),
      );

      /*ImageIcon(
        color: Color(0xFFffff00),
        AssetImage(img),
      );*/
    }
  }
}
