import '../../../../config/errors/failure.dart';
import '../../data/models/account_model.dart';
import 'package:dartz/dartz.dart';

abstract class AccountRepository {
Future<Either<Failure, AccountModel>> getAccountModel(String userName , String accessToken);

}