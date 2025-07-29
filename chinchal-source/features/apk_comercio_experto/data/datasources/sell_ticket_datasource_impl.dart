
import 'package:apk_template/features/apk_comercio_experto/data/models/sell_ticket_model.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/datasources/sell_tickets_datasource.dart';

import '../../../../config/services/sqlite_database.dart';

class SellTicketsDatasourceImpl extends SellTicketsDatasource {
  final SqlLiteDataBase database = SqlLiteDataBase();

  SellTicketsDatasourceImpl();

  @override
  Future<List<SellTicketModel>> getSellTicket() async {
    try {
      return await database.getSellTickets();
    } catch (e) {
      throw Exception('Error al obtener los tickets de venta: $e');
    }
  }

  @override
  Future<void> postSellTicket(SellTicketModel ticket) async {
    try {
      await database.insertSellTicket(ticket);
    } catch (e) {
      throw Exception('Error al guardar el ticket de venta: $e');
    }
  }

  @override
  Future<void> clearTickets() async {
    try {
      await database.clearSellTickets();
    } catch (e) {
      throw Exception('Error al eliminar los tickets de venta: $e');
    }
  }
}
