// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import '/app/modules/transaction/domain/usecases/get_client_id_usecase.dart';
import '../domain/models/client_service_model.dart';
import '/app/modules/transaction/domain/usecases/list_client_id_usecase.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';



class ClientServiceController extends GetxController {

  
  GetClientIdUseCase<ClientServiceModel> getClientService = GetClientIdUseCase<ClientServiceModel>(Get.find());
 /* DeleteTransactionUseCase<ClientServiceModel> deleteTransaction = DeleteTransactionUseCase<ClientServiceModel>(Get.find());
  UpdateTransactionUseCase<ClientServiceModel> updateTransaction = UpdateTransactionUseCase<ClientServiceModel>(Get.find());*/
  ListClientIdUseCase<ClientServiceModel> listClientService = ListClientIdUseCase<ClientServiceModel>(Get.find());

  
  
  ClientServiceController() : super();

  Future<Either<Failure, EntityModelList<ClientServiceModel>>> getClientIds() =>
      listClientService.getAll();

      
  

  /*Future<Either<Failure, EntityModelList<ClientServiceModel>>> filterTransactions() =>
      filterUseTransaction.filter();*/

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
     if(uc is ListClientIdUseCase<ClientServiceModel>) {
     listClientService = uc;
      result = getClientIds().then((value) => Future.value(value as T));
    }
  else{
      result =Future.value();
  }
  return result ;
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