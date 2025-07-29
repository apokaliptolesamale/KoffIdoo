import 'package:dartz/dartz.dart';
import '../../../../config/config.dart';
import '../models/merchant_model.dart';
import '../repositories/merchant_repository.dart';

class FilterMerchantUseCase {
  final MerchantRepository merchantRepository;

  FilterMerchantUseCase(this.merchantRepository);

  Future<Either<Failure, ListMerchantModel>> call(Map<String,dynamic> paramsToFilter , String accessToken) async {
    return await merchantRepository.filterMerchantModel(paramsToFilter, accessToken);
  }
}