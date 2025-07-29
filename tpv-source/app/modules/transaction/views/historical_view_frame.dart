// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/helpers/extract_failure.dart';
import '/app/core/helpers/snapshot.dart';
import '/app/core/interfaces/use_case.dart';
import '/app/modules/transaction/controllers/invoice_controller.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '/app/modules/transaction/domain/usecases/filter_invoice_usecase.dart';
import '/app/modules/transaction/domain/usecases/list_invoice_usecase.dart';
import '/app/widgets/field/custom_get_view.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '/app/widgets/utils/loading.dart';
import '../widgets/payments_widgets/list_invoice_historical_widget.dart';

class HistoricalInvoiceFrameView extends CustomView<InvoiceController> {
  int typeInvoice;
  late CustomFutureBuilder fututeBuilder;
  late UseCase usecase;
  InvoiceList<InvoiceModel>? invoiceList;
  Map<dynamic, dynamic>? parameters;

  HistoricalInvoiceFrameView(
      {Key? key,
      this.parameters,
      this.invoiceList,
      required this.typeInvoice}) {
    Get.lazyPut(() => this);
    usecase = apply(FilterInvoiceUseCase<InvoiceModel>(Get.find()));
    //usecase = ListInvoiceUseCase<InvoiceModel>(Get.find());
  }
  UseCase apply(UseCase uc) {
    Map<String, dynamic> filter = {"transaction_type_filter": typeInvoice};
    if (filter.isNotEmpty) {
      uc = ListInvoiceUseCase<InvoiceModel>(Get.find());
      uc = uc.setParamsFromMap(filter);
    }
    return uc;
  }

  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  @override
  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    if (uc is FilterInvoiceUseCase) return getInvoiceListBuilder<A>();
    if (uc is ListInvoiceUseCase) return getInvoiceListBuilder<A>();
    return getInvoiceListBuilder();
  }

  @override
  Future<T> getFutureByUseCase<T>(UseCase uc) async {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }

  AsyncWidgetBuilder getInvoiceListBuilder<A>() {
    // ignore: prefer_function_declarations_over_variables
    var builder = (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return EmptyDataSearcherResult(
            child: Loading(
          text: "Cargando listado de facturas...",
          backgroundColor: Colors.lightBlue.shade700,
          animationColor:
              AlwaysStoppedAnimation<Color>(Colors.lightBlue.withOpacity(0.8)),
          containerColor: Colors.lightBlueAccent.withOpacity(0.2),
        ));
      } else if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data is dart.Left) {
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Center(
            child: Container(
          height: MediaQuery.of(context).size.height / 2,
          child: AlertDialog(
            actions: [
              Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: MediaQuery.of(context).size.height * 0.070,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Aceptar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.white),
                        ),
                      ),
                    )),
              )
            ],
            contentPadding: EdgeInsets.all(10),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                  child: Text(
                fail,
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
              )),
            ),
            title: Center(
              child: Text(
                "Error",
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
              ),
            ),
          ),
        ));
      } else if (isDone(snapshot)) {
        final resultData = snapshot.data as dart.Right;
        if (resultData.value is InvoiceList<InvoiceModel>) {
          InvoiceList<InvoiceModel> invoiceList = resultData.value;
          return ListInvoiceHistoricalSimpleWidget(invoiceList: invoiceList);
        }
      } else if (isError(snapshot)) {
        //final dart.Left  resultData = snapshot.data as dart.Left;
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Center(
            child: Container(
          height: MediaQuery.of(context).size.height / 2,
          child: AlertDialog(
            actions: [
              Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: MediaQuery.of(context).size.height * 0.070,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Aceptar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.white),
                        ),
                      ),
                    )),
              )
            ],
            contentPadding: EdgeInsets.all(10),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                  child: Text(
                fail,
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
              )),
            ),
            title: Center(
              child: Text(
                "Error",
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
              ),
            ),
          ),
        ));
      }
      return ListInvoiceHistoricalSimpleWidget(
        invoiceList: invoiceList!,
      );
    };
    return builder;
  }

  Widget rebuild(BuildContext context, UseCase uc) =>
      fututeBuilder = CustomFutureBuilder(
        future: getFutureByUseCase(uc),
        builder: getBuilderByUseCase(uc),
        context: context,
      );
}
