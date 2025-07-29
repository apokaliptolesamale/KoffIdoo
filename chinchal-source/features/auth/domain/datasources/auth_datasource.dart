import 'package:dartz/dartz.dart';

import 'package:apk_template/config/config.dart';
import 'package:apk_template/features/auth/domain/domain.dart';


abstract class AuthDatasource {
  Future<Either<Failure, TokenEntity>> login(String body);
  Future<TokenEntity> checkAuthStatus(String refreshToken, String accessToken);
  Future<TokenEntity> refreshToken(String body);
  /* Future<ProfileModel> getLocalProfileModel();
  Future<void>saveProfileModel(String idToken); */
  Future<void> setLocalToken();
}
