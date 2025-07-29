import '/app/core/services/logger_service.dart';
import '/app/modules/transaction/controllers/transaction_controller.dart';
import '/app/modules/transaction/domain/entities/transaction.dart';
import '/app/modules/transaction/domain/models/transaction_model.dart';
import '/app/modules/transaction/domain/usecases/list_transaction_usecase.dart';
import '/app/modules/transaction/widgets/listile_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTransactionsScrollWidget extends StatefulWidget {
  int? total;
  TransactionList<TransactionModel> transactions;
  ListTransactionsScrollWidget(
      {Key? key, this.total, required this.transactions});

  @override
  State<ListTransactionsScrollWidget> createState() =>
      _ListTransactionsScrollWidgetState();
}

class _ListTransactionsScrollWidgetState
    extends State<ListTransactionsScrollWidget> {
  final controller = ScrollController();
  //TransactionList<TransactionModel> list = widget.transactionsList;
  //final tController = Get.find<TransaccionesController>();
  // final filters = Get.find<FilterTransactionsParamsUseCase>();
  bool hasMore = true;
  bool isLoading = false;
  TransactionController tController = Get.find<TransactionController>();
  List<Transaction>? transactionsList;

  @override
  void initState() {
    super.initState();
    transactionsList = widget.transactions.transactions;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.offset) {
        int limit = 10;
        int offset = 0;
        Map<String, dynamic> params = {
          "limit": limit += 10,
          "offset": offset += 10,
        };
        log("valores de los parametros para scroll ${params.values}");
        search(params);
      }
    });
  }
  /* @override
         void dispose(){
          controller.dispose();
          super.dispose();
         }*/

  search(Map<String, dynamic> params) async {
    if (isLoading) return;
    isLoading = false;
    transactionsList;
    final parameters =
        tController.listTransactionUseTransaction.setParamsFromMap(params);
    final responseList = await tController.listTransactionUseTransaction
        .call(parameters as ListUseCaseTransactionParams);
    responseList.fold((l) {
      log(l.toString());
      return l.toString();
    }, (r) {
      setState(() {
        hasMore = true;
        transactionsList!.addAll(r.getList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //List<Transaction> transactions = widget.transactionsList;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            controller: controller,
            itemCount: transactionsList!.length + 1,
            padding: const EdgeInsets.all(2.0),
            itemBuilder: (context, index) {
              if (index < transactionsList!.length) {
                return ListTileTransaction(
                  transaction: transactionsList![index],
                  context: context,
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: hasMore
                      ? Center(child: CircularProgressIndicator())
                      : Container(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class listTransactionsSimpleWidget extends StatefulWidget {
  int? total;
  TransactionList<TransactionModel> transactions;
  BuildContext context;

  listTransactionsSimpleWidget(
      {Key? key,
      required this.transactions,
      required this.context,
      this.total});

  @override
  State<listTransactionsSimpleWidget> createState() =>
      _listTransactionsSimpleWidgetState();
}

class _listTransactionsSimpleWidgetState
    extends State<listTransactionsSimpleWidget> {
  @override
  Widget build(BuildContext context) {
    List<Transaction> transactionList = widget.transactions.transactions;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            //controller: controller,
            itemCount: transactionList.length,
            padding: const EdgeInsets.all(2.0),
            itemBuilder: (context, index) {
              return ListTileTransaction(
                transaction: transactionList[index],
                context: context,
              );
            },
          ),
        ),
      ],
    );
  }
}
