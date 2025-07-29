import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/helpers/extract_failure.dart';
import '/app/core/helpers/snapshot.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/store_service.dart';
import '/app/modules/transaction/clientinvoice_exporting.dart';
import '/app/modules/transaction/domain/usecases/add_client_id_usecase.dart';
import '/app/modules/transaction/domain/usecases/get_client_id_usecase.dart';
import '/app/modules/transaction/views/client_id_detail_view.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/utils/loading.dart';
import '../../../core/interfaces/use_case.dart';
import '../../../widgets/field/custom_get_view.dart';
import '../../../widgets/promise/custom_future_builder.dart';
import '../domain/models/client_service_model.dart';
import '../domain/models/clientinvoice_model.dart';
import '../domain/usecases/list_client_config_usecase.dart';
import '../widgets/payments_widgets/client_list_body_widget.dart';

class ClientIdAddFrame extends CustomView<ClientInvoiceController> {
  late CustomFutureBuilder fututeBuilder;
  late UseCase usecase;
  Map<dynamic, dynamic>? parameters;
  late ClientInvoiceList<ClientInvoiceModel> client;
  late ClientServiceList<ClientServiceModel> clienIds;
  int? codeS;
  String? type;
  ClientIdAddFrame({
    Key? key,
    this.parameters,
  }) {
    Get.lazyPut(() => this);
    // usecase = GetClientIdUseCase<ClientInvoiceModel>(Get.find());
    usecase = apply(ListClientConfigUseCase<ClientServiceModel>(Get.find()));
  }
  UseCase apply(UseCase uc) {
    Store store = StoreService().getStore("IdClientsForm");

    if (store.getMapFields.isNotEmpty) {
      uc = GetClientIdUseCase<ClientInvoiceModel>(Get.find());
      uc = uc.setParamsFromMap(store.getMapFields);
      return uc;
    }
    return uc;
  }

  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  @override
  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    if (uc is GetClientIdUseCase) return getTransactionListBuilder<A>();
    if (uc is AddClientIdUseCase) return getClientIdListBuilder<A>();
    return getTransactionListBuilder();
  }

  AsyncWidgetBuilder getClientIdListBuilder<A>() {
    // ignore: prefer_function_declarations_over_variables
    var builder = (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return EmptyDataSearcherResult(
          child: Loading.fromText(
              key: key, text: "Cargando listado de transacciones..."),
        );
      } else if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data is dart.Left) {
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Text(fail);
      } else if (isDone(snapshot)) {
        Store store = StoreService().getStore("IdClientsForm");
        store.flush();
        final resultData = snapshot.data as dart.Right;
        if (resultData.value is ClientServiceList<ClientServiceModel>) {
          ClientServiceList<ClientServiceModel> clienIds = resultData.value;
          return ClientListBodyWidget(
            clienIds: clienIds,
            type: type!,
          );
        }
      } else if (isError(snapshot)) {
        //final dart.Left  resultData = snapshot.data as dart.Left;
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Text(fail);
      }
      return ClientListBodyWidget(
        clienIds: clienIds,
        type: type!,
      );
    };
    return builder;
  }

  @override
  Future<T> getFutureByUseCase<T>(UseCase uc) async {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }

  AsyncWidgetBuilder getTransactionListBuilder<A>() {
    Store store = StoreService().getStore("IdClientsForm");
    String code = store.getMapFields["serviceCode"].toString();
    int codeInt = int.parse(code);
    // ignore: prefer_function_declarations_over_variables
    var builder = (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return EmptyDataSearcherResult(
            child: Loading(
          text: "Cargando listado de transacciones...",
          backgroundColor: Colors.lightBlue.shade700,
          animationColor:
              AlwaysStoppedAnimation<Color>(Colors.lightBlue.withOpacity(0.8)),
          containerColor: Colors.lightBlueAccent.withOpacity(0.2),
        ));
      } else if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data is dart.Left) {
        //final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Center(
            child: Container(
          height: MediaQuery.of(context).size.height / 2,
        ));
      } else if (isDone(snapshot)) {
        Store store = StoreService().getStore("IdClientsForm");
        store.flush();
        log(store.getMapFields);
        final resultData = snapshot.data as dart.Right;
        if (resultData.value is ClientInvoiceList<ClientInvoiceModel>) {
          ClientInvoiceList<ClientInvoiceModel> client = resultData.value;
          return ClientIdDetailView(clientModel: client, typeService: codeInt);
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
      return ClientIdDetailView(clientModel: client, typeService: codeInt);
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
