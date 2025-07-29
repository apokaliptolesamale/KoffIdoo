import 'dart:developer';

import '../../../../config/errors/failure.dart';
import '../datasources/account_local_datasource.dart';
import '../datasources/account_remote_datasource.dart';
import '../models/account_model.dart';
import '../../domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;
  final AccountLocalDataSource localDataSource;

AccountRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });


 @override
   Future<Either<Failure, AccountModel>> getAccountModel(String userName , String accessToken) async {
    try {
    var response =  await remoteDataSource.getAccountModel(userName , accessToken);
       return response.fold(
        (l) => Left(l), (r) => Right(r));
    
    } catch (e) {
      log(e.toString());
      // await ias.deleteAuthorizationCode();
      rethrow;
    }
  }

}





