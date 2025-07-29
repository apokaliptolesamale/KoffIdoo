import 'dart:developer';
import 'dart:io';

import 'package:apk_template/config/config.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/io.dart';
import 'package:dio/dio.dart'as dio;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../config/errors/fault.dart';
import '../../domain/models/merchant_model.dart';
import '../../domain/models/operation_model.dart';
import '../../domain/models/qr_code_model.dart';
import '../../domain/models/refund_model.dart';

abstract class MerchantRemoteDataSource {
  Future<Either<Failure, ListMerchantModel>> filterMerchantModel(Map<String,dynamic> paramsToFilter, String accessToken);
  Future<Either<Failure, ListOperationMerchantModel>> filterOperationsMerchantModel(Map<String,dynamic> paramsToFilter, String accessToken);
  Future<Either<Failure, QrCodeModel>> addQrCodeModel(AddQrCodeModel addQrCodeModel, String accessToken);
  Future<Either<Failure, RefundModel>> addRefund(AddRefundModel addRefundModel, String transactionUuid,String accessToken);
  
}

class MerchantRemoteDatasourceImpl 
    implements MerchantRemoteDataSource {
  
  late dio.Dio _dio;
  MerchantRemoteDatasourceImpl() {
    _dio= dio.Dio(dio.BaseOptions(
    baseUrl: Environment.apiEndpoint,
    //contentType: 'application/json',
    //headers: MainConstants.defaultHeaders,
    connectTimeout:  const Duration(seconds: 40)
 ));
 (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = (){
  HttpClient client=HttpClient();
  client.badCertificateCallback=(cert, host, port) => true;
  return client;
 };
 
  }
  AndroidOptions _getAndroidOptions() =>
       AndroidOptions();

  /* Future<String> getAccesToken() async {
    TokenModel? tokenModel;
    String? accessToken;
    String? tokenJson = await secureStorage.read(key: "token" ,  aOptions: _getAndroidOptions(),);
       if (tokenJson != null) {
      tokenModel = TokenModel.fromJson(tokenJson);
      accessToken = tokenModel.accessToken;
    } else {
      tokenModel = null;
    }
    
   
   return Future.value(accessToken);
  } */
  
  @override
  Future<Either<Failure, ListMerchantModel>> filterMerchantModel(Map<String,dynamic> paramsToFilter, String accessToken) async{
    
    try {
  log('Este es el accessToken==> $accessToken');
  log('Este es el mapa a filtrar==> $paramsToFilter');
  Map<String , String>headers = Environment.getHttpDefaulHeader(accessToken);
      final resp = await _dio.get(
        "/adminMerchant/1.0/api/merchants",
        options:dio.Options(headers: headers),
        queryParameters: paramsToFilter
      );
      if (resp.statusCode != 200) {
        
        return Left(resp.data);
      }else if(resp.statusCode == 401){
        log(resp.data);
        return Left(resp.data);
      } else {
        log("ESTE ES MAP>>>${resp.data}");
          if (resp.data is Map<String, dynamic> && !resp.data.containsKey("fault") && resp.data.containsKey("content")) {
            return Right(ListMerchantModel.fromJson(resp.data));
          } else if (resp.data is Map<String, dynamic> && resp.data.containsKey("fault")) {
            return Left(FaultClass.fromJson(resp.data["fault"]));
          }
          return Right(resp.data);
       
      }
    } on dio.DioException  catch (e) {
      if(e.response!.statusCode==401){
        log("Exception:>>>>${e.message}");
        return Left(ServerFailure(errorMessage: 'Unithorized'));
      }
      if(e.response!.statusCode!>=500){
        log("Exception:>>>>${e.message}");
        return Left(ServerFailure(errorMessage: 'Unithorized'));
      }
      log("Exception:>>>>${e.toString()}");
      return  Left(ServerFailure(errorMessage: e.toString()));
      
    }
  
  }
  
  @override
  Future<Either<Failure, ListOperationMerchantModel>> filterOperationsMerchantModel(Map<String, dynamic> paramsToFilter, String accessToken) async{
    
    try {
  log('Este es el accessToken==> $accessToken');
  log('Este es el mapa a filtrar==> $paramsToFilter');
  Map<String , String>headers = Environment.getHttpDefaulHeader(accessToken);
      final resp = await _dio.get(
        "/adminMerchant/1.0/api/operations",
        options:dio.Options(headers: headers),
        queryParameters: paramsToFilter
      );
      if (resp.statusCode != 200) {
        
        return Left(resp.data);
      } else if(resp.statusCode == 401){
        log(resp.data);
        return Left(resp.data);
      }else {
        log("ESTE ES MAP>>>${resp.data}");
          if (resp.data is Map<String, dynamic> && !resp.data.containsKey("fault") && resp.data.containsKey("content")) {
            return Right(ListOperationMerchantModel.fromJson(resp.data));
          } else if (resp.data is Map<String, dynamic> && resp.data.containsKey("fault")) {
            return Left(FaultClass.fromJson(resp.data["fault"]));
          }
          return Right(resp.data);
       
      }
    } on dio.DioException catch(e) {
      if(e.response!.statusCode==401){
        log("Exception:>>>>${e.message}");
        return Left(ServerFailure(errorMessage: 'Unithorized'));
      }
      log("Exception:>>>>${e.toString()}");
      return  Left(ServerFailure(errorMessage: e.toString()));
      
    }
  
  }
  
  @override
  Future<Either<Failure, QrCodeModel>> addQrCodeModel(AddQrCodeModel addQrCodeModel, String accessToken) async{
    
    try {
      log("Adicionando nueva entidad de tipo: QrCode.");
      log('Este es el model==> $addQrCodeModel');
      //AddQrCodeModel ad = entity as AddQrCodeModel;
      log('${addQrCodeModel.toJson()}');
      log('Este es el AccessToken dentro del datasource==> $accessToken');
      Map<String , String>headers = Environment.getHttpDefaulHeader(accessToken);
      String url = '/qr/v1.0.0/qr/merchant';
      final resp= await _dio.post(url,
      options:dio.Options(headers: headers),
      data: addQrCodeModel.toJson(),
      );

      if (resp.statusCode != 200) {
        
        return Left(resp.data);
      } else if(resp.statusCode == 401){
        log(resp.data);
        return Left(resp.data);
      }else {
        log("ESTE ES MAP>>>${resp.data}");
          if (resp.data is Map<String, dynamic> && !resp.data.containsKey("fault")) {
            return Right(QrCodeModel.fromJson(resp.data));
          } else if (resp.data is Map<String, dynamic> && resp.data.containsKey("fault")) {
            return Left(FaultClass.fromJson(resp.data["fault"]));
          }
          return Right(resp.data);
        }
      } on dio.DioException catch (e) {
        if(e.response!.statusCode==401){
        log("Exception:>>>>${e.message}");
        return Left(ServerFailure(errorMessage: 'Unithorized'));
      }
      log("Exception:>>>>${e.toString()}");
     return  Left(ServerFailure(errorMessage: e.toString()));
    }
  
  }
  
  @override
  Future<Either<Failure, RefundModel>> addRefund(AddRefundModel addRefundModel,transactionUuid, String accessToken) async{
   try {
      log("Adicionando nueva entidad de tipo: Refund.");
      log('Este es el model==> $addRefundModel');
      //AddQrCodeModel ad = entity as AddQrCodeModel;
      log('${addRefundModel.toJson()}');
      log('Este es el AccessToken dentro del datasource==> $accessToken');
      Map<String , String>headers = Environment.getHttpDefaulHeader(accessToken);
      String url = '/payment/v1.0.0/payments/$transactionUuid/refund';
      final resp= await _dio.post(url,
      options:dio.Options(headers: headers),
      data: addRefundModel.toJson(),
      );

      if (resp.statusCode != 200) {
        
        return Left(resp.data);
      } else if(resp.statusCode == 401){
        log(resp.data);
        return Left(resp.data);
      }else {
        log("ESTE ES MAP>>>${resp.data}");
          if (resp.data is Map<String, dynamic> && !resp.data.containsKey("fault")) {
            return Right(RefundModel.fromJson(resp.data));
          } else if (resp.data is Map<String, dynamic> && resp.data.containsKey("fault")) {
            return Left(FaultClass.fromJson(resp.data["fault"]));
          }
          return Right(resp.data);
        }
      } on dio.DioException catch (e) {
        if(e.response!.statusCode==401){
        log("Exception:>>>>${e.message}");
        return Left(ServerFailure(errorMessage: 'Unithorized'));
      }
      log("Exception:>>>>${e.toString()}");
     return  Left(ServerFailure(errorMessage: e.toString()));
    }
  }

}