import 'dart:convert';
import 'dart:developer';

import 'package:apk_template/config/helpers/functions.dart';
import 'package:apk_template/features/auth/data/models/profile_model.dart';
import 'package:apk_template/features/auth/domain/domain.dart';
import 'package:apk_template/features/auth/data/infraestructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/shared.dart';



final authRepositoryProvider = Provider<AuthRepository>((ref)=> AuthRepositoryImpl());

//---Provider
final authProvider = StateNotifierProvider<AuthNotifier, Authstate>((ref) {
  final keyValueStorageService = KeyValueStorageserviceImpl();
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(
    keyValueStorageService: keyValueStorageService,
    authRepository: authRepository,
  );
});

//---Notifier
class AuthNotifier extends StateNotifier<Authstate> {
  final KeyValueStorageservice keyValueStorageService;
  final AuthRepository authRepository;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(Authstate()) {
    checkAuthStatus();
  }

  Future<void> _setLoggued(TokenEntity token) async {
     keyValueStorageService.setKeyValue<String>(
        'token', TokenMapper.tokenEntityToJson(token));
   
    
    if(await keyValueStorageService.containsKey('profile')){
      log('Ya se tiene el perfil, se debe llamar a este metodo para renegociar el token');
    final  profileJson=  await keyValueStorageService.getValue<String>('profile');
   final profileModel= ProfileModel.fromJson(json.decode(profileJson!) as Map<String,dynamic>);
       state = state.copyWith(
      authStatus: AuthStatus.authenticated,
      token: token,
      errorMessage: '',
      profile: profileModel
    );
    }else{

   await saveProfile(token);

    }
  }

  Future<void> login(String code) async {
    await keyValueStorageService.setKeyValue<String>('authCode', code);
    String? codeVerifier =
        await keyValueStorageService.getValue<String>('codeVerifier');
    final failureOrToken = await authRepository.login(code, codeVerifier!);
    failureOrToken.fold((newFailure) {
      state = state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          token: null,
          errorMessage: newFailure.errorMessage);
    }, (tokenEntity) async {
      TokenEntity newTokenEntity= TokenEntity().copyWith(
        accessToken: tokenEntity.accessToken,
        expiresIn: tokenEntity.expiresIn,
        idToken: tokenEntity.idToken,
        refreshToken: tokenEntity.refreshToken,
        scope: tokenEntity.scope,
        tokenType: tokenEntity.tokenType,
        expTime: DateTime.now().add(Duration(seconds: tokenEntity.expiresIn!)).toString(),
        );
     await _setLoggued(newTokenEntity);
    //saveProfile();
   
    });
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.clearData();
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      errorMessage: errorMessage,
    );
  }

  Future<void> checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');
    if (token == null) return logout();
    TokenEntity tokenEntity = TokenMapper.tokenJsonToEntity(json.decode(token));
    if (tokenEntity.expTime!=null&&  DateTime.now()
        .isAfter(DateTime.parse(tokenEntity.expTime!))) {
      final checkToken = await authRepository.checkAuthStatus(tokenEntity);
      _setLoggued(checkToken);
    } else {
      TokenEntity newTokenEntity= TokenEntity().copyWith(
        accessToken: tokenEntity.accessToken,
        expiresIn: tokenEntity.expiresIn,
        idToken: tokenEntity.idToken,
        refreshToken: tokenEntity.refreshToken,
        scope: tokenEntity.scope,
        tokenType: tokenEntity.tokenType,
        expTime: DateTime.now().add(Duration(seconds: tokenEntity.expiresIn!)).toString(),
        );
      _setLoggued(newTokenEntity);
    }
  }

  Future<void> saveProfile(TokenEntity token)async{
    //final token=state.token;
    log('Este es el TokenModel para salvar ==>$token ');
    final String profile= decodeIdToken(token.idToken!);
    log('Este es el profile a salvar==> $profile');
    ProfileModel profileModel= profileModelFromJson(profile);
    await keyValueStorageService.setKeyValue<String>('profile', profile).whenComplete(() => log('Se terminó de guardar el perfil'));
    state = state.copyWith(
      authStatus: AuthStatus.authenticated,
      token: token,
      errorMessage: '',
      profile: profileModel);
  }

Future<void> getProfile()async{
final ProfileModel profile= await keyValueStorageService.getValue('profile').whenComplete(() => log('Se ha cargado el profile'));
log('Este es el profile guardado==> ${profile.toJson()}');
state= state.copyWith(profile: profile);
}

}

//---State
class Authstate {
  final AuthStatus authStatus;
  final String errorMessage;
  final TokenEntity? token;
  final ProfileModel? profile;

  Authstate({
    this.token,
    this.authStatus = AuthStatus.checking,
    this.errorMessage = '',
    this.profile
  });

  Authstate copyWith(
          {AuthStatus? authStatus, String? errorMessage, TokenEntity? token,ProfileModel? profile}) =>
      Authstate(
        authStatus: authStatus ?? this.authStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        token: token ?? this.token,
        profile:profile??this.profile 
      );
}

enum AuthStatus { checking, authenticated, notAuthenticated }
