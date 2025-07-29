import 'dart:developer';

import 'package:apk_template/features/chinchal/domain/models/refund_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/errors/failure.dart';
import '../../domain/models/merchant_model.dart';
import '../../domain/models/operation_model.dart';
import '../../domain/models/qr_code_model.dart';
import '../../domain/repositories/merchant_repository.dart';
import '../datasources/merchant_local_datasource.dart';
import '../datasources/merchant_remote_datasource.dart';

class MerhcantRepositoryImpl implements MerchantRepository {
  final MerchantRemoteDataSource remoteDataSource;
  final MerchantLocalDataSource localDataSource;

MerhcantRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });


  
  @override
  Future<Either<Failure, ListMerchantModel>> filterMerchantModel(Map<String, dynamic> paramsToFilter, String accessToken) async{
    
    try {
    var response =  await remoteDataSource.filterMerchantModel(paramsToFilter, accessToken);
       return response.fold(
        (l) => Left(l), (r) => Right(r));
    
    } catch (e) {
      log(e.toString());
      // await ias.deleteAuthorizationCode();
      rethrow;
    }
  
  }
  
  @override
  Future<Either<Failure, ListOperationMerchantModel >> filterOperationsMerchantModel(Map<String, dynamic> paramsToFilter, String accessToken) async{
    try {
    var response =  await remoteDataSource.filterOperationsMerchantModel(paramsToFilter, accessToken);
       return response.fold(
        (l) => Left(l), (r) => Right(r));
    
    } catch (e) {
      log(e.toString());
      // await ias.deleteAuthorizationCode();
      rethrow;
    }
  }

  @override
  Future<Either<Failure, QrCodeModel>> addQrCodeModel(AddQrCodeModel addQrCodeModel, String accessToken) async{
    try {
    var response =  await remoteDataSource.addQrCodeModel(addQrCodeModel, accessToken);
       return response.fold(
        (l) => Left(l), (r) => Right(r));
    
    } catch (e) {
      log(e.toString());
      // await ias.deleteAuthorizationCode();
      rethrow;
    } 
  }

  @override
  Future<Either<Failure, RefundModel>> addRefund(AddRefundModel addRefundModel, String transactionUuid, String accessToken) async{
    try {
    var response =  await remoteDataSource.addRefund(addRefundModel,transactionUuid ,accessToken);
       return response.fold(
        (l) => Left(l), (r) => Right(r));
    
    } catch (e) {
      log(e.toString());
      // await ias.deleteAuthorizationCode();
      rethrow;
    } 
  }
  
  

}