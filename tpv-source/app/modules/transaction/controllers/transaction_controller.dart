// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/transaction_model.dart';
import '../domain/usecases/add_transaction_usecase.dart';
import '../domain/usecases/delete_transaction_usecase.dart';
import '../domain/usecases/filter_transaction_usecase.dart';
import '../domain/usecases/get_transaction_usecase.dart';
import '../domain/usecases/getby_transaction_usecase.dart';
import '../domain/usecases/list_transaction_usecase.dart';
import '../domain/usecases/update_transaction_usecase.dart';


class TransactionController extends GetxController {

  AddTransactionUseCase<TransactionModel> addTransaction = AddTransactionUseCase<TransactionModel>(Get.find());
  DeleteTransactionUseCase<TransactionModel> deleteTransaction = DeleteTransactionUseCase<TransactionModel>(Get.find());
  GetTransactionUseCase<TransactionModel> getTransaction = GetTransactionUseCase<TransactionModel>(Get.find());
  GetTransactionByFieldUseCase<TransactionModel> getTransactionByField = GetTransactionByFieldUseCase<TransactionModel>(Get.find());
  UpdateTransactionUseCase<TransactionModel> updateTransaction = UpdateTransactionUseCase<TransactionModel>(Get.find());
  ListTransactionUseCase<TransactionModel> listTransactionUseTransaction = ListTransactionUseCase<TransactionModel>(Get.find());
  FilterTransactionUseCase<TransactionModel> filterUseTransaction = FilterTransactionUseCase<TransactionModel>(Get.find());
  
  
  TransactionController() : super();

  Future<Either<Failure, EntityModelList<TransactionModel>>> getTransactions() =>
      listTransactionUseTransaction.getAll();

  Future<Either<Failure, EntityModelList<TransactionModel>>> filterTransactions() =>
      filterUseTransaction.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterTransactionUseCase<TransactionModel>) {
      filterUseTransaction = uc;
      result = filterTransactions().then((value) => Future.value(value as T));
    } else {
      result = getTransactions().then((value) => Future.value(value as T));
    }
    return result;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  
}
