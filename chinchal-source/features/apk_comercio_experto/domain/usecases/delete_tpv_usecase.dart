// // ignore_for_file: must_be_immutable
// import 'package:dartz/dartz.dart';

// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/interfaces/use_case.dart';
// import '../../data/models/tpv_model.dart';
// import '../repository/tpv_repository.dart';

// DeleteUseCaseTpvParams deleteUseCaseUserParamsFromMap(
//         Map<dynamic, dynamic> params) =>
//     DeleteUseCaseTpvParams.fromMap(params);

// class DeleteTpvUseCase<TpvModelEntity extends TpvModel>
//     implements UseCase<TpvModelEntity, DeleteUseCaseTpvParams> {
//   final TpvRepository<TpvModelEntity> repository;

//   late DeleteUseCaseTpvParams? parameters;

//   DeleteTpvUseCase(this.repository);

//   @override
//   Future<Either<Failure, TpvModelEntity>> call(
//     DeleteUseCaseTpvParams? params,
//   ) async {
//     return (params == null && parameters == null)
//         ? Left(NulleableFailure(
//             varName: "params",
//             message:
//                 "Ha ocurrido un error relacionado a los parámetros de la operación."))
//         : await repository.delete((params ?? parameters)!.id);
//   }

//   @override
//   Map<String, dynamic> exportParams() => getParams()!.toJson();

//   @override
//   DeleteUseCaseTpvParams? getParams() {
//     return parameters = parameters ?? DeleteUseCaseTpvParams(id: 0);
//   }

//   @override
//   UseCase<TpvModelEntity, DeleteUseCaseTpvParams> setParams(
//       DeleteUseCaseTpvParams params) {
//     parameters = params;
//     return this;
//   }

//   @override
//   UseCase<TpvModelEntity, DeleteUseCaseTpvParams> setParamsFromMap(Map params) {
//     parameters = DeleteUseCaseTpvParams.fromMap(params);
//     return this;
//   }
// }

// class DeleteUseCaseTpvParams extends Parametizable {
//   final int id;
//   DeleteUseCaseTpvParams({required this.id}) : super();

//   factory DeleteUseCaseTpvParams.fromMap(Map<dynamic, dynamic> params) =>
//       DeleteUseCaseTpvParams(id: params.containsKey("id") ? params["id"] : 0);

//   @override
//   bool isValid() {
//     return true;
//   }

//   @override
//   Map<String, dynamic> toJson() => {"id": id};
// }
