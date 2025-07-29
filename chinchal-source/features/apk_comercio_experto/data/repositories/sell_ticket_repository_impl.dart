import 'package:apk_template/features/apk_comercio_experto/data/models/sell_ticket_model.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/datasources/sell_tickets_datasource.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/repository/sell_tickets_repository.dart';

class SellTicketRepositoryImpl extends SellTicketsRepository {
  final SellTicketsDatasource sellTicketsDatasource;

  SellTicketRepositoryImpl({required this.sellTicketsDatasource});

  @override
  Future<void> clearTickets() {
    return sellTicketsDatasource.clearTickets();
  }

  @override
  Future<List<SellTicketModel>> getSellTicket() {
    return sellTicketsDatasource.getSellTicket();
  }

  @override
  Future<void> postSellTicket(SellTicketModel ticket) {
    return sellTicketsDatasource.postSellTicket(ticket);
  }
}
