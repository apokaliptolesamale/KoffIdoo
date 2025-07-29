// // ignore_for_file: must_be_immutable
// import 'package:dartz/dartz.dart';

// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/interfaces/use_case.dart';
// import '../../data/models/chinchal_model.dart';
// import '../../data/models/chinchal_qrcode_model.dart';
// import '../repository/chinchal_repository.dart';
// import '../repository/tpv_repository.dart';



// class AddChinchalQrCodeUseCase<ChinchalModel>
//     implements UseCase<ChinchalQrCodeModel, AddChinchalQrCodeUseCaseTpvParams> {
//   final ChinchalRepository<ChinchalModel> repository;
//   late AddChinchalQrCodeUseCaseTpvParams? parameters;

//   AddChinchalQrCodeUseCase(this.repository);

//   @override
//   Future<Either<Failure, ChinchalQrCodeModel>> call(
//     AddChinchalQrCodeUseCaseTpvParams? params,
//   ) async {
//     return params != null
//         ? await repository.addQRCode((parameters = params).map)
//         : Left(NulleableFailure(varName: "params", message: "Sin parámetros"));
//   }

//   @override
//   Map<String, dynamic> exportParams() => getParams()!.toJson();

//   @override
//   AddChinchalQrCodeUseCaseTpvParams? getParams() {
//     return parameters = parameters ?? AddChinchalQrCodeUseCaseTpvParams(map: AddChinchalQrCodeModel());
//   }

//   @override
//   UseCase<ChinchalQrCodeModel, AddChinchalQrCodeUseCaseTpvParams> setParams(
//       AddChinchalQrCodeUseCaseTpvParams params) {
//     parameters = params;
//     return this;
//   }

//   @override
//   UseCase<ChinchalQrCodeModel, AddChinchalQrCodeUseCaseTpvParams> setParamsFromMap(
//       Map params) {
//     parameters = AddChinchalQrCodeUseCaseTpvParams.fromMap(params);
//     return this;
//   }
// }

// class AddChinchalQrCodeUseCaseTpvParams extends Parametizable {
//   final AddChinchalQrCodeModel map;
//   AddChinchalQrCodeUseCaseTpvParams({required this.map}) : super();

//   factory AddChinchalQrCodeUseCaseTpvParams.fromMap(
//           Map<dynamic, dynamic> params) =>
//       AddChinchalQrCodeUseCaseTpvParams(
//           map: params.containsKey("map") ? params["map"] : AddChinchalQrCodeModel);

//   @override
//   bool isValid() {
//     return true;
//   }

//   @override
//   Map<String, dynamic> toJson() => {"id": id};
// }
