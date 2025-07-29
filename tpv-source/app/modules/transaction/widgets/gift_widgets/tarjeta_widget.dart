import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../core/config/errors/errors.dart';

import '../../../card/domain/models/card_model.dart';
import '../../controllers/gift_controller.dart';

class TarjetaWidget extends StatelessWidget {
  const TarjetaWidget({key});

  @override
  Widget build(BuildContext context) {
    GiftController controller = Get.find<GiftController>();

    Size size = MediaQuery.of(context).size;
    TextStyle styleSelect = TextStyle(
        color: Color.fromARGB(255, 129, 129, 129), fontSize: size.width / 28);

    return FutureBuilder(
        future: controller.getPrimarySourceCard(),
        builder:
            ((context, AsyncSnapshot<Either<Failure, CardModel>> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            final cardPrimary = snapshot.data!.fold((l) => null, (r) => r);
            return Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey,
                      blurStyle: BlurStyle.outer,
                      blurRadius: 5)
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: size.width / 80),
                      Container(
                          color: Colors.transparent,
                          width: size.width / 10,
                          height: size.height / 20,
                          child: Image.asset(
                              getImageByBankCode(cardPrimary!.bankCode))),
                      SizedBox(
                        width: size.width / 80,
                      ),
                      Text(
                        cardPrimary.cardholder,
                        style: styleSelect,
                      ),
                      SizedBox(
                        width: size.width / 80,
                      ),
                      Text(
                        '(${cardPrimary.last4})',
                        style: styleSelect,
                      ),
                      SizedBox(
                        width: size.width / 80,
                      ),
                      Text(
                        cardPrimary.currency.toUpperCase(),
                        style: styleSelect,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        }));
  }

  getImageByBankCode(String bankCode) {
    switch (bankCode) {
      case "12":
        return "assets/images/backgrounds/enzona/bpa_new.png";

      case "95":
        return "assets/images/backgrounds/enzona/banmet.png";

      case "05":
        return "assets/images/backgrounds/enzona/banmet.png";

      case "04":
        return "assets/images/backgrounds/enzona/bicsa_new.png";

      case "06":
        return "assets/images/backgrounds/enzona/bandec_new.png";

      default:
        return "assets/images/backgrounds/enzona/banmet.png";
    }
  }
}
