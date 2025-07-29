import '/app/modules/security/domain/models/account_model.dart';
import '/app/modules/transaction/domain/entities/invoice.dart';
import '/app/widgets/utils/size_constraints.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AccountCardWidget extends StatelessWidget {
  Invoice? invoice;

  AccountCardWidget({Key? key, this.invoice});

  @override
  Widget build(BuildContext context) {
    AccountModel account = Get.find<AccountModel>();
    SizeConstraints size = SizeConstraints(context: context);
    return Row(
      children: <Widget>[
        // Primer elemento: imagen

        getCard(invoice!, context),
        // Segundo elemento: texto
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '${account.name} ${account.lastname}',
            style: TextStyle(
                fontSize: size.getWidthByPercent(3),
                fontWeight: FontWeight.bold),
          ),
        ),

        // Tercer elemento: fila con dos elementos de texto
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              " (${invoice!.last4!})",
              style: TextStyle(fontSize: size.getWidthByPercent(3)),
            ),
            SizedBox(width: size.getWidthByPercent(1)),
            Text(
              "${invoice!.currency}",
              style: TextStyle(fontSize: size.getWidthByPercent(3)),
            ),
          ],
        ),
      ],
    );
  }

  Widget getCard(Invoice invoice, BuildContext context) {
    String image = "";
    SizeConstraints size = SizeConstraints(context: context);
    switch (invoice.bankCode) {
      case "12":
        image = "assets/images/backgrounds/enzona/bpa.png";
        break;
      case "95":
        image = "assets/images/backgrounds/enzona/banmet.png";
        break;
      case "04":
        image = "assets/images/backgrounds/enzona/bicsa.png";
        break;
      case "06":
        image = "assets/images/backgrounds/enzona/bandec.png";
        break;
    }
    return Image.asset(
      image,
      width: size.getWidthByPercent(20),
      height: size.getHeightByPercent(10),
    );
  }
}
