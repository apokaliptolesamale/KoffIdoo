import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/services/store_service.dart';
import '/app/modules/transaction/controllers/transaction_controller.dart';
import '/app/modules/transaction/domain/models/transaction_model.dart';
import '/app/modules/transaction/widgets/transactions_filter_widget.dart';
import '/app/modules/transaction/widgets/transactions_list_frame.dart';
import '/app/widgets/utils/size_constraints.dart';

class TransactionsWidget extends GetView<TransactionController> {
  TransactionList<TransactionModel>? transactionList;
  TransactionsWidget({Key? key, this.transactionList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*FloatingActionButtonAnimator myButton =
        FloatingActionButtonAnimator.scaling;*/
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return FilterTransactionsWidget(
                    context: context,
                  );
                });
          },
          child: const Icon(Icons.filter_alt_outlined),
        ),
        appBar: AppBar(
          title: const Text('Transacciones'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Get.toNamed("/security");
              Store store = StoreService().getStore("filterTransactions");
              store.flush();
              /*  Store store =
                  StoreService().getStore("filterTransactions");
                  store.flush();
                  Get.back();*/
              // Get.back();
              // Get.offNamedUntil('profile', (route) => false);
            },
          ),
        ),
        body:
            TransactionsListFrameView()); //TransaccionesViewV(transactionList: transactionList,));
  }
}

class TransactionView extends GetView<TransactionController> {
  TransactionList<TransactionModel>? transactionList;
  TransactionView({Key? key, this.transactionList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    FloatingActionButtonAnimator myButton =
        FloatingActionButtonAnimator.scaling;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return FilterTransactionsWidget(
                    context: context,
                  );
                });
          },
          child: const Icon(Icons.filter_alt_outlined),
        ),
        appBar: AppBar(
          titleSpacing: size.getHeightByPercent(-2),
          title: Text(
            'Transacciones',
          ),
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Get.back();
              Store store = StoreService().getStore("filterTransactions");
              store.flush();
            },
          ),
        ),
        body:
            TransactionsListFrameView()); //TransaccionesViewV(transactionList: transactionList,));
  }
}
