import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/extract_failure.dart';
import '../../../core/helpers/snapshot.dart';
import '../../../core/interfaces/use_case.dart';
import '../../../core/services/store_service.dart';
import '../../../widgets/field/custom_get_view.dart';
import '../../../widgets/panel/custom_empty_data_search.dart';
import '../../../widgets/promise/custom_future_builder.dart';
import '../../../widgets/utils/loading.dart';
import '../controllers/clientinvoice_controller.dart';
import '../domain/models/clientinvoice_model.dart';
import '../domain/usecases/list_clientinvoice_usecase.dart';
import '../widgets/client_invoice_widget.dart';

class InvoiceListFrameView extends CustomView<ClientInvoiceController> {
  String? serviceCode;
  late CustomFutureBuilder fututeBuilder;
  late UseCase usecase;
  Map<dynamic, dynamic>? parameters;
  late ClientInvoiceList<ClientInvoiceModel> facturas;
  InvoiceListFrameView({Key? key, this.parameters, this.serviceCode}) {
    Get.lazyPut(() => this);
    // usecase = ListClientInvoiceUseCase<ClientInvoiceModel>(Get.find());
    usecase = apply(ListClientInvoiceUseCase<ClientInvoiceModel>(Get.find()));
  }

  UseCase apply(UseCase uc) {
    Store store = StoreService().getStore("ListInvoices");

    store.add("service_code", serviceCode);
    Map<String, dynamic> params = {"service_code": serviceCode};
    if (params.isNotEmpty) {
      uc = ListClientInvoiceUseCase<ClientInvoiceModel>(Get.find());
      uc = uc.setParamsFromMap(params);
    }
    // uc = uc.setParamsFromMap(store.getMapFields);
    return uc;
  }

  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  @override
  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    if (uc is ListClientInvoiceUseCase) return getInvoiceListBuilder<A>();
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
          child: Loading.fromText(
              key: key, text: "Cargando listado de facturas..."),
        );
      } else if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data is dart.Left) {
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Text(fail);
      } else if (isDone(snapshot)) {
        final resultData = snapshot.data as dart.Right;
        if (resultData.value is ClientInvoiceList<ClientInvoiceModel>) {
          Store store = StoreService().getStore("ListInvoices");
          store.flush();
          ClientInvoiceList<ClientInvoiceModel> facturas = resultData.value;
          return ClientInvoiceWidget(context: context, facturas: facturas);
        }
      } else if (isError(snapshot)) {
        //final dart.Left  resultData = snapshot.data as dart.Left;
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Text(fail);
      }
      return ClientInvoiceWidget(
        context: context,
        facturas: facturas,
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
