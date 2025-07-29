import '../../domain/datasources/cash_local_datasource.dart';
import '../models/cash_model.dart';
import '../../../../config/services/sqlite_database.dart';

class CashLocalDatasourceImpl implements CashLocalDatasource {
  final SqlLiteDataBase _sqlDatabase = SqlLiteDataBase();

  @override
  Future<List<CashModel>> getListOfCash() async {
    final List<CashModel> cashList = await _sqlDatabase.getCashList();
    if (cashList.isEmpty) {
      // Si la lista está vacía, insertamos los datos iniciales
      await insertInitialCashData();
      // Luego obtenemos de nuevo los datos después de la inserción
      return await _sqlDatabase.getCashList();
    }
    return cashList;
  }

  @override
  Future<void> insertInitialCashData() async {
    final initialCashData = [
      CashModel(cantidad: 0, imagePath: 'assets/images/1CUP.png', valor: 1),
      CashModel(cantidad: 0, imagePath: 'assets/images/5CUP.png', valor: 5),
      CashModel(cantidad: 0, imagePath: 'assets/images/50CUP.png', valor: 50),
      CashModel(cantidad: 0, imagePath: 'assets/images/20CUP.png', valor: 20),
      CashModel(cantidad: 0, imagePath: 'assets/images/10CUP.png', valor: 10),
      CashModel(cantidad: 0, imagePath: 'assets/images/100CUP.png', valor: 100),
      CashModel(cantidad: 0, imagePath: 'assets/images/200CUP.png', valor: 200),
      CashModel(cantidad: 0, imagePath: 'assets/images/500CUP.png', valor: 500),
      CashModel(
          cantidad: 0, imagePath: 'assets/images/1000CUP.png', valor: 1000),
    ];

    for (var cash in initialCashData) {
      await _sqlDatabase.insertCash(cash);
    }
  }

  @override
  Future<void> updateListCash(List<CashModel> listofCash) async {
    return await _sqlDatabase.updateCashList(listofCash);
  }

  @override
  Future<void> updateCash(CashModel entity) async {
    return await  _sqlDatabase.updateCash(entity);
  }
}
