import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/mappers/token_mapper.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../shared/shared.dart';
import '../../data/datasources/merchant_local_datasource.dart';
import '../../data/datasources/merchant_remote_datasource.dart';
import '../../data/repositories/merchant_repository_impl.dart';
import '../../domain/models/operation_model.dart';
import '../../domain/repositories/merchant_repository.dart';
import '../../domain/usecases/filter_operations_merchant_use_case.dart';

final localDataSourceProvider = Provider<MerchantLocalDataSource>((ref)=> MerchantLocalDataSourceImpl());
final remoteDataSourceProvider = Provider<MerchantRemoteDataSource>((ref)=> MerchantRemoteDatasourceImpl());
final merchantRepositoryProvider = Provider<MerchantRepository>((ref)=>MerhcantRepositoryImpl(
  remoteDataSource: ref.watch(remoteDataSourceProvider),
  localDataSource: ref.watch(localDataSourceProvider)
  ));
final filterOperationsMerchantUseCaseProvider = Provider<FilterOperationsMerchantUseCase>((ref)=> FilterOperationsMerchantUseCase(ref.watch(merchantRepositoryProvider)));

final filterOperationsMerchantProvider = FutureProvider.autoDispose.family<ListOperationMerchantModel?,Map<String,dynamic>>((ref,map) async {
  //ListOperationMerchantModel listMerchantsOperations= ListOperationMerchantModel(content: []); 
  final keyValueStorageService = KeyValueStorageserviceImpl(); 
 final check=  ref.read(authProvider.notifier).checkAuthStatus;
 await check();
 final state= ref.read(authProvider);
  Map<String,dynamic> params={
    'limit': map['limit'].toString(),
    'offset': map['offset'].toString(),
    'merchant_uuid': map['merchantUUID'],
    'endDateTime':'2025-02-02'
    };
  final tokenChecked= state.token;  
  //log('Este  es el accessToken antes de renegociar ==> ${tokenChecked!.accessToken}');
   log('Este es el accessToken checkeado==> ${tokenChecked!.accessToken}');
    final listMerchantOperations= await ref.read(filterOperationsMerchantUseCaseProvider).call(params,tokenChecked.accessToken!);
 return listMerchantOperations.fold((l)async{
    log(l.errorMessage);
    if(l.errorMessage=='Unithorized'){
       final tokenRenew= await ref.read(authRepositoryProvider).checkAuthStatus(tokenChecked);
      keyValueStorageService.setKeyValue<String>('token', TokenMapper.tokenEntityToJson(tokenRenew));
    final listMerchantOperations= await ref.read(filterOperationsMerchantUseCaseProvider).call(params,tokenRenew.accessToken!);
  return listMerchantOperations.fold((l) {
    log(l.errorMessage);
    return null;
  }, (r){
    //listMerchantsOperations=r;
    return r;
  });
    }else{
      log(l.errorMessage);
      return null;
    }
  }, (r) {
    log('Lista de comercios==> $r');
    //listMerchantsOperations=r;
    return r;
  });
  /* final token= ref.watch(checkTokenProvider);
  if(token.hasValue){
   
  } */
  
 //return listMerchantsOperations;
});