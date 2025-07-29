// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import '/app/modules/transaction/domain/usecases/pay_service_usecase.dart';
import '../domain/models/etecsa_invoice_model.dart';
import '../domain/usecases/get_factura_mensual_etecsa_usecase.dart';
import '../domain/usecases/delete_client_id_usecase.dart';
import '../domain/usecases/list_client_config_usecase.dart';
import '/app/modules/transaction/domain/models/invoice_charged_model.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '/app/modules/transaction/domain/usecases/get_invoice_by_client_id_usecase.dart';
import 'package:get/get.dart';

import '/app/modules/transaction/domain/models/client_service_model.dart';
import '../domain/usecases/add_client_id_usecase.dart';
import '/app/modules/transaction/domain/usecases/get_client_id_usecase.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/clientinvoice_model.dart';
import '../domain/usecases/delete_clientinvoice_usecase.dart';
import '../domain/usecases/filter_clientinvoice_usecase.dart';
import '../domain/usecases/get_clientinvoice_usecase.dart';
import '../domain/usecases/getby_clientinvoice_usecase.dart';
import '../domain/usecases/list_clientinvoice_usecase.dart';
import '../domain/usecases/update_clientinvoice_usecase.dart';

class ClientInvoiceController extends GetxController {
  AddClientIdUseCase<ClientServiceModel> addClientInvoice =
      AddClientIdUseCase<ClientServiceModel>(Get.find());
  DeleteClientInvoiceUseCase<ClientInvoiceModel> deleteClientInvoice =
      DeleteClientInvoiceUseCase<ClientInvoiceModel>(Get.find());
  GetClientInvoiceUseCase<ClientInvoiceModel> getClientInvoice =
      GetClientInvoiceUseCase<ClientInvoiceModel>(Get.find());
  GetClientInvoiceByFieldUseCase<ClientInvoiceModel> getClientInvoiceByField =
      GetClientInvoiceByFieldUseCase<ClientInvoiceModel>(Get.find());
  UpdateClientInvoiceUseCase<ClientInvoiceModel> updateClientInvoice =
      UpdateClientInvoiceUseCase<ClientInvoiceModel>(Get.find());
  ListClientInvoiceUseCase<ClientInvoiceModel>
      listClientInvoiceUseClientInvoice =
      ListClientInvoiceUseCase<ClientInvoiceModel>(Get.find());
  FilterClientInvoiceUseCase<ClientInvoiceModel> filterUseClientInvoice =
      FilterClientInvoiceUseCase<ClientInvoiceModel>(Get.find());
  GetClientIdUseCase<ClientInvoiceModel> getCliendIdUseCase =
      GetClientIdUseCase<ClientInvoiceModel>(Get.find());
  PayServiceUseCase<InvoiceChargedModel> payServiceUseCase =
      PayServiceUseCase<InvoiceChargedModel>(Get.find());
  GetInvoiceByClientIdUseCase<EntityModelList<InvoiceModel>>
      getInvoiceByClientIdUseCase = GetInvoiceByClientIdUseCase(Get.find());
  ListClientConfigUseCase<EntityModelList<ClientServiceModel>>
      listClientConfigUseCase =
      ListClientConfigUseCase<EntityModelList<ClientServiceModel>>(Get.find());
  GetFactMensualEtecsaUseCase getFactMensualEtecsaUseCase =
      GetFactMensualEtecsaUseCase(Get.find());
  DeleteClientClientIdUseCase<ClientServiceModel> deleteClientClientIdUseCase =
      DeleteClientClientIdUseCase<ClientServiceModel>(Get.find());
  ClientInvoiceController() : super();

  Future<Either<Failure, ClientServiceModel>> deleteClientId() =>
      deleteClientClientIdUseCase.deleteClientID();

  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>>
      getClientInvoices() => listClientInvoiceUseClientInvoice.getAll();

  Future<Either<Failure, EntityModelList<ClientServiceModel>>>
      listClientConfig() => listClientConfigUseCase.listConfigService();

  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>>
      filterClientInvoices() => filterUseClientInvoice.filter();

  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> getClient() =>
      getCliendIdUseCase.getClientId();

  Future<Either<Failure, ClientServiceModel>> addClient() =>
      addClientInvoice.addClientId();

  Future<Either<Failure, EntityModelList<InvoiceModel>>>
      getInvoiceByClientId() =>
          getInvoiceByClientIdUseCase.getInvoiceByClientId();
  Future<Either<Failure, EtecsaModel>> getFactMensualEtecsa() =>
      getFactMensualEtecsaUseCase.call(null);

  Future<Either<Failure, InvoiceChargedModel>> payInvoice() =>
      payServiceUseCase.payService();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is ListClientInvoiceUseCase<ClientInvoiceModel>) {
      listClientInvoiceUseClientInvoice = uc;
      result = getClientInvoices().then((value) => Future.value(value as T));
    } else if (uc is GetClientIdUseCase<ClientInvoiceModel>) {
      getCliendIdUseCase = uc;
      result = getClient().then((value) => Future.value(value as T));
    } else if (uc is AddClientIdUseCase<ClientServiceModel>) {
      addClientInvoice = uc;
      result = getClient().then((value) => Future.value(value as T));
    } else if (uc is PayServiceUseCase<InvoiceChargedModel>) {
      payServiceUseCase = uc;
      result = payInvoice().then((value) => Future.value(value as T));
    } else if (uc
        is GetInvoiceByClientIdUseCase<EntityModelList<InvoiceModel>>) {
      getInvoiceByClientIdUseCase = uc;
      result = getInvoiceByClientId().then((value) => Future.value(value as T));
    } else if (uc
        is ListClientConfigUseCase<EntityModelList<ClientServiceModel>>) {
      listClientConfigUseCase = uc;
      result = listClientConfig().then((value) => Future.value(value as T));
    } else if (uc
        is GetInvoiceByClientIdUseCase<EntityModelList<InvoiceModel>>) {
      getInvoiceByClientIdUseCase = uc;
      result = getInvoiceByClientId().then((value) => Future.value(value as T));
    } else if (uc is GetFactMensualEtecsaUseCase) {
      getFactMensualEtecsaUseCase = uc;
      result = getFactMensualEtecsa().then((value) => Future.value(value as T));
    } else {
      result = getClientInvoices().then((value) => Future.value(value as T));
    }
    return result;
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
