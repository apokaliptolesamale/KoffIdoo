import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/repository.dart';

abstract class DonationRepository<DonationModel>
    extends Repository<DonationModel> {
  Future<Either<Failure, DonationModel>> getDonation(dynamic id);

  @override
  Future<Either<Failure, EntityModelList<DonationModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<DonationModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, DonationModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<DonationModel>>> getBy(Map params);

  @override
  Future<Either<Failure, DonationModel>> update(
      dynamic entityId, dynamic entity);

  @override
  Future<Either<Failure, DonationModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, DonationModel>> add(dynamic entity);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<DonationModel>>> filter(
      Map<String, dynamic> filters);

  @override
  DataSource buildDataSource(String path);
}
