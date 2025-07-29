import 'dart:convert';
import 'dart:developer';

import 'package:apk_template/features/auth/data/infraestructure.dart';
import 'package:apk_template/features/auth/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/data/mappers/token_mapper.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../shared/shared.dart';
import '../../data/datasources/account_local_datasource.dart';
import '../../data/datasources/account_remote_datasource.dart';
import '../../data/models/account_model.dart';
import '../../data/repositories/account_repository_impl.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/usecase/get_account_model_use_case.dart';

//FlutterSecureStorage storage= const FlutterSecureStorage();
//*AccountLocalDataSourceProvider
final accountLocalDataSourceProvider =
    Provider<AccountLocalDataSource>((ref) => AccountLocalDataSourceImpl());

//*AccountRemoteDataSourceProvider
final accountRemoteDataSourceProvider =
    Provider<AccountRemoteDataSource>((ref) => AccountRemoteDatasourceImpl());



//*AccounRepositoryProvider
final accountRepositoryProvider = Provider<AccountRepository>((ref) =>
    AccountRepositoryImpl(
        remoteDataSource: ref.watch(accountRemoteDataSourceProvider),
        localDataSource: ref.watch(accountLocalDataSourceProvider)));

//*GetAccountModelUseCase
final getAccountUseCaseProvider = Provider<GetAccountModelUseCase>(
    (ref) => GetAccountModelUseCase(ref.watch(accountRepositoryProvider)));

//final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepositoryImpl());

final getAccountProvider = FutureProvider<AccountModel?>((ref) async {
  final keyValueStorageService = KeyValueStorageserviceImpl();
  final profile = ref.read(authProvider).profile;
  log('profile para pedir la cuenta ${profile!.toJson()}');
  //AccountModel? accountAux;
    if(await keyValueStorageService.containsKey('account')){
     final String? accountModelString= await( keyValueStorageService.getValue<String>('account'));
    final accountModel= AccountModel.fromJson(json.decode(accountModelString!));
     //accountAux=accountModel;
     return accountModel;
    }else{
     //final token= ref.watch(checkTokenProvider);
    //final account = await getAccountUseCase!.call(profile!.sub!, state.token!.accessToken!);
    final check=  ref.read(authProvider.notifier).checkAuthStatus;
 await check();
 final state= ref.read(authProvider);
 final token=state.token;
     final account= await ref.read(getAccountUseCaseProvider).call(profile.sub!, token!.accessToken!);
   return account.fold((l) async{
      log(l.errorMessage);
      if(l.errorMessage=='Unithorized'){
    final tokenRenew= await ref.read(authRepositoryProvider).checkAuthStatus(token);
      keyValueStorageService.setKeyValue<String>('token', TokenMapper.tokenEntityToJson(tokenRenew));
      final account= await ref.read(getAccountUseCaseProvider).call(profile.sub!, tokenRenew.accessToken!);
     return account.fold((l){
        log(l.errorMessage);
        return null;
      }, (account){
         //accountAux=account;
      keyValueStorageService.setKeyValue<String>(
        'account', json.encode(account.toJson()));
      return account;
      });
      }else{

      log('Error al obtener el account==> ${l.errorMessage}');
      return null;
      }
    }, (account) async{
      log('Este es el account que viene ==> ${account.toJson()}');
     //await saveAccount(r).whenComplete(() => log('Se ha completado la salva de la cuenta'));
     //accountAux=account;
      keyValueStorageService.setKeyValue<String>(
        'account', json.encode(account.toJson()));
      return account;
    });
   
    //return accountAux;
    /* final account= ref.watch(getAccountUseCaseProvider).call(userName, accessToken);
    account.fold((l) {
      log('Error al obtener el account==> ${l.errorMessage}');
    }, (r) async{
      log('Este es el account que viene ==> ${r.toJson()}');
      state = state.copyWith(account: r);
     await saveAccount(r).whenComplete(() => log('Se ha completado la salva de la cuenta'));
    });
     */
    
    }
  });

  final checkTokenProvider = FutureProvider<TokenEntity>((ref) async {
    final keyValueStorageService = KeyValueStorageserviceImpl();
     final token = await keyValueStorageService.getValue<String>('token');
    //if (token == null) return logout();
    // TokenModel tokenEntity = TokenModel.fromJson(json.decode(token!));
    TokenEntity tokenEntity = TokenMapper.tokenJsonToEntity(json.decode(token!));
    log('Esta es la hora actual ==> ${DateTime.now()}');
    //log('Esta es la fecha de expiracion del token ==> ${DateTime.parse(tokenEntity.expTime!.toString())}');
    if ( tokenEntity.expTime!=null&& DateTime.now().isAfter(DateTime.parse(tokenEntity.expTime!.toString()))) {
        final checkToken= await ref.watch(authRepositoryProvider).checkAuthStatus(tokenEntity);
//final checkToken = await authRepository!.checkAuthStatus(tokenEntity);
        TokenEntity newTokenEntity= TokenEntity().copyWith(
          accessToken: checkToken.accessToken,
        expiresIn: checkToken.expiresIn,
        idToken: checkToken.idToken,
        refreshToken: checkToken.refreshToken,
        scope: checkToken.scope,
        tokenType: checkToken.tokenType,
        expTime: DateTime.now().add(Duration(seconds: checkToken.expiresIn!)).toString()
        );
        keyValueStorageService.setKeyValue<String>(
        'token', TokenMapper.tokenEntityToJson(newTokenEntity)
        );
      return newTokenEntity;
    
    }  else {
      return tokenEntity;
    } 
  
 
  });

  final tokenStateProvider = StateNotifierProvider<TokenNotifier,TokenState>((ref) {
    final keyValueStorageService = KeyValueStorageserviceImpl();
    return TokenNotifier(authRepository: ref.read(authRepositoryProvider),keyValueStorageservice: keyValueStorageService);
  });


  class TokenNotifier extends StateNotifier<TokenState>{
   final KeyValueStorageservice? keyValueStorageservice;
   final AuthRepository? authRepository;
  TokenNotifier({
    this.keyValueStorageservice,
    this.authRepository
  }):super(TokenState());

   Future<void> checkToken()async{
    final keyValueStorageService = KeyValueStorageserviceImpl();
     final token = await keyValueStorageService.getValue<String>('token');
    //if (token == null) return logout();
    // TokenModel tokenEntity = TokenModel.fromJson(json.decode(token!));
    TokenEntity tokenEntity = TokenMapper.tokenJsonToEntity(json.decode(token!));
    log('Esta es la hora actual ==> ${DateTime.now()}');
    //log('Esta es la fecha de expiracion del token ==> ${DateTime.parse(tokenEntity.expTime!.toString())}');
    if ( tokenEntity.expTime!=null&& DateTime.now().isAfter(DateTime.parse(tokenEntity.expTime!))) {
        final checkToken= await authRepository!.checkAuthStatus(tokenEntity);
//final checkToken = await authRepository!.checkAuthStatus(tokenEntity);
        TokenEntity newTokenEntity= TokenEntity().copyWith(
          accessToken: checkToken.accessToken,
        expiresIn: checkToken.expiresIn,
        idToken: checkToken.idToken,
        refreshToken: checkToken.refreshToken,
        scope: checkToken.scope,
        tokenType: checkToken.tokenType,
        expTime: DateTime.now().add(Duration(seconds: checkToken.expiresIn!)).toString()
        );
        keyValueStorageService.setKeyValue<String>(
        'token', TokenMapper.tokenEntityToJson(newTokenEntity)
        );
        state= state.copyWith(
          tokenEntity: newTokenEntity
        );
      //return newTokenEntity;
    
    }  else {
      //return tokenEntity;
      state= state.copyWith(
          tokenEntity: tokenEntity
        );
    } 
  
 
  
   }

  }

  class TokenState{
    final TokenEntity? tokenEntity;
    TokenState( {
      this.tokenEntity,
    });

   TokenState copyWith(
    {
      final TokenEntity? tokenEntity
    }
   ){
    return TokenState(
      tokenEntity: tokenEntity??this.tokenEntity
    );
   }

  }

/* final accountStateProvider =
    StateNotifierProvider<AccountNotifier, AccountState>((ref) {
      final keyValueStorageService = KeyValueStorageserviceImpl();
  final profile = ref.watch(authProvider).profile;
  log('Este es el profile cargado para pedir cuenta ==> $profile');

  //ref.watch(authProvider.notifier).checkAuthStatus();
  
  final getLocalToken = ref.watch(authProvider).token;
  

  log('Este es el accessToken para pedir la cuenta ==> ${getLocalToken!.accessToken}');
  

  final prof = ref.watch(getAccountUseCaseProvider);
  final authRepository = AuthRepositoryImpl();
  return AccountNotifier(
      profile: profile, getAccountUseCase: prof,keyValueStorageService: keyValueStorageService,authRepository: authRepository);
});

  

class AccountNotifier extends StateNotifier<AccountState> {
  final KeyValueStorageservice? keyValueStorageService;
  final ProfileModel? profile;
  
  final GetAccountModelUseCase? getAccountUseCase;
  final AuthRepository? authRepository;
  AccountNotifier({this.profile, this.getAccountUseCase,this.keyValueStorageService,this.authRepository})
      : super(AccountState());

  Future<void> getAccount() async {
    if(await keyValueStorageService!.containsKey('account')){
     final AccountModel accountModel= await( keyValueStorageService!.getValue('account'));
      state=state.copyWith(account:accountModel);
    }else{
    final account =
        await getAccountUseCase!.call(profile!.sub!, state.token!.accessToken!);
    account.fold((l) {
      log('Error al obtener el account==> ${l.errorMessage}');
    }, (r) async{
      log('Este es el account que viene ==> ${r.toJson()}');
      state = state.copyWith(account: r);
     await saveAccount(r).whenComplete(() => log('Se ha completado la salva de la cuenta'));
    });
    
    
    }
  }

 Future<void> checkToken()async{
  
    final token = await keyValueStorageService!.getValue<String>('token');
    //if (token == null) return logout();
    TokenEntity tokenEntity = TokenMapper.tokenJsonToEntity(json.decode(token!));
    if (DateTime.now()
        .isAfter(DateTime.parse(tokenEntity.expTime!.toString()))) {
      final checkToken = await authRepository!.checkAuthStatus(tokenEntity);
        keyValueStorageService!.setKeyValue<String>(
        'token', TokenMapper.tokenEntityToJson(checkToken)
        ).whenComplete((){
          state = state.copyWith(token: checkToken);
        });
    
    }  else {
      state=state.copyWith(token:tokenEntity);
    } 
  
 }

Future<void> saveAccount(AccountModel account)async{
  await keyValueStorageService!.setKeyValue(
        'account', account.toJson());
}
}

class AccountState {
  final AccountModel? account;
  final TokenEntity? token;

  AccountState({this.account,this.token});

  AccountState copyWith({final AccountModel? account,final TokenEntity? token}) {
    return AccountState(
      account: account ?? this.account,
      token: token ?? this.token
    );
  }
} */
