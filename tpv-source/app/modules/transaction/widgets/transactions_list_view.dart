// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/transaction/controllers/transaction_controller.dart';
import '/app/modules/transaction/domain/models/transaction_model.dart';
import '/app/modules/transaction/widgets/list_transactions_scroll_widget.dart';

class TransaccionesViewV extends GetView<TransactionController> {
  TransactionList<TransactionModel> transactionList;
  TransaccionesViewV({
    Key? key,
    required this.transactionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FilterTransactionsParamsUseCase filters = Get.put(FilterTransactionsParamsUseCase());
    /*int init = 0;
    int offset = 10;
    FloatingActionButtonAnimator myButton =
        FloatingActionButtonAnimator.scaling;*/
    return ListTransactionsScrollWidget(
      total: transactionList.getTotal,
      transactions: transactionList,
    ); /*FutureBuilder(
        future: controller.listTransactionUseTransaction.getAll() ,
        builder: (context, snapshot){
         if(!snapshot.hasData){
          return Loading(
            text: "Cargando Transacciones",
          );
         }else {
          return Container();
         }
        }
      );
      }*/

    /* return GetBuilder<TransactionController>(
          id: "nombre",
          builder: (controller) {
            //list();
            //lt.TransactionsList transactionsList = controller.filterTransactions(filters, init, offset);
            if(controller.loading){
              return Center(child: CircularProgressIndicator());
            }
            else{ 
              lt.TransactionsList transactionsFilterr = controller.transactionsFilter;
           return  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: transactionsFilterr.transactions.length+1,
                        padding: const EdgeInsets.all(2.0),
                        itemBuilder: (context, index) {
                          if (index < transactionsFilterr.transactions.length) {
                          return ListTileTransaction(
                            transaction: transactionsFilterr.transactions[index],
                                 );
                           }else{
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: controller.hasMore? Center(child: CircularProgressIndicator()): Container());
                           }    
                        },
                      ),
                    ),
                  ],
                );
                }
             return FutureBuilder(
                future: controller.filterTransactions(filters, init, offset),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    lt.TransactionsList transactionsList =
                        snapshot.data as lt.TransactionsList;
                            return ListViewTransactionsScroll(
                              transactionsList: transactionsList.transactions,
                              init: init,
                              limit: offset,
                              total: transactionsList.pagination.total!,
                              transactionsPagination: transactionsList,);
                         
                      }
                }
                    );
            
            }
        );
          }
        
              }*/
  }
}
