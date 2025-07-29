import 'package:apk_template/features/apk_comercio_experto/data/models/sell_ticket_model.dart';

abstract class SellTicketsRepository {
  Future<List<SellTicketModel>> getSellTicket();
  Future<void> postSellTicket(SellTicketModel ticket);
  Future<void> clearTickets();
}
