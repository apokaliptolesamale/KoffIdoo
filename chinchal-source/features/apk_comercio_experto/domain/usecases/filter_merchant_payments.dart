// // ignore_for_file: must_be_immutable

// import 'package:apk_template/config/errors/failure.dart';
// import 'package:dartz/dartz.dart';

// import '../repository/merchant_tpv_repository.dart';

// FilterMerchantPaymentParams FilterMerchantPaymentParamsFromMap(
//         Map<dynamic, dynamic> params) =>
//     FilterMerchantPaymentParams.fromMap(params);

// class FilterMerchantPayment<MerchantPaymentModel>
//     implements UseCase<EntityModelList<MerchantPaymentModel>, FilterMerchantPaymentParams> {
//   final MerchantTpvRepository<MerchantPaymentModel> repository;
//   FilterMerchantPaymentParams? parameters;

//   FilterMerchantPayment(this.repository);

//   @override
//   Future<Either<Failure, EntityModelList<MerchantPaymentModel>>> call(
//     FilterMerchantPaymentParams? params,
//   ) async {
//     return (parameters = params)!.isValid()
//         ? await repository.filter(parameters!.toJson())
//         : await Future.value(Left(InvalidParamsFailure(
//             message:
//                 "Los parámetros de la búsqueda son vacíos o incorrectos.")));
//   }

//   @override
//   Map<String, dynamic> exportParams() => getParams()!.toJson();

//   Future<Either<Failure, EntityModelList<MerchantPaymentModel>>> filter() async {
//     return call(getParams()!);
//   }

//   @override
//   FilterMerchantPaymentParams? getParams() {
//     return parameters = parameters ?? FilterMerchantPaymentParams();
//   }

//   @override
//   UseCase<EntityModelList<MerchantPaymentModel>, FilterMerchantPaymentParams> setParams(
//       FilterMerchantPaymentParams params) {
//     parameters = params;
//     return this;
//   }

//   @override
//   UseCase<EntityModelList<MerchantPaymentModel>, FilterMerchantPaymentParams> setParamsFromMap(
//       Map params) {
//     parameters = FilterMerchantPaymentParams.fromMap(params);
//     return this;
//   }
// }

// class FilterMerchantPaymentParams extends Parametizable {
  
//   int start = 1;
//   int limit = 20;

//   FilterMerchantPaymentParams({
//     this.start = 1,
//     this.limit = 10
//   }) : super();

//   factory FilterMerchantPaymentParams.fromMap(Map<dynamic, dynamic> json) =>
//       FilterMerchantPaymentParams(
//         start: EntityModel.getValueFromJson("offset", json, 0),
//         limit: EntityModel.getValueFromJson("limit", json, 10),
    
//       );

//   @override
//   bool isValid() {
//     //TODO implementar la validación de cada campo del filtro
//     return true;
//   }

//   @override
//   Map<String, dynamic> toJson() => {
//         "offset": start,
//         "limit": limit
//       };

//   bool  validate<T>(T? value) {
//     return value != null;
//   }
// }

