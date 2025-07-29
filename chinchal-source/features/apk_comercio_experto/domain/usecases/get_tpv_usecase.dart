// // ignore_for_file: must_be_immutable
// import 'package:dartz/dartz.dart';

// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/interfaces/use_case.dart';
// import '../repository/tpv_repository.dart';

// GetUseCaseTpvParams getUseCaseUserParamsFromMap(Map<dynamic, dynamic> params) =>
//     GetUseCaseTpvParams.fromMap(params);

// class GetTpvUseCase<TpvModel>
//     implements UseCase<TpvModel, GetUseCaseTpvParams> {
//   final TpvRepository<TpvModel> repository;
//   late GetUseCaseTpvParams? parameters;

//   GetTpvUseCase(this.repository);

//   @override
//   Future<Either<Failure, TpvModel>> call(
//     GetUseCaseTpvParams? params,
//   ) async {
//     return (params == null && parameters == null)
//         ? Left(NulleableFailure(
//             varName: "params",
//             message:
//                 "Ha ocurrido un error relacionado a los parámetros de la operación."))
//         : await repository.getTpv((params ?? parameters)!.id);
//   }

//   @override
//   Map<String, dynamic> exportParams() => getParams()!.toJson();

//   @override
//   GetUseCaseTpvParams? getParams() {
//     return parameters = parameters ?? GetUseCaseTpvParams(id: 0);
//   }

//   @override
//   UseCase<TpvModel, GetUseCaseTpvParams> setParams(GetUseCaseTpvParams params) {
//     parameters = params;
//     return this;
//   }

//   @override
//   UseCase<TpvModel, GetUseCaseTpvParams> setParamsFromMap(Map params) {
//     parameters = GetUseCaseTpvParams.fromMap(params);
//     return this;
//   }
// }

// class GetUseCaseTpvParams extends Parametizable {
//   final int id;
//   GetUseCaseTpvParams({
//     required this.id,
//   }) : super();

//   factory GetUseCaseTpvParams.fromMap(Map<dynamic, dynamic> params) =>
//       GetUseCaseTpvParams(id: params.containsKey("id") ? params["id"] : 0);

//   @override
//   bool isValid() {
//     return true;
//   }

//   @override
//   Map<String, dynamic> toJson() => {"id": id};
// }
