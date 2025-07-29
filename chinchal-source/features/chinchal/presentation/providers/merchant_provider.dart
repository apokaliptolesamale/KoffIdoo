import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../account/data/models/account_model.dart';
import '../../../auth/data/mappers/token_mapper.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../shared/shared.dart';
import '../../data/datasources/merchant_local_datasource.dart';
import '../../data/datasources/merchant_remote_datasource.dart';
import '../../data/repositories/merchant_repository_impl.dart';
import '../../domain/models/merchant_model.dart';
import '../../domain/models/qr_code_model.dart';
import '../../domain/models/refund_model.dart';
import '../../domain/repositories/merchant_repository.dart';
import '../../domain/usecases/add_qr_code_use_case.dart';
import '../../domain/usecases/add_refund_use_case.dart';
import '../../domain/usecases/filter_merchants_use_case.dart';

final localDataSourceProvider =
    Provider<MerchantLocalDataSource>((ref) => MerchantLocalDataSourceImpl());
final remoteDataSourceProvider =
    Provider<MerchantRemoteDataSource>((ref) => MerchantRemoteDatasourceImpl());
final merchantRepositoryProvider = Provider<MerchantRepository>((ref) =>
    MerhcantRepositoryImpl(
        remoteDataSource: ref.watch(remoteDataSourceProvider),
        localDataSource: ref.watch(localDataSourceProvider)));
final filterMerchantUseCaseProvider = Provider<FilterMerchantUseCase>(
    (ref) => FilterMerchantUseCase(ref.watch(merchantRepositoryProvider)));

final addQrCodeModelUseCaseProvider = Provider<AddQrCodeModelUseCase>(
    (ref) => AddQrCodeModelUseCase(ref.watch(merchantRepositoryProvider)));
final addRefundModelUseCaseProvider = Provider<AddRefundUseCase>(
    (ref) => AddRefundUseCase(ref.watch(merchantRepositoryProvider)));

final merchantLengthProvider = StateProvider<int?>((ref) {
  return;
});

final filterMerchantProvider = FutureProvider.autoDispose
    .family<ListMerchantModel?, AccountModel>((ref, account) async {
  final keyValueStorageService = KeyValueStorageserviceImpl();
  final check = ref.read(authProvider.notifier).checkAuthStatus;
  await check();
  final state = ref.read(authProvider);

  Map<String, dynamic> params = {
    'limit': '10',
    'offset': '0',
    'username': account.username
  };

  final tokenChecked = state.token;
  final listMerchant = await ref
      .read(filterMerchantUseCaseProvider)
      .call(params, tokenChecked!.accessToken!);

  return listMerchant.fold((l) async {
    log(l.errorMessage);
    if (l.errorMessage == 'Unithorized') {
      final tokenRenew =
          await ref.read(authRepositoryProvider).checkAuthStatus(tokenChecked);
      keyValueStorageService.setKeyValue<String>(
          'token', TokenMapper.tokenEntityToJson(tokenRenew));
      final listMerchant = await ref
          .read(filterMerchantUseCaseProvider)
          .call(params, tokenRenew.accessToken!);
      return listMerchant.fold((l) {
        log(l.errorMessage);
        return null;
      }, (merchants) {
        ref
            .read(merchantLengthProvider.notifier)
            .update((state) => merchants.content!.length);
        return merchants;
      });
    } else {
      log(l.errorMessage);
      return null;
    }
  }, (r) {
    log('Lista de comercios==> $r');
    ref
        .read(merchantLengthProvider.notifier)
        .update((state) => r.content!.length);
    return r;
  });
});



final merchantSelectedProvider = StateProvider<MerchantModel?>((ref) {
  return;
});

final addQrCodeProvider = FutureProvider.autoDispose
    .family<QrCodeModel?, AddQrCodeModel>((ref, addQrCodeModel) async {
  //QrCodeModel qrCodeModel=QrCodeModel();
  final keyValueStorageService = KeyValueStorageserviceImpl();
  ref.watch(authRepositoryProvider);
  final check = ref.read(authProvider.notifier).checkAuthStatus;
  await check();
  final state = ref.read(authProvider);
  //final token= ref.watch(checkTokenProvider);
  final tokenChecked = state.token;
  final qrCode = await ref
      .read(addQrCodeModelUseCaseProvider)
      .call(addQrCodeModel, tokenChecked!.accessToken!);
  return qrCode.fold((l) async {
    log(l.errorMessage);
    if (l.errorMessage == 'Unithorized') {
      final tokenRenew =
          await ref.read(authRepositoryProvider).checkAuthStatus(tokenChecked);
      keyValueStorageService.setKeyValue<String>(
          'token', TokenMapper.tokenEntityToJson(tokenRenew));
      final qrCode = await ref
          .read(addQrCodeModelUseCaseProvider)
          .call(addQrCodeModel, tokenRenew.accessToken!);
      return qrCode.fold((l) {
        log(l.errorMessage);
        return null;
      }, (qrModel) {
        // qrCodeModel=qrModel;
        return qrModel;
      });
    } else {
      log(l.errorMessage);
      return null;
    }
  }, (r) {
    log('QrCode==> $r');
    // qrCodeModel=r;
    return r;
  });
  /* if(token.hasValue){
    
    
  } */
});

final addRefundProvider = FutureProvider.autoDispose
    .family<RefundModel?, Map<String, dynamic>>((ref, map) async {
  //QrCodeModel qrCodeModel=QrCodeModel();
  final addRefundModel = map['addRefundModel'] as AddRefundModel;
  final transactionUuid = map['transactionUuid'] as String;
  final keyValueStorageService = KeyValueStorageserviceImpl();
  ref.watch(authRepositoryProvider);
  final check = ref.read(authProvider.notifier).checkAuthStatus;
  await check();
  final state = ref.read(authProvider);
  //final token= ref.watch(checkTokenProvider);
  final tokenChecked = state.token;
  final refund = await ref
      .read(addRefundModelUseCaseProvider)
      .call(addRefundModel, transactionUuid, tokenChecked!.accessToken!);
  return refund.fold((l) async {
    log(l.errorMessage);
    if (l.errorMessage == 'Unithorized') {
      final tokenRenew =
          await ref.read(authRepositoryProvider).checkAuthStatus(tokenChecked);
      keyValueStorageService.setKeyValue<String>(
          'token', TokenMapper.tokenEntityToJson(tokenRenew));
      final refund = await ref
          .read(addRefundModelUseCaseProvider)
          .call(addRefundModel, transactionUuid, tokenRenew.accessToken!);
      return refund.fold((l) {
        log(l.errorMessage);
        return null;
      }, (refundModel) {
        // qrCodeModel=qrModel;
        return refundModel;
      });
    } else {
      log(l.errorMessage);
      return null;
    }
  }, (r) {
    log('refundModel==> $r');
    // qrCodeModel=r;
    return r;
  });
  /* if(token.hasValue){
    
    
  } */
});
