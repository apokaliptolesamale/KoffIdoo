import '../../../../config/errors/failure.dart';
import '../../data/models/account_model.dart';
import '../repositories/account_repository.dart';
import 'package:dartz/dartz.dart';

class GetAccountModelUseCase {
  final AccountRepository accountRepository;

  GetAccountModelUseCase(this.accountRepository);

  Future<Either<Failure, AccountModel>> call(String userName , String accessToken) async {
    return await accountRepository.getAccountModel(
       userName , accessToken);
  }
}