import 'package:apk_template/features/chinchal/domain/models/refund_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/errors/failure.dart';
import '../models/merchant_model.dart';
import '../models/operation_model.dart';
import '../models/qr_code_model.dart';

abstract class MerchantRepository {
  Future<Either<Failure, ListMerchantModel>> filterMerchantModel( Map<String, dynamic> paramsToFilter, String accessToken);

  Future<Either<Failure, ListOperationMerchantModel>>filterOperationsMerchantModel(Map<String, dynamic> paramsToFilter, String accessToken);

  Future<Either<Failure, QrCodeModel>> addQrCodeModel(AddQrCodeModel addQrCodeModel, String accessToken);
  Future<Either<Failure, RefundModel>> addRefund(AddRefundModel addRefundModel, String transactionUuid, String accessToken);
}
