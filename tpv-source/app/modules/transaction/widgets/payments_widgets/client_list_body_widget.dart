import '/app/modules/transaction/widgets/payments_widgets/client_%20service_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/models/client_service_model.dart';

class ClientListBodyWidget extends StatelessWidget {
  ClientServiceList<ClientServiceModel> clienIds;
  String type;
  ClientListBodyWidget({required this.clienIds, required this.type});

  @override
  Widget build(BuildContext context) {
    List<ClientServiceModel> list = clienIds.clientIds;
    return Container(
      //color: Colors.yellow,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.80,
      child: Expanded(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            final client = list[index];
            return ClientServiceWidget(
              context: context,
              invoiceType: type,
              clientInvoice: client,
            );
          },
        ),
      ),
    );
  }
}
