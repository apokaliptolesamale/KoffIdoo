// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/helpers/extract_failure.dart';
import '/app/core/helpers/snapshot.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/interfaces/use_case.dart';
import '/app/core/services/store_service.dart';
import '/app/modules/transaction/controllers/transaction_controller.dart';
import '/app/modules/transaction/domain/models/transaction_model.dart';
import '/app/modules/transaction/domain/usecases/filter_transaction_usecase.dart';
import '/app/modules/transaction/domain/usecases/list_transaction_usecase.dart';
import '/app/modules/transaction/widgets/list_transactions_scroll_widget.dart';
import '/app/widgets/field/custom_get_view.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/utils/loading.dart';

class TransactionsListFrameView extends CustomView<TransactionController> {
  late FutureBuilder fututeBuilder;
  late UseCase usecase;
  Map<dynamic, dynamic>? parameters;
  //late TransactionList<TransactionModel> transactions;
  // late String transactionStatus, transactionType, startDate, endDate;
  TransactionsListFrameView({Key? key, this.parameters}) {
    Get.lazyPut(() => this);
    usecase = apply(ListTransactionUseCase<TransactionModel>(Get.find()));
  }
  UseCase apply(UseCase uc) {
    Store store = StoreService().getStore("filterTransactions");
    if (store.getMapFields.isNotEmpty) {
      uc = FilterTransactionUseCase<TransactionModel>(Get.find());
      //  uc = uc.setParamsFromMap(store.getMapFields);
    }
    uc = uc.setParamsFromMap(store.getMapFields);
    return uc;
  }

  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  Widget rebuild(BuildContext context, UseCase uc) =>
      fututeBuilder = FutureBuilder(
        future: getFutureByUseCase(uc),
        builder: getBuilderByUseCase(uc),
      );

  @override
  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    if (uc is ListTransactionUseCase) return getTransactionListBuilder<A>();
    if (uc is FilterTransactionUseCase) return getTransactionListBuilder<A>();
    return getTransactionListBuilder();
  }

  @override
  Future<T> getFutureByUseCase<T>(UseCase uc) async {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }

  AsyncWidgetBuilder getTransactionListBuilder<A>() {
    // ignore: prefer_function_declarations_over_variables
    var builder = (BuildContext context, AsyncSnapshot snapshot) {
      EntityModelList<TransactionModel> transactions = DefaultEntityModelList();
      if (isWaiting(snapshot)) {
        return EmptyDataSearcherResult(
            child: Loading(
          text: "Cargando listado de transacciones...",
          backgroundColor: Colors.transparent,
          animationColor:
              AlwaysStoppedAnimation<Color>(Colors.lightBlue.withOpacity(0.8)),
          containerColor: Colors.transparent,
        ));
      } else if (isDone<dart.Right>(snapshot)) {
        Store store = StoreService().getStore("filterTransactions");
        store.flush();
        final dart.Right resultData = snapshot.data as dart.Right;
        transactions = resultData.value;
        if (transactions.getTotal >= 0) {
          //TransactionList<TransactionModel> transactions = resultData.value;
          return listTransactionsSimpleWidget(
            transactions: transactions as TransactionList<TransactionModel>,
            context: context,
          );
        }
        if (transactions.getTotal <= 0) {
          return Center(
            child: Text("No existen datos para mostrar"),
          );
        }
      } else if (isError<dart.Left>(snapshot)) {
        //final dart.Left  resultData = snapshot.data as dart.Left;
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Center(
          child: Text(fail),
        );
      }
      return listTransactionsSimpleWidget(
        transactions: transactions as TransactionList<TransactionModel>,
        context: context,
      );
    };
    return builder;
  }
}
