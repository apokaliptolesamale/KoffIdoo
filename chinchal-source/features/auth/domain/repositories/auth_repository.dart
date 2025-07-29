import 'package:dartz/dartz.dart';
import 'package:apk_template/config/config.dart';
import 'package:apk_template/features/auth/domain/domain.dart';


abstract class AuthRepository {
  Future<Either<Failure, TokenEntity>> login(String code, String codeVerifier);
  Future<TokenEntity> checkAuthStatus(TokenEntity token);
  Future<TokenEntity> refreshToken(String body);
  /* Future<ProfileModel?> getLocalProfile();
  Future<void> saveProfileModel(String idToken); */
}
