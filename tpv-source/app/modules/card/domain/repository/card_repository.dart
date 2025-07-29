import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';

abstract class CardRepository<CardModel> extends Repository<CardModel> {
  @override
  Future<Either<Failure, CardModel>> add(dynamic entity);

  @override
  DataSource buildDataSource(String path);

  @override
  Future<Either<Failure, CardModel>> delete(dynamic entityId);

  @override
  Future<Either<Failure, bool>> exists(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<CardModel>>> filter(
      Map<String, dynamic> filters);

  @override
  Future<Either<Failure, CardModel>> get(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<CardModel>>> getAll();

  @override
  Future<Either<Failure, EntityModelList<CardModel>>> getBy(Map params);

  Future<Either<Failure, CardModel>> getCard(dynamic id);

  Future<Either<Failure, CardModel>> getFirstCard();

  Future<Either<Failure, CardModel>> getSetAsDefault(dynamic entityId);

  @override
  Future<Either<Failure, EntityModelList<CardModel>>> paginate(
      int start, int limit, Map params);

  @override
  Future<Either<Failure, CardModel>> update(dynamic entityId, dynamic entity);
}
