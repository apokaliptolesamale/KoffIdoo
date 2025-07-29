import 'package:dartz/dartz.dart';
import '/app/modules/transaction/domain/models/invoice_charged_model.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/repository.dart';

abstract class InvoiceRepository<InvoiceModel>
    extends Repository<InvoiceModel> {
  Future<Either<Failure, InvoiceModel>> getInvoice(dynamic id);

  Future<Either<Failure,EntityModelList<InvoiceModel> >> getInvoiceByClientId( Map<String, dynamic> filters);

 Future<Either<Failure, InvoiceModel>> getClientId(Map<String,dynamic> params);

 Future<Either<Failure, InvoiceChargedModel>> payElectricityService(Map<String ,dynamic> params);
  
  @override
  Future<Either<Failure, EntityModelList<InvoiceModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<InvoiceModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, InvoiceModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<InvoiceModel>>> getBy(Map params);

  @override
  Future<Either<Failure, InvoiceModel>> update(
      dynamic entityId, dynamic entity);

  @override
  Future<Either<Failure, InvoiceModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, InvoiceModel>> add(dynamic entity);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<InvoiceModel>>> filter(
      Map<String, dynamic> filters);

  @override
  DataSource buildDataSource(String path);
}
