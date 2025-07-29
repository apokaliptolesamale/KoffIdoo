import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:apk_template/config/config.dart';
import 'package:apk_template/features/auth/domain/domain.dart';
import 'package:apk_template/features/auth/data/datasources/auth_datasource_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl({AuthDatasource? authDatasource})
      : authDatasource = authDatasource ?? AuthDatasourceImpl();

  @override
  Future<TokenEntity> checkAuthStatus(TokenEntity token) async {
    log('Entrando a checkAuthStatus');
    final refreshToken = token.refreshToken;
    var body = 'client_id=${Environment.clientId}&grant_type=refresh_token';
    body = '$body&refresh_token=$refreshToken';
    final newToken = await authDatasource.refreshToken(body);
    return newToken;
  }

  @override
  Future<Either<Failure, TokenEntity>> login(
      String code, String codeVerifier) async {
    var body =
        'client_id=${Environment.clientId}&grant_type=authorization_code';
    body = '$body&redirect_uri=${Environment.redirectUri}';
    body = '$body&post_logout_redirect_uri=/';
    body = '$body&code=$code&code_verifier=$codeVerifier';
    final response = await authDatasource.login(body);
    return response;
  }

  @override
  Future<TokenEntity> refreshToken(String body) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  /* @override
  Future<ProfileModel?> getLocalProfile()async{
    
    log('Entrando a getToken securityRepository');
    final profile = await authDatasource.getLocalProfileModel();
    if (profile != null) {
      log("Local Profile: $profile");
      return Future.value(profile);
    } else {
      log("Error en get local Profile");
      return Future.value(null);
    }

  }
  
  @override
  Future<void> saveProfileModel(String idToken) async{
    try {
      await authDatasource.saveProfileModel(idToken);
      
    } on Exception{
      throw StoreException();
    }
  } */
}
