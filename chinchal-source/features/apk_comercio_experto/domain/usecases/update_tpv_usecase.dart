// // ignore_for_file: must_be_immutable

// import 'package:dartz/dartz.dart';

// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/interfaces/use_case.dart';
// import '../../data/models/tpv_model.dart';
// import '../repository/tpv_repository.dart';

// class UpdateTpvUseCase<TpvModelEntity extends TpvModel>
//     implements UseCase<TpvModelEntity, UpdateUseCaseTpvParams> {
//   final TpvRepository<TpvModelEntity> repository;
//   late UpdateUseCaseTpvParams? parameters;
//   UpdateTpvUseCase(this.repository);

//   @override
//   Future<Either<Failure, TpvModelEntity>> call(
//     UpdateUseCaseTpvParams? params,
//   ) async {
//     return (params == null && parameters == null)
//         ? Left(NulleableFailure(
//             varName: "params",
//             message:
//                 "Ha ocurrido un error relacionado a los parámetros de la operación."))
//         : await repository.update((params ?? parameters)!.id, params!.entity);
//   }

//   @override
//   Map<String, dynamic> exportParams() => getParams()!.toJson();

//   @override
//   UpdateUseCaseTpvParams? getParams() {
//     return parameters =
//         parameters ?? UpdateUseCaseTpvParams(id: 0, entity: TpvModel());
//   }

//   @override
//   UseCase<TpvModelEntity, UpdateUseCaseTpvParams> setParams(
//       UpdateUseCaseTpvParams params) {
//     parameters = params;
//     return this;
//   }

//   @override
//   UseCase<TpvModelEntity, UpdateUseCaseTpvParams> setParamsFromMap(Map params) {
//     return this;
//   }
// }

// class UpdateUseCaseTpvParams extends Parametizable {
//   final dynamic id;
//   final TpvModel entity;
//   UpdateUseCaseTpvParams({
//     required this.id,
//     required this.entity,
//   }) : super();
// }
