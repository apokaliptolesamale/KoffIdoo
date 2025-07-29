import 'package:apk_template/features/chinchal/domain/models/refund_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/errors/failure.dart';
import '../repositories/merchant_repository.dart';

class AddRefundUseCase {
  final MerchantRepository merchantRepository;

  AddRefundUseCase(this.merchantRepository);

  Future<Either<Failure, RefundModel >> call(AddRefundModel addRefundModel , String transactionUuid,String accessToken) async {
    return await merchantRepository.addRefund(addRefundModel, transactionUuid, accessToken);
  }
}