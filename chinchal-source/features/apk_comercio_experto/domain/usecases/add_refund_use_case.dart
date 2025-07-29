// // ignore_for_file: must_be_immutable
// import 'package:dartz/dartz.dart';

// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/interfaces/use_case.dart';
// import '../../data/models/refund_model.dart';
// import '../repository/chinchal_repository.dart';


// class AddRefundUseCase<ChinchalModel>
//     implements UseCase<RefundModel, AddUseCaseRefundParams> {
//   final ChinchalRepository<ChinchalModel> repository;
//   late AddUseCaseRefundParams? parameters;

//   AddRefundUseCase(this.repository);

//   @override
//   Map<String, dynamic> exportParams() => getParams()!.toJson();

//   @override
//   Future<Either<Failure, RefundModel>> call(
//     AddUseCaseRefundParams? params,
//   ) async {
//     return params != null
//         ? await repository.addRefund((parameters = params).model,(parameters = params).transactionUUID)
//         : Left(NulleableFailure(varName: "params", message: "Sin parámetros"));
//   }

//   @override
//   AddUseCaseRefundParams? getParams() {
//     return parameters = parameters ??
//         AddUseCaseRefundParams(model: AddRefundModel(
//           amount: {}, 
//           commerceRefundId:'', 
//           username: '', 
//           description: ''), 
//           transactionUUID: '');
//   }

//   @override
//   UseCase<RefundModel, AddUseCaseRefundParams> setParams(
//       AddUseCaseRefundParams params) {
//     parameters = params;
//     return this;
//   }

//   @override
//   UseCase<RefundModel, AddUseCaseRefundParams> setParamsFromMap(Map params) {
//     parameters = AddUseCaseRefundParams.fromMap(params);
//     return this;
//   }
// }

// AddUseCaseRefundParams filterUseCaseUserParamsFromMap(
//         Map<dynamic, dynamic> params) =>
//     AddUseCaseRefundParams.fromMap(params);

// class AddUseCaseRefundParams extends Parametizable {
//   final AddRefundModel model;
//   final String transactionUUID;
//   //final int id;
//   AddUseCaseRefundParams({required this.model,required this.transactionUUID}) : super();

//   @override
//   bool isValid() {
//     return true;
//   }

//   factory AddUseCaseRefundParams.fromMap(Map<dynamic, dynamic> params) =>
//       AddUseCaseRefundParams(
        
//           model: params.containsKey("id")
//               ? params["id"]
//               : AddRefundModel (amount: {},commerceRefundId: '',description: '',username: ''), 
//           transactionUUID: '',
              
//               );

//   @override
//   Map<String, dynamic> toJson() => {
//     "model": model,
//     "transaction_uuid":transactionUUID
//     };
// }
