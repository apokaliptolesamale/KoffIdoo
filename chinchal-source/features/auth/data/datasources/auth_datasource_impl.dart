import 'dart:developer';
import 'dart:io';

import 'package:apk_template/features/auth/data/mappers/token_mapper.dart';
import 'package:dartz/dartz.dart';

import 'package:apk_template/config/errors/failure.dart';
import 'package:apk_template/features/auth/domain/domain.dart';
import 'package:apk_template/config/constants/environment.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/io.dart';

class AuthDatasourceImpl implements AuthDatasource {
  //final dio = Dio(BaseOptions(baseUrl: Environment.identityHost));
late dio.Dio _dio;
  AuthDatasourceImpl(
   // this.prefs
  ) {
    _dio= dio.Dio(dio.BaseOptions(
    baseUrl: Environment.identityHost,
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
  

  @override
  Future<TokenEntity> checkAuthStatus(String refreshToken, String accessToken) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TokenEntity>> login(String body) async {
    // ignore: deprecated_member_use
    /* (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    }; */

    final response = await _dio.post(
      Environment.tokenEndpoint,
      data: body,
      options: dio.Options(
          headers: Environment.defaultHeaders,
          contentType: 'application/x-www-form-urlencoded'),
    );
    if (response.data == null) {
      return Left(ServerFailure(errorMessage: "Error requesting token"));
    } else {
      log("Retornando token...");
      final data = TokenMapper.tokenJsonToEntity(response.data);
      return Right(data);
    }
  }

  @override
  Future<TokenEntity> refreshToken(String body) async {
    log("Iniciando renegociacion de Token");
    final resp = await _dio.post(Environment.tokenEndpoint,
        data: body,
        options: dio.Options(
            headers: Environment.defaultHeaders,
            contentType: 'application/x-www-form-urlencoded'));

    log("Obtenida respuesta desde el identity");
    if (resp.data == null) {
      return throw Exception();
    } else {
      log(resp.data.toString());
      return TokenMapper.tokenJsonToEntity(resp.data);
    }
  }
  
  @override
  Future<void> setLocalToken() {
    // TODO: implement setLocalToken
    throw UnimplementedError();
  }


  /* @override
  Future<ProfileModel> getLocalProfileModel() async{
   ProfileModel? result;
    String? profileJson;
    
    try {
      profileJson =  prefs.getString('profile');
          //await storage.read(key: "profile", aOptions: _getAndroidOptions());
      // log('En el datasource' + tokenJson!);
    } on Exception catch (e) {
      log("ERRRRRRORRR-->" + e.toString());
      throw Exception("No hay profile");
    }
    if (profileJson != null) {
      result = profileModelFromJson(profileJson);
    } else {
      result = null;
    }
    
 }
 
  @override
  Future<void> saveProfileModel(String idToken) async{/* 
    try {
      await ;
    } catch (e) {
      
    }
   */} */
}
