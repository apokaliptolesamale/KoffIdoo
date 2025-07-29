// import 'dart:async';
// import 'dart:convert';

// import 'package:dartz/dartz.dart';

// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/config/errors/exceptions.dart';
// import '../../../../core/interfaces/body_request.dart';
// import '../../../../core/interfaces/data_source.dart';
// import '../../../../core/interfaces/entity_model.dart';
// import '../../../../core/interfaces/header_request.dart';
// import '../../../../core/services/paths_service.dart';
// import '../../data/datasources/tpv_datasource.dart';
// import '../models/tpv_model.dart';
// import '../../domain/repository/tpv_repository.dart';

// class TpvRepositoryImpl<TpvModelType extends TpvModel>
//     implements TpvRepository<TpvModelType> {
//   late DataSource? datasource;

//   TpvRepositoryImpl();

//   @override
//   Future<Either<Failure, TpvModelType>> add(entity) async {
//     try {
//       if (entity is Map) {
//         entity = tpvModelFromJson(json.encode(entity));
//       }
//       //TODO Asigne la url del API o recurso para adicionar
//       String url = "Url to add";
//       //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
//       BodyRequest body = EmptyBodyRequest();
//       //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
//       HeaderRequest header = HeaderRequestImpl(
//         idpKey: "identity",
//       );
//       buildDataSource(url);
//       final tpv = await datasource!.request(url, body, header);
//       return Right(tpv);
//     } catch (e) {
//       return Left(ServerFailure(message: 'Error !!! ${e.toString()}'));
//     }
//   }

//   @override
//   DataSource buildDataSource(String path) => _buildDataSource(path);

//   @override
//   Future<Either<Failure, TpvModelType>> delete(dynamic entityId) async {
//     try {
//       //TODO Asigne la url del API o recurso para adicionar
//       String url = "Url to delete";
//       //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
//       BodyRequest body = EmptyBodyRequest();
//       //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
//       HeaderRequest header = HeaderRequestImpl(
//         idpKey: "identity",
//       );
//       buildDataSource(url);
//       final tpv = await datasource!.request(url, body, header);
//       return Right(tpv);
//     } catch (e) {
//       return Left(ServerFailure(message: 'Error !!! ${e.toString()}'));
//     }
//   }

//   @override
//   Future<Either<Failure, bool>> exists(entityId) async {
//     try {
//       final result = await get(entityId);
//       return result.fold((exception) {
//         return Left(ServerFailure(message: 'Error !!!'));
//       }, (model) {
//         return Right(true);
//       });
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   @override
//   Future<Either<Failure, EntityModelList<TpvModelType>>> filter(
//       Map<String, dynamic> filters) async {
//     try {
//       //TODO Asigne la url del API o recurso para adicionar
//       String url = "Url to get by field";
//       //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
//       BodyRequest body = EmptyBodyRequest();
//       //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
//       HeaderRequest header = HeaderRequestImpl(
//         idpKey: "identity",
//       );
//       buildDataSource(url);
//       final tpvs = await datasource!.request(url, body, header);
//       return Right(tpvs);
//     } catch (e) {
//       return Left(ServerFailure(message: 'Error !!! ${e.toString()}'));
//     }
//   }

//   @override
//   Future<Either<Failure, TpvModelType>> get(dynamic entityId) async {
//     try {
//       //TODO Asigne la url del API o recurso para adicionar
//       String url = "Url to get";
//       //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
//       BodyRequest body = EmptyBodyRequest();
//       //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
//       HeaderRequest header = HeaderRequestImpl(
//         idpKey: "identity",
//       );
//       buildDataSource(url);
//       final tpv = await datasource!.request(url, body, header);
//       return Right(tpv);
//     } catch (e) {
//       return Left(ServerFailure(message: 'Error !!! ${e.toString()}'));
//     }
//   }

//   @override
//   Future<Either<Failure, EntityModelList<TpvModelType>>> getAll() async {
//     try {
//       String url = PathsService.tpvUrlService;
//       buildDataSource(url);
//       final tpvs = await datasource!.getAll();
//       return tpvs.fold(
//           (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
//     } catch (e) {
//       return Left(ServerFailure(message: 'Error !!! ${e.toString()}'));
//     }
//   }

//   @override
//   Future<Either<Failure, EntityModelList<TpvModelType>>> getBy(
//       Map params) async {
//     try {
//       final tpvList = await datasource!.getAll();

//       FutureOr<Either<Failure, EntityModelList<TpvModelType>>> process(
//           EntityModelList<TpvModelType> list) {
//         EntityModelList<TpvModelType> listToReturn =
//             DefaultEntityModelList<TpvModelType>();
//         params.forEach((key, value) {
//           final itemsList = list.getList();
//           for (var element in itemsList) {
//             final json = (element).toJson();
//             if (json.containsKey(key) && json[value] == value) {
//               listToReturn.getList().add(element);
//             }
//           }
//         });

//         return Right(listToReturn);
//       }

//       return tpvList.fold((l) => Left(ServerFailure(message: l.toString())),
//           (r) => process(r.tpv));
//     } catch (e) {
//       return Left(ServerFailure(message: 'Error !!! ${e.toString()}'));
//     }
//   }

//   @override
//   Either<Local, Remote> getDataSourcePath<Local, Remote>(String path) {
//     try {
//       buildDataSource(path);
//       return isRemote(path)
//           ? Right(datasource as Remote)
//           : Left(datasource as Local);
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   @override
//   Future<Either<Failure, TpvModelType>> getTpv(dynamic id) => get(id);

//   @override
//   bool isRemote(String path) {
//     try {
//       path = path.toLowerCase();

//       RegExp remoteRegExp = RegExp(
//         r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
//         caseSensitive: true,
//         multiLine: false,
//       );
//       return path.startsWith(remoteRegExp);
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   @override
//   Future<Either<Failure, EntityModelList<TpvModelType>>> paginate(
//       int start, int limit, Map params) async {
//     try {
//       buildDataSource(PathsService.apiOperationHost);

//       EntityModelList<TpvModelType> operations = await datasource!.getProvider
//               .paginate<EntityModelList<TpvModelType>>(start, limit, params)
//           as EntityModelList<TpvModelType>;

//       return Right(operations);
//     } catch (e) {
//       return Left(ServerFailure(message: 'Error !!! ${e.toString()}'));
//     }
//   }

//   @override
//   Future<Either<Failure, TpvModelType>> update(dynamic entityId, entity) async {
//     try {
//       //TODO Asigne la url del API o recurso para adicionar
//       String url = "Url to update";
//       //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
//       BodyRequest body = EmptyBodyRequest();
//       //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
//       HeaderRequest header = HeaderRequestImpl(
//         idpKey: "identity",
//       );
//       buildDataSource(url);
//       final tpv = await datasource!.request(url, body, header);
//       return Right(tpv);
//     } catch (e) {
//       return Left(ServerFailure(message: 'Error !!! ${e.toString()}'));
//     }
//   }

//   DataSource _buildDataSource(String path) {
//     try {
//       path = path.toLowerCase();

//       RegExp remoteRegExp = RegExp(
//         r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
//         caseSensitive: true,
//         multiLine: false,
//       );
//       if (path.startsWith(remoteRegExp)) {
//         datasource = RemoteTpvDataSourceImpl();
//       } else {
//         datasource = LocalTpvDataSourceImpl();
//       }
//       datasource!.getProvider.setBaseUrl(path);
//       return datasource!;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }
