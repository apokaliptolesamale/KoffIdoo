import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/cash_local_datasource_impl.dart';
import '../../data/models/cash_model.dart';
import '../../data/repositories/cash_local_repository_impl.dart';
import '../../domain/repository/cash_local_repository.dart';

// Proveedor del repositorio
final cashLocalRepositoryProvider = Provider<CashLocalRepository>(
  (ref) => CashLocalRepositoryImpl(
    cashLocalDatasource: CashLocalDatasourceImpl(),
  ),
);

// Proveedor del Notifier
final cashProvider = ChangeNotifierProvider<CashNotifier>(
  (ref) => CashNotifier(ref.watch(cashLocalRepositoryProvider)),
);

class CashNotifier extends ChangeNotifier {
  final CashLocalRepository cashLocalRepository;
  List<CashModel> cash = [];
  bool _isInitialized = false;

  CashNotifier(this.cashLocalRepository) {
    _loadCash();
  }

  Future<void> _loadCash() async {
    final existingCash = await cashLocalRepository.getListOfCash();
    if (existingCash.isEmpty) {
      await cashLocalRepository.insertInitialCashData();
      cash = await cashLocalRepository.getListOfCash();
    } else {
      cash = existingCash;
    }
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> updateCash(int index, int cantidad) async {
    if (index < 0 || index >= cash.length) return;
    cash[index] = cash[index].copyWith(cantidad: cantidad);
    await cashLocalRepository.updateCash(cash[index]);
    notifyListeners();
  }

  int calculateTotal() {
    return cash.fold(0, (total, cash) => total + ((cash.cantidad ?? 0) * (cash.valor ?? 0)));
  }
}
