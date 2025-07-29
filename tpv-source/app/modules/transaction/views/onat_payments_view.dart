// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/constants/enums.dart';
import '/app/core/helpers/extract_failure.dart';
import '/app/core/interfaces/use_case.dart';
import '/app/core/services/logger_service.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '/app/modules/transaction/domain/usecases/filter_invoice_usecase.dart';
import '/app/modules/transaction/domain/usecases/list_invoice_usecase.dart';
import '/app/modules/transaction/invoice_exporting.dart';
import '/app/modules/transaction/widgets/payments_widgets/onat_payment_widget.dart';
import '/app/widgets/field/custom_get_view.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '/app/widgets/utils/loading.dart';

class OnatinvoiceView extends CustomView<InvoiceController> {
  late UseCase useCase;
  late CustomFutureBuilder customFutureBuilder;
  late InvoiceModel invoice;
  late InvoiceList<InvoiceModel> invoices;
  late String limit,
      start,
      startDate,
      endDate,
      transctionType,
      transactionStatus;
  late bool getall;
  GlobalViewMode? mode;

  OnatinvoiceView(/*{
  Key? key,
  required this.transactionList}*/
      ) {
    Get.lazyPut(() => this);
    limit = Get.parameters.containsKey("limit")
        ? Get.parameters["limit"] ?? ""
        : "10";
    start = Get.parameters.containsKey("start")
        ? Get.parameters["limit"] ?? ""
        : "0";
    endDate = Get.parameters.containsKey("endDate")
        ? Get.parameters["endDate"] ?? ""
        : "";
    transctionType = Get.parameters.containsKey("transctionType")
        ? Get.parameters["transctionType"] ?? ""
        : "";
    startDate = Get.parameters.containsKey("startDate")
        ? Get.parameters["startDate"] ?? ""
        : "";
    transactionStatus = Get.parameters.containsKey("transactionStatus")
        ? Get.parameters["transactionStatus"] ?? ""
        : "";
    useCase = ListInvoiceUseCase<InvoiceModel>(Get.find());
    if (transctionType != "" ||
        transactionStatus != "" ||
        startDate != "" ||
        endDate != "") {
      useCase = FilterInvoiceUseCase<InvoiceModel>(Get.find());
      useCase = useCase.setParamsFromMap(Get.parameters);
    }
    log(useCase);
  }

  @override
  Widget build(BuildContext context) {
    return rebuild(context, useCase);
  }

  @override
  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    mode = Get.parameters.containsKey("mode")
        ? ViewMode(Get.parameters["mode"] ?? GlobalViewMode.visible.name).mode
        : GlobalViewMode.visible;
    if (uc is ListInvoiceUseCase) return getTransactionListBuilder<A>();
    if (uc is FilterInvoiceUseCase) return getTransactionListBuilder<A>();
    return getTransactionListBuilder();
  }

  @override
  Future<T> getFutureByUseCase<T>(UseCase uc) {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }

  AsyncWidgetBuilder<A> getTransactionListBuilder<A>() {
    {
      builder(BuildContext context, AsyncSnapshot<A> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return EmptyDataSearcherResult(
            child: Loading.fromText(
                key: key, text: "Cargando listado de pagos..."),
          );
        } else if (isDone(snapshot)) {
          final Right resultData = snapshot.data as Right;
          if (resultData.value is InvoiceList<InvoiceModel>) {
            invoices = resultData.value;
          }
          return OnatinvoiceWidget(
            invoices: invoices,
          );
        } else if (isError(snapshot)) {
          /* return TransaccionesView(
        transactionList: [] as TransactionList,
        );*/
          final fail = FailureExtractor.message(snapshot.data as Left);
          return Text(fail);
        }
        return Loading.fromText(key: key, text: "Cargando listado de pagos...");
      }

      return builder;
    }
  }

  bool isDone(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
        snapshot.hasData &&
        snapshot.data is Right;
  }

  bool isError(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data is Left ||
        snapshot.error != null;
  }

  Widget rebuild(BuildContext context, UseCase uc) =>
      customFutureBuilder = CustomFutureBuilder(
        future: getFutureByUseCase(uc),
        builder: getBuilderByUseCase(uc),
        context: context,
      );
}

class OnatinvoiceWidget extends GetView<InvoiceController> {
  InvoiceList invoices;
  OnatinvoiceWidget({
    Key? key,
    required this.invoices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* FloatingActionButtonAnimator myButton =
        FloatingActionButtonAnimator.scaling;*/

    return Scaffold(
        appBar: AppBar(
          title: const Text('Correos de Cuba'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
          actions: [
            TextButton(
              child: Text("Historial"),
              onPressed: () {},
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              //Get.toNamed(Routes.HOME);
            },
          ),
        ),
        body: ShowTaxesWidget() //CubanEmailServiceInvoices()
        );
  }
}
