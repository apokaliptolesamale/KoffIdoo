import '../models/clientinvoice_model.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';

class ClientInvoice {
  final dynamic clientId;
  final InvoiceList<InvoiceModel>? invoices;
  String? gasClientId;
  String? merchantAlias;
  final InvoiceList<InvoiceModel>? gasInvoices;
  String? resultmsg;
  String? success;
  String? name;
  Datalist? datalist;

  ClientInvoice({
    required this.gasClientId,
    required this.gasInvoices,
    required this.clientId,
    required this.invoices,
    required this.merchantAlias,
    this.resultmsg,
    this.success,
    this.name,
    this.datalist,
  });
}
