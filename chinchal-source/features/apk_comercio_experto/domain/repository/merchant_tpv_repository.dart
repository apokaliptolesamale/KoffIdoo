// import 'package:dartz/dartz.dart';
// import '../../../../core/interfaces/entity_model.dart';
// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/interfaces/data_source.dart';
// import '../../../../core/interfaces/repository.dart';

// abstract class MerchantTpvRepository<MerchantPaymentModel>
//     extends Repository<MerchantPaymentModel> {
//   Future<Either<Failure, MerchantPaymentModel>> getProduct(dynamic id);

//   @override
//   Future<Either<Failure, EntityModelList<MerchantPaymentModel>>> getAll();

//   @override
//   Future<Either<Failure, EntityModelList<MerchantPaymentModel>>> paginate(
//       int start, int limit, Map params);

//   @override
//   Future<Either<Failure, MerchantPaymentModel>> get(dynamic entityId);

//   @override
//   Future<Either<Failure, EntityModelList<MerchantPaymentModel>>> getBy(Map params);

//   @override
//   Future<Either<Failure, MerchantPaymentModel>> update(
//       dynamic entityId, dynamic entity);

//   @override
//   Future<Either<Failure, MerchantPaymentModel>> delete(dynamic entityId);

//   @override
//   Future<Either<Failure, MerchantPaymentModel>> add(dynamic entity);

//   @override
//   Future<Either<Failure, bool>> exists(dynamic entityId);

//   @override
//   Future<Either<Failure, EntityModelList<MerchantPaymentModel>>> filter(
//       Map<String, dynamic> filters);

//   @override
//   DataSource buildDataSource(String path);
// }
