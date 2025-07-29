// // ignore_for_file: must_be_immutable

// import 'package:dartz/dartz.dart';

// import '../../../../../app/core/interfaces/entity_model.dart';
// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/interfaces/use_case.dart';
// import '../../data/models/chinchal_merchants_model.dart';

// import '../../data/models/chinchal_model.dart';
// import '../repository/chinchal_repository.dart';


// class FilterChinchalMerchantUseCase<ChinchalModel>
//     implements UseCase<EntityModelList<ChinchalMerchantModel>, FilterUseCaseChinchalMerchantParams> {
//   final ChinchalRepository<ChinchalModel> repository;
//   FilterUseCaseChinchalMerchantParams? parameters;

//   FilterChinchalMerchantUseCase(this.repository);

//   @override
//   Map<String, dynamic> exportParams() => getParams()!.toJson();

//   @override
//   Future<Either<Failure, EntityModelList<ChinchalMerchantModel>>> call(
//     FilterUseCaseChinchalMerchantParams? params,
//   ) async {
//     return (parameters = params)!.isValid()
//         ? await repository.filterMerchants(parameters!.toJson())
//         : await Future.value(Left(InvalidParamsFailure(
//             message:
//                 "Los parámetros de la búsqueda son vacíos o incorrectos.")));
//   }

//   Future<Either<Failure, EntityModelList<ChinchalMerchantModel>>> filter() async {
//     return call(getParams()!);
//   }

//   @override
//   FilterUseCaseChinchalMerchantParams? getParams() {
//     return parameters = parameters ?? FilterUseCaseChinchalMerchantParams(id: {});
//   }

//   @override
//   UseCase<EntityModelList<ChinchalMerchantModel>, FilterUseCaseChinchalMerchantParams> setParams(
//       FilterUseCaseChinchalMerchantParams params) {
//     parameters = params;
//     return this;
//   }

//   @override
//   UseCase<EntityModelList<ChinchalMerchantModel>, FilterUseCaseChinchalMerchantParams> setParamsFromMap(
//       Map params) {
//     parameters = FilterUseCaseChinchalMerchantParams.fromMap(params);
//     return this;
//   }
// }

// FilterUseCaseChinchalMerchantParams filterUseCaseGiftParamsFromMap(
//         Map<dynamic, dynamic> params) =>
//     FilterUseCaseChinchalMerchantParams.fromMap(params);

// class FilterUseCaseChinchalMerchantParams extends Parametizable {
//   final Map<String, dynamic> id; // id de el caso

//   int start = 1;
//   int limit = 20;

//   FilterUseCaseChinchalMerchantParams({
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

//   factory FilterUseCaseChinchalMerchantParams.fromMap(Map<dynamic, dynamic> params) =>
//       FilterUseCaseChinchalMerchantParams(
//           id: params.containsKey("chinchalMerchant") ? params["chinchalMerchant"] : {});

//   @override
//   Map<String, dynamic> toJson() => {"id": id};
// }

