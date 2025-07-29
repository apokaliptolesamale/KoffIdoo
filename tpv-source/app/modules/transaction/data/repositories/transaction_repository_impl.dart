import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import '/app/core/constants/IDPConstantes.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/modules/config/domain/models/config_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/transaction_datasource.dart';
import '../../domain/models/transaction_model.dart';
import '../../domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl<TransactionModelType extends TransactionModel>
    implements TransactionRepository<TransactionModelType> {
  late DataSource? datasource;

  TransactionRepositoryImpl();

  @override
  Future<Either<Failure, TransactionModelType>> add(entity) async {
    try {
      if (entity is Map) {
        entity = transactionModelFromJson(json.encode(entity));
      }
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to add";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(idpKey: "apiez");
      buildDataSource(url);
      final transaction = await datasource!.request(url, body, header);
      return Right(transaction);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  Future<Either<Failure, EntityModelList<ConfigModel>>> addClientId(
      dynamic params) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    log(ms.toString());
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");
      var transactions = await (datasource as RemoteTransactionDataSourceImpl)
          .addClientId<EntityModelList<ConfigModel>>();
      return transactions
          .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
        log(r.toString());
        return Right(r);
      });
    }
    return Left(
        NulleableFailure(message: " La instancia ManagerAutorization es nula"));
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, TransactionModelType>> delete(dynamic entityId) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to delete";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(idpKey: "identity");
      buildDataSource(url);
      final transaction = await datasource!.request(url, body, header);
      return Right(transaction);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, bool>> exists(entityId) async {
    final result = await get(entityId);
    return result.fold((exception) {
      return Left(ServerFailure(message: 'Error !!!'));
    }, (model) {
      return Right(true);
    });
  }

  @override
  Future<Either<Failure, EntityModelList<TransactionModelType>>> filter(
      Map<String, dynamic> filters) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    log(ms.toString());
    if (mas != null) {
      String url = API_HOST;
      buildDataSource(url);
      final transactions = await datasource!.filter(filters);
      return transactions
          .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
        log(r.toString());
        return Right(r);
      });
    }
    return Left(
        NulleableFailure(message: " La instancia ManagerAutorization es nula"));

    /* return Right(result as EntityModelList<TransactionModelType> );
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }*/
  }

  @override
  Future<Either<Failure, TransactionModelType>> get(dynamic entityId) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to get";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(idpKey: "apiez");
      buildDataSource(url);
      final transaction = await datasource!.request(url, body, header);
      return Right(transaction);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<TransactionModelType>>>
      getAll() async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    log(ms.toString());
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");
      var transactions = await (datasource as RemoteTransactionDataSourceImpl)
          .getAll<EntityModelList<TransactionModelType>>();
      return transactions
          .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
        log(r.toString());
        return Right(r);
      });
    }
    return Left(
        NulleableFailure(message: " La instancia ManagerAutorization es nula"));
    /*  if (mas!= null ) {
  try {
     
    //TODO Asigne la url del API o recurso para adicionar
    String url = API_HOST ;
    //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
    buildDataSource(url);
    final transactions = await datasource!.getAll();
    return transactions.fold(
        (l) => Left(ServerFailure(message: l.toString())),
        (r) => Right(r));
  } on ServerException {
    return Left(ServerFailure(message: 'Error !!!'));
  }*/
  }

  @override
  Future<Either<Failure, EntityModelList<TransactionModelType>>> getBy(
      Map params) async {
    try {
      final transactionList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<TransactionModelType>>> process(
          EntityModelList<TransactionModelType> list) {
        EntityModelList<TransactionModelType> listToReturn =
            DefaultEntityModelList<TransactionModelType>();
        params.forEach((key, value) {
          final itemsList = list.getList();
          for (var element in itemsList) {
            final json = (element).toJson();
            if (json.containsKey(key) && json[value] == value) {
              listToReturn.getList().add(element);
            }
          }
        });

        return Right(listToReturn);
      }

      return transactionList.fold(
          (l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.transaction));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Either<Local, Remote> getDataSourcePath<Local, Remote>(String path) {
    buildDataSource(path);
    return isRemote(path)
        ? Right(datasource as Remote)
        : Left(datasource as Local);
  }

  @override
  Future<Either<Failure, TransactionModelType>> getTransaction(dynamic id) =>
      get(id);

  @override
  bool isRemote(String path) {
    path = path.toLowerCase();

    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
      caseSensitive: true,
      multiLine: false,
    );
    return path.startsWith(remoteRegExp);
  }

  @override
  Future<Either<Failure, EntityModelList<TransactionModelType>>> paginate(
      int start, int limit, Map params) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    log(ms.toString());
    if (mas != null) {
      String url = API_HOST;
      buildDataSource(url);
      final transactions =
          await datasource!.getProvider.paginate(start, limit, params);
      return transactions
          .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
        log(r.toString());
        return Right(r);
      });
    }
    return Left(
        NulleableFailure(message: " La instancia ManagerAutorization es nula"));
  }

  /* try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<TransactionModelType> operations = await datasource!
          .getProvider
          .paginate<EntityModelList<TransactionModelType>>(
              start, limit, params) as EntityModelList<TransactionModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }*/

  @override
  Future<Either<Failure, TransactionModelType>> update(
      dynamic entityId, entity) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to update";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(idpKey: "apiez");
      buildDataSource(url);
      final transaction = await datasource!.request(url, body, header);
      return Right(transaction);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  DataSource _buildDataSource(String path) {
    path = path.toLowerCase();

    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
      caseSensitive: true,
      multiLine: false,
    );
    if (path.startsWith(remoteRegExp)) {
      datasource = RemoteTransactionDataSourceImpl();
    } else {
      datasource = LocalTransactionDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
