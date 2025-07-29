import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:apk_template/config/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/io.dart';
import 'package:dio/dio.dart'as dio;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../config/constants/environment.dart';
import '../../../../config/errors/fault.dart';
import '../models/account_model.dart';


abstract class AccountRemoteDataSource {
  Future<Either<Failure, AccountModel>> getAccountModel(String userName, String accessToken);
}

class AccountRemoteDatasourceImpl 
    implements AccountRemoteDataSource {
  //final SharedPreferences prefs;
  late dio.Dio _dio;
  AccountRemoteDatasourceImpl(
   // this.prefs
  ) {
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
   SharedPreferences prefs=await SharedPreferences.getInstance();
    TokenModel? tokenModel;
    String? accessToken;
    String? tokenJson =  prefs.getString('token');
    //String? tokenJson = await prefs.read(key: "token" ,  aOptions: _getAndroidOptions(),);
    tokenModel = TokenModel.fromJson(tokenJson!);
    accessToken = tokenModel.accessToken;
      
   
   return Future.value(accessToken);
  } */

  /* @override
  void onInit()async {
   super.httpClient.baseUrl = 'https://${MainConstants.apiEndpoint}/';
   super.httpClient.timeout = const Duration(seconds: 40);
   super.httpClient.defaultContentType = 'application/json';
    super.httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) {
        return AccountModel.fromJson(map["account"]);
      }
    };
    

    httpClient.addAuthenticator<dynamic>((request)async {
      request.headers["Authorization"] = "Bearer ${await getAccesToken()}";
      return request;
    });
    
  } */

  @override
  Future<Either<Failure, AccountModel>> getAccountModel(String userName  , String accessToken) async {
    try {
      log("Antes de buscar la cuenta en el datasource");
      // Map<String , dynamic> headers = {}
  //  String accessToken = await getAccesToken();
  log('Este es el accessToken==> $accessToken');
  log('Este es el username==> $userName');
  Map<String , String>headers = Environment.getHttpDefaulHeader(accessToken);
      final resp = await _dio.get(

        //TODO ERROR CHECK
        "/account/v1.0.0/account?username=$userName",
        options:dio.Options(headers: headers),
        
      );
      if (resp.statusCode != 200) {
        
        return Left(resp.data);
      } else if(resp.statusCode == 401){
        log(resp.data);
        return Left(resp.data);
      }
      else {
        log("ESTE ES MAP>>>${resp.data}");
          if (resp.data is Map<String, dynamic> && resp.data.containsKey("account")) {
            return Right(AccountModel.fromJson(resp.data["account"]));//AccountModel.fromJson(resp.data["account"]);
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
      return  Left(faultFromJson(e.toString()));
      
    }
  }
}
