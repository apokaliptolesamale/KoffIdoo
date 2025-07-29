// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/bank_model.dart';
import '../domain/usecases/filter_bank_usecase.dart';
import '../domain/usecases/get_bank_usecase.dart';
import '../domain/usecases/getby_bank_usecase.dart';
import '../domain/usecases/list_bank_usecase.dart';

class BankController extends GetxController {
  GetBankUseCase<BankModel> getBank = GetBankUseCase<BankModel>(Get.find());
  GetBankByFieldUseCase<BankModel> getBankByField =
      GetBankByFieldUseCase<BankModel>(Get.find());

  ListBankUseCase<BankModel> listBankUseBank =
      ListBankUseCase<BankModel>(Get.find());
  FilterBankUseCase<BankModel> filterUseBank =
      FilterBankUseCase<BankModel>(Get.find());

  BankController() : super();

  Future<Either<Failure, EntityModelList<BankModel>>> filterBanks() =>
      filterUseBank.filter();

  Future<Either<Failure, EntityModelList<BankModel>>> getBankByFieldUseCase() =>
      getBankByField.call(null);

  Future<Either<Failure, EntityModelList<BankModel>>> getBanks() =>
      listBankUseBank.getAll();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterBankUseCase) {
      result = filterBanks().then((value) => Future.value(value as T));
    } else if (uc is GetBankByFieldUseCase) {
      result =
          getBankByFieldUseCase().then((value) => Future.value(value as T));
    } else {
      result = getBanks().then((value) => Future.value(value as T));
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
