import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/helpers/extract_failure.dart';
import '/app/core/helpers/snapshot.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/interfaces/use_case.dart';
import '/app/core/services/store_service.dart';
import '/app/modules/transaction/clientinvoice_exporting.dart';
import '/app/modules/transaction/domain/models/client_service_model.dart';
import '/app/modules/transaction/domain/usecases/get_client_id_usecase.dart';
import '/app/modules/transaction/views/client_id_detail_view.dart';
import '/app/widgets/field/custom_get_view.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '/app/widgets/utils/loading.dart';
import '../domain/usecases/add_client_id_usecase.dart';
import '../domain/usecases/list_client_config_usecase.dart';
import '../widgets/payments_widgets/client_list_body_widget.dart';

class ClientIdListFrame extends CustomView<ClientInvoiceController> {
  late CustomFutureBuilder fututeBuilder;
  late UseCase usecase;
  String? codeS;
  String? type;
  Map<dynamic, dynamic>? parameters;
  late ClientServiceList<ClientServiceModel> clienIds;
  late ClientServiceModel clientId;
  ClientIdListFrame(
      {Key? key, this.parameters, required this.codeS, required this.type}) {
    Get.lazyPut(() => this);
    // usecase = ListClientInvoiceUseCase<ClientInvoiceModel>(Get.find());
    usecase = apply(
        ListClientConfigUseCase<EntityModelList<ClientServiceModel>>(
            Get.find()));
    // usecase = apply(ListClientIdUseCase<ClientInvoiceModel>(Get.find()));
  }

  AsyncWidgetBuilder addClientIdListBuilder<A>() {
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
        if (resultData.value is ClientServiceModel) {
          //ClientServiceList<ClientServiceModel> clienIds = resultData.value;
          return ClientIdDetailView();
        }
      } else if (isError(snapshot)) {
        //final dart.Left  resultData = snapshot.data as dart.Left;
        final fail = FailureExtractor.failure(snapshot.data as dart.Left);
        return Text(fail.message);
      }
      return ClientIdDetailView();
    };
    return builder;
  }

  UseCase apply(UseCase uc) {
    /* Store store = StoreService().getStore("IdClientsForm");
    Store addClientId = StoreService().getStore("addClientId");*/
    Map<String, dynamic> code = {
      "service_code": codeS,
      "limit": "100",
      "offset": "0"
    };

    uc = uc.setParamsFromMap(code);
    return uc;
  }

  @override
  Widget build(BuildContext context) => rebuild(context, usecase);

  @override
  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    if (uc is ListClientConfigUseCase) return getClientIdListBuilder<A>();
    if (uc is GetClientIdUseCase) return addClientIdListBuilder<A>();
    if (uc is AddClientIdUseCase) return getClientIdListBuilder<A>();
    return getClientIdListBuilder();
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

  Widget rebuild(BuildContext context, UseCase uc) =>
      fututeBuilder = CustomFutureBuilder(
        future: getFutureByUseCase(uc),
        builder: getBuilderByUseCase(uc),
        context: context,
      );
}
