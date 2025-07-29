import 'package:apk_template/features/apk_comercio_experto/data/models/cash_model.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/entities/cash_entity.dart';

abstract class CashLocalDatasource {
  Future<List<CashModel>> getListOfCash();
  Future<void> insertInitialCashData();
  Future<void> updateListCash(List<CashModel> entity);
  Future<void> updateCash(CashModel entity);
}
