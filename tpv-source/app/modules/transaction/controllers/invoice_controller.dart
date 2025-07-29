// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import '/app/modules/transaction/domain/models/invoice_by_client_model.dart';
import '/app/modules/transaction/domain/usecases/get_invoice_by_client_id_usecase.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/invoice_model.dart';
import '../domain/usecases/add_invoice_usecase.dart';
import '../domain/usecases/delete_invoice_usecase.dart';
import '../domain/usecases/filter_invoice_usecase.dart';
import '../domain/usecases/get_invoice_at_month_usecase.dart';
import '../domain/usecases/getby_invoice_usecase.dart';
import '../domain/usecases/list_invoice_usecase.dart';
import '../domain/usecases/update_invoice_usecase.dart';

class InvoiceController extends GetxController {
  AddInvoiceUseCase<InvoiceModel> addInvoice =
      AddInvoiceUseCase<InvoiceModel>(Get.find());
  DeleteInvoiceUseCase<InvoiceModel> deleteInvoice =
      DeleteInvoiceUseCase<InvoiceModel>(Get.find());
  GetMonthlyInvoiceUseCase<InvoiceModel> getInvoice =
      GetMonthlyInvoiceUseCase<InvoiceModel>(Get.find());
  GetInvoiceByFieldUseCase<InvoiceModel> getInvoiceByField =
      GetInvoiceByFieldUseCase<InvoiceModel>(Get.find());
  UpdateInvoiceUseCase<InvoiceModel> updateInvoice =
      UpdateInvoiceUseCase<InvoiceModel>(Get.find());
  ListInvoiceUseCase<InvoiceModel> listInvoiceUseInvoice =
      ListInvoiceUseCase<InvoiceModel>(Get.find());
  FilterInvoiceUseCase<InvoiceModel> filterUseInvoice =
      FilterInvoiceUseCase<InvoiceModel>(Get.find());
  GetInvoiceByClientIdUseCase<InvoiceByClientModel> getInvoiceByClientIdUseCase = GetInvoiceByClientIdUseCase(Get.find());

  
  InvoiceController() : super();

  Future<Either<Failure, EntityModelList<InvoiceModel>>> filterInvoices() =>
      filterUseInvoice.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterInvoiceUseCase<InvoiceModel>) {
      filterUseInvoice = uc;
      result = filterInvoices().then((value) => Future.value(value as T));
    } else if (uc is ListInvoiceUseCase<InvoiceModel>) {
      listInvoiceUseInvoice = uc;
      result = getInvoices().then((value) => Future.value(value as T));
    } else {
      result = Future.value();
    }
    return result;
  }

  Future<Either<Failure, EntityModelList<InvoiceModel>>> getInvoices() =>
      listInvoiceUseInvoice.getInvoices();

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
