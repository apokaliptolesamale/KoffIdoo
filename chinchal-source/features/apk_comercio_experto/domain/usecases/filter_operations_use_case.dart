// // ignore_for_file: must_be_immutable

// import 'package:dartz/dartz.dart';

// import '../../../../../app/core/interfaces/entity_model.dart';
// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/interfaces/use_case.dart';
// import '../../data/models/chinchal_merchants_model.dart';

// import '../../data/models/chinchal_model.dart';
// import '../../data/models/chinchal_operation_model.dart';
// import '../repository/chinchal_repository.dart';


// class FilterChinchalOperationUseCase<ChinchalModel>
//     implements UseCase<EntityModelList<ChinchalOperationModel>, FilterUseCaseChinchalOperationParams> {
//   final ChinchalRepository<ChinchalModel> repository;
//   FilterUseCaseChinchalOperationParams? parameters;

//   FilterChinchalOperationUseCase(this.repository);

//   @override
//   Map<String, dynamic> exportParams() => getParams()!.toJson();

//   @override
//   Future<Either<Failure, EntityModelList<ChinchalOperationModel>>> call(
//     FilterUseCaseChinchalOperationParams? params,
//   ) async {
//     return (parameters = params)!.isValid()
//         ? await repository.filterOperations(parameters!.toJson())
//         : await Future.value(Left(InvalidParamsFailure(
//             message:
//                 "Los parámetros de la búsqueda son vacíos o incorrectos.")));
//   }

//   Future<Either<Failure, EntityModelList<ChinchalOperationModel>>> filter() async {
//     return call(getParams()!);
//   }

//   @override
//   FilterUseCaseChinchalOperationParams? getParams() {
//     return parameters = parameters ?? FilterUseCaseChinchalOperationParams(id: {});
//   }

//   @override
//   UseCase<EntityModelList<ChinchalOperationModel>, FilterUseCaseChinchalOperationParams> setParams(
//       FilterUseCaseChinchalOperationParams params) {
//     parameters = params;
//     return this;
//   }

//   @override
//   UseCase<EntityModelList<ChinchalOperationModel>, FilterUseCaseChinchalOperationParams> setParamsFromMap(
//       Map params) {
//     parameters = FilterUseCaseChinchalOperationParams.fromMap(params);
//     return this;
//   }
// }

// FilterUseCaseChinchalOperationParams filterUseCaseGiftParamsFromMap(
//         Map<dynamic, dynamic> params) =>
//     FilterUseCaseChinchalOperationParams.fromMap(params);

// class FilterUseCaseChinchalOperationParams extends Parametizable {
//   final Map<String, dynamic> id; // id de el caso

//   int start = 1;
//   int limit = 20;

//   FilterUseCaseChinchalOperationParams({
//     required this.id,
//   }) : super();

//   bool validate<T>(T? value) {
//     return value != null;
//   }

//   @override
//   bool isValid() {
//     //TODO implementar la validación de cada campo del filtro
//     return true;
//   }

//   factory FilterUseCaseChinchalOperationParams.fromMap(Map<dynamic, dynamic> params) =>
//       FilterUseCaseChinchalOperationParams(
//           id: params.containsKey("chinchalOperation") ? params["chinchalOperation"] : {});

//   @override
//   Map<String, dynamic> toJson() => {"id": id};
// }
