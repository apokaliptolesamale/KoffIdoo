import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/repository.dart';

abstract class PaymentRepository<PaymentModel>
    extends Repository<PaymentModel> {
  Future<Either<Failure, PaymentModel>> getPayment(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<PaymentModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<PaymentModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, PaymentModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<PaymentModel>>> getBy(Map params);

  @override
  Future<Either<Failure, PaymentModel>> update(
      dynamic entityId, dynamic entity);

  @override
  Future<Either<Failure, PaymentModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, PaymentModel>> add(dynamic entity);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<PaymentModel>>> filter(
      Map<String, dynamic> filters);

  @override
  DataSource buildDataSource(String path);
}
