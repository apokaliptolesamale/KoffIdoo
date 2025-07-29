import 'package:dartz/dartz.dart';
import '../models/etecsa_invoice_model.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '/app/modules/transaction/domain/models/client_service_model.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/repository.dart';

abstract class ClientInvoiceRepository<ClientInvoiceModel>
    extends Repository<ClientInvoiceModel> {
  Future<Either<Failure, ClientInvoiceModel>> getClientInvoice(dynamic id);

  Future<Either<Failure, ClientServiceModel>> deleteClientId(dynamic clientId);

  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> getClientId(
      Map params);

  Future<Either<Failure, ClientServiceModel>> addClientId(dynamic entity);

  Future<Either<Failure, EntityModelList<InvoiceModel>>> payElectricityService(
      Map<String, dynamic> params);

  Future<Either<Failure, EntityModelList<ClientServiceModel>>> listClientConfig(
      Map<String, dynamic> params);

  @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, ClientInvoiceModel>> get(dynamic entityId);
  @override
  Future<Either<Failure, EtecsaModel>> getFactMensualEtecsa(
      Map<String, dynamic> params);

  @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> getBy(
      Map params);

  @override
  Future<Either<Failure, ClientInvoiceModel>> update(
      dynamic entityId, dynamic entity);

  @override
  Future<Either<Failure, ClientInvoiceModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, ClientInvoiceModel>> add(dynamic entity);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> filter(
      Map<String, dynamic> filters);

  @override
  DataSource buildDataSource(String path);
}
