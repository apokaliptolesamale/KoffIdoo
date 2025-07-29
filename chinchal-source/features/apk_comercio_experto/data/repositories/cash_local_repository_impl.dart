import 'package:apk_template/features/apk_comercio_experto/domain/datasources/cash_local_datasource.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/cash_model.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/entities/cash_entity.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/repository/cash_local_repository.dart';

class CashLocalRepositoryImpl implements CashLocalRepository {
  final CashLocalDatasource cashLocalDatasource;

  CashLocalRepositoryImpl({required this.cashLocalDatasource});

  @override
  Future<List<CashModel>> getListOfCash() async {
    return cashLocalDatasource.getListOfCash();
  }

  @override
  Future<void> insertInitialCashData() {
    return cashLocalDatasource.insertInitialCashData();
  }

  @override
  Future<void> updateListCash(List<CashModel> listOfCash) {
    return cashLocalDatasource.updateListCash(listOfCash);
  }

  @override
  Future<void> updateCash(CashModel entity) {
    return cashLocalDatasource.updateCash(entity);
  }
}
