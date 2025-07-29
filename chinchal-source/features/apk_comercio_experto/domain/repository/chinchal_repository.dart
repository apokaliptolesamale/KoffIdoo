// import 'package:dartz/dartz.dart';
// import '../../../../core/interfaces/entity_model.dart';
// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/interfaces/data_source.dart';
// import '../../../../core/interfaces/repository.dart';
// import '../../data/models/chinchal_merchants_model.dart';
// import '../../data/models/chinchal_operation_model.dart';
// import '../../data/models/chinchal_qrcode_model.dart';
// import '../../data/models/refund_model.dart';

// abstract class ChinchalRepository<ChinchalModel> extends Repository<ChinchalModel> {
//   Future<Either<Failure, ChinchalModel>> getChinchal(dynamic id);

//   @override
//   Future<Either<Failure, EntityModelList<ChinchalModel>>> getAll();

//   @override
//   Future<Either<Failure, EntityModelList<ChinchalModel>>> paginate(
//       int start, int limit, Map params);

//   @override
//   Future<Either<Failure, ChinchalModel>> get(dynamic entityId);

//   @override
//   Future<Either<Failure, EntityModelList<ChinchalModel>>> getBy(Map params);

//   @override
//   Future<Either<Failure, ChinchalModel>> update(dynamic entityId, dynamic entity);

//   @override
//   Future<Either<Failure, ChinchalModel>> delete(dynamic entityId);

//   @override
//   Future<Either<Failure, ChinchalModel>> add(dynamic entity);
  
  
//   Future<Either<Failure, RefundModel>> addRefund(dynamic entity,dynamic id);
  
//   Future<Either<Failure, ChinchalQrCodeModel>> addQRCode(dynamic entity);

//   @override
//   Future<Either<Failure, bool>> exists(dynamic entityId);

//   @override
//   Future<Either<Failure, EntityModelList<ChinchalModel>>> filter(
//       Map<String, dynamic> filters);
  
//   Future<Either<Failure, EntityModelList<ChinchalMerchantModel>>> filterMerchants(
//       Map<String, dynamic> filters);
  
//   Future<Either<Failure, EntityModelList<ChinchalOperationModel>>> filterOperations(
//       Map<String, dynamic> filters);

//   @override
//   DataSource buildDataSource(String path);
// }
