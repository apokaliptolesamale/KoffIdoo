import 'package:dartz/dartz.dart';

import '../../../../config/config.dart';
import '../models/qr_code_model.dart';
import '../repositories/merchant_repository.dart';

class AddQrCodeModelUseCase {
  final MerchantRepository merchantRepository;

  AddQrCodeModelUseCase(this.merchantRepository);

  Future<Either<Failure, QrCodeModel >> call(AddQrCodeModel addQrCodeModel , String accessToken) async {
    return await merchantRepository.addQrCodeModel(addQrCodeModel, accessToken);
  }
}