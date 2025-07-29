// // ignore_for_file: must_be_immutable
// import 'package:dartz/dartz.dart';
// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/interfaces/use_case.dart';
// import '../repository/transfer_repository.dart';

// class GetVendorIdCodeUseCase<TransferModel>
//     implements UseCase<TransferModel, GetUseCaseVendorIdCodeParams> {
//   final TransferRepository<TransferModel> repository;
//   late GetUseCaseVendorIdCodeParams? parameters;

//   GetVendorIdCodeUseCase(this.repository);

//   @override
//   Future<Either<Failure, TransferModel>> call(
//     GetUseCaseVendorIdCodeParams? params,
//   ) async {
//     params = params ?? getParams();
//     return await repository.getVendorIdCode(
//         (parameters = params)!.id, params!.entity);
//     // return (params==null && parameters==null)?Left(NulleableFailure(
//     //     message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.transferToAccount((params??parameters)!.id);
//   }

//   @override
//   GetUseCaseVendorIdCodeParams? getParams() {
//     return parameters =
//         parameters ?? GetUseCaseVendorIdCodeParams(entity: parameters);
//   }

//   @override
//   UseCase<TransferModel, GetUseCaseVendorIdCodeParams> setParams(
//       GetUseCaseVendorIdCodeParams params) {
//     parameters = params;
//     return this;
//   }

//   @override
//   UseCase<TransferModel, GetUseCaseVendorIdCodeParams> setParamsFromMap(
//       Map params) {
//     parameters = GetUseCaseVendorIdCodeParams(entity: params);
//     return this;
//   }
// }

// GetUseCaseVendorIdCodeParams getUseCaseUserParamsFromMap(
//         Map<dynamic, dynamic> params) =>
//     GetUseCaseVendorIdCodeParams.fromMap(params);

// class GetUseCaseVendorIdCodeParams extends Parametizable {
//   dynamic id;
//   final dynamic entity;
//   GetUseCaseVendorIdCodeParams({this.id, required this.entity}) : super();

//   @override
//   bool isValid() {
//     return true;
//   }

//   factory GetUseCaseVendorIdCodeParams.fromMap(Map<dynamic, dynamic> params) =>
//       GetUseCaseVendorIdCodeParams(
//           id: params.containsKey("id") ? params["id"] : 0,
//           entity: params.containsKey("id") ? params["id"] : 0);

//   @override
//   Map<String, dynamic> toJson() => {"id": id};
// }
