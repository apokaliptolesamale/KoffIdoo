// import 'dart:async';
// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';


// import '../../../../core/interfaces/entity_model.dart';
// import '../../../../core/interfaces/header_request.dart';
// import '../../../../core/services/paths_service.dart';
// import '../../data/datasources/account_datasource.dart';
// import '../../domain/models/account_model.dart';
// import '../../domain/repository/account_repository.dart';

// class DestinatarioRepositoryImpl<DestinatarioModelType extends DestinatarioModel>
//     implements AccountRepository<DestinatarioModelType> {
//   late DataSource? datasource;
//   FlutterSecureStorage storage = FlutterSecureStorage();

//   DestinatarioRepositoryImpl(this.storage);

  

//   @override
//   Future<Either<Failure, EntityModelList<DestinatarioModelType>>>
//       getDestinatarios(dynamic entity) async {
//     final mas =
//         ManagerAuthorizationService().get(PathsService.identityKey);
//     if (mas != null) {
//       buildDataSource("https://${PathsService.apiEndpoint}");

//       var destinatarios = await (datasource as RemoteAccountDataSourceImpl)
//           .getDestinatarios<EntityModelList<DestinatarioModelType>>(entity);
//       return destinatarios.fold(
//           (l) => Left(ServerFailure(message: l.toString())), (cards) {
//         // LocalSecureStorage.storage.write("cards", json.encode(cards));
//         return Right(cards);
//       });
//     }
//     return Left(NulleableFailure(
//         message: "La instancia de ManagerAuthorizationService es nula."));
//   }
  

//   bool isRemote(String path){
  //   path = path.toLowerCase();

  //   RegExp remoteRegExp = RegExp(
  //     r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
  //     caseSensitive: true,
  //     multiLine: false,
  //   );
  //   return path.startsWith(remoteRegExp);
  // }

  // Either<Local, Remote> getDataSourcePath<Local, Remote>(String path) {
  //   buildDataSource(path);
  //   return isRemote(path)
  //       ? Right(datasource as Remote)
  //       : Left(datasource as Local);
  // }
  // DataSource _buildDataSource(String path) {
//     path = path.toLowerCase();

//     RegExp remoteRegExp = RegExp(
//       r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
//       caseSensitive: true,
//       multiLine: false,
//     );
//     if (path.startsWith(remoteRegExp)) {
//       datasource = RemoteDestinatarioDataSourceImpl();
//     } else {
//       datasource = LocalDestinatarioDataSourceImpl();
//     }
//     datasource!.getProvider.setBaseUrl(path);
//     return datasource!;
//   }
  
//   @override
//   Future<Either<Failure, DestinatarioModelType>> add(entity) {
//     // TODO: implement add
//     throw UnimplementedError();
//   }
  
//   @override
//   DataSource buildDataSource(String path) {
//     // TODO: implement buildDataSource
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, DestinatarioModelType>> changePasswordAccount(id, entity) {
//     // TODO: implement changePasswordAccount
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, DestinatarioModelType>> delete(entityId) {
//     // TODO: implement delete
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, bool>> exists(entityId) {
//     // TODO: implement exists
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, EntityModelList<DestinatarioModelType>>> filter(Map<String, dynamic> filters) {
//     // TODO: implement filter
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, DestinatarioModelType>> get(entityId) {
//     // TODO: implement get
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, DestinatarioModelType>> getAccount(id) {
//     // TODO: implement getAccount
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, DestinatarioModelType>> getAccountModel(params) {
//     // TODO: implement getAccountModel
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, EntityModelList<DestinatarioModelType>>> getAll() {
//     // TODO: implement getAll
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, EntityModelList<DestinatarioModelType>>> getBy(Map params) {
//     // TODO: implement getBy
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, DestinatarioModelType>> getDisableTotp() {
//     // TODO: implement getDisableTotp
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, DestinatarioModelType>> getRefreshTotp() {
//     // TODO: implement getRefreshTotp
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, DestinatarioModelType>> getTotp() {
//     // TODO: implement getTotp
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, DestinatarioModelType>> getVerifyTotp(entity) {
//     // TODO: implement getVerifyTotp
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, EntityModelList<DestinatarioModelType>>> paginate(int start, int limit, Map params) {
//     // TODO: implement paginate
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, DestinatarioModelType>> update(entityId, entity) {
//     // TODO: implement update
//     throw UnimplementedError();
//   }
// }
