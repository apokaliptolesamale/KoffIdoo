import 'package:dartz/dartz.dart';
import '../../../../config/errors/failure.dart';
import '../repositories/merchant_repository.dart';
import '../models/operation_model.dart';

class FilterOperationsMerchantUseCase {
  final MerchantRepository merchantRepository;

  FilterOperationsMerchantUseCase(this.merchantRepository);

  Future<Either<Failure, ListOperationMerchantModel >> call(Map<String,dynamic> paramsToFilter , String accessToken) async {
    return await merchantRepository.filterOperationsMerchantModel(paramsToFilter, accessToken);
  }
}