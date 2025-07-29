// // ignore_for_file: must_be_immutable
// import 'package:dartz/dartz.dart';

// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/interfaces/entity_model.dart';
// import '../../../../core/interfaces/use_case.dart';
// import '../repository/chinchal_repository.dart';

// FilterUseCaseFilterChinchalParams getUseCaseUserParamsFromMap(
//         Map<dynamic, dynamic> params) =>
//     FilterUseCaseFilterChinchalParams.fromMap(params);

// class FilterChinchalUseCase<FilterChinchalModel>
//     implements
//         UseCase<EntityModelList<FilterChinchalModel>,
//             FilterUseCaseFilterChinchalParams> {
//   final ChinchalRepository<FilterChinchalModel> repository;
//   late FilterUseCaseFilterChinchalParams? parameters;

//   FilterChinchalUseCase(this.repository);

//   @override
//   Future<Either<Failure, EntityModelList<FilterChinchalModel>>> call(
//     FilterUseCaseFilterChinchalParams? params,
//   ) async {
//     return (params == null && parameters == null)
//         ? Left(NulleableFailure(
//             varName: "",
//             message:
//                 "Ha ocurrido un error relacionado a los parámetros de la operación.",
//           ))
//         : await repository.filter(exportParams());
//   }

//   @override
//   Map<String, dynamic> exportParams() =>
//       getParams() != null ? getParams()!.toJson() : {};

//   @override
//   FilterUseCaseFilterChinchalParams? getParams() {
//     return parameters = parameters ?? FilterUseCaseFilterChinchalParams(id: 0);
//   }

//   @override
//   UseCase<EntityModelList<FilterChinchalModel>,
//           FilterUseCaseFilterChinchalParams>
//       setParams(FilterUseCaseFilterChinchalParams params) {
//     parameters = params;
//     return this;
//   }

//   @override
//   UseCase<EntityModelList<FilterChinchalModel>,
//       FilterUseCaseFilterChinchalParams> setParamsFromMap(Map params) {
//     parameters = FilterUseCaseFilterChinchalParams.fromMap(params);
//     return this;
//   }
// }

// class FilterUseCaseFilterChinchalParams extends Parametizable {
//   final int id;
//   FilterUseCaseFilterChinchalParams({
//     required this.id,
//   }) : super();

//   factory FilterUseCaseFilterChinchalParams.fromMap(
//           Map<dynamic, dynamic> params) =>
//       FilterUseCaseFilterChinchalParams(
//           id: params.containsKey("id") ? params["id"] : 0);

//   @override
//   bool isValid() {
//     return true;
//   }

//   @override
//   Map<String, dynamic> toJson() => {"id": id};
// }
