import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import '/app/modules/card/data/datasources/operation_datasource.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/local_storage.dart';
import '../../../../core/services/manager_authorization_service.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/balance_datasource.dart';
import '../../domain/models/balance_model.dart';
import '../../domain/repository/balance_repository.dart';

class BalanceRepositoryImpl<BalanceModelType extends BalanceModel>
    implements BalanceRepository<BalanceModelType> {
  late DataSource? datasource;

  BalanceRepositoryImpl();

  @override
  Future<Either<Failure, BalanceModelType>> add(entity) async {
    try {
      if (entity is Map) {
        entity = balanceModelFromJson(json.encode(entity));
      }
      String url = "https://${PathsService.apiEndpoint}";

      buildDataSource(url);
      var operations =
          await (datasource as RemoteOperationDataSourceImpl).getAll();
      return operations.fold((l) => Left(ServerFailure(message: l.toString())),
          (operations) {
        LocalSecureStorage.storage.write("operation", json.encode(operations));
        return Right(operations);
      });
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, BalanceModelType>> delete(dynamic entityId) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to delete";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final balance = await datasource!.request(url, body, header);
      return Right(balance);
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
  Future<Either<Failure, EntityModelList<BalanceModelType>>> filter(
      Map<String, dynamic> filters) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to get by field";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final balances = await datasource!.request(url, body, header);
      return Right(balances);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, BalanceModelType>> get(dynamic entityId) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");

      var balance = await (datasource as RemoteBalanceDataSourceImpl)
          .getEntity<BalanceModelType>(entityId);
      return balance.fold((l) => Left(ServerFailure(message: l.toString())),
          (balance) {
        LocalSecureStorage.storage.write("balance", json.encode(balance));
        return Right(balance);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, EntityModelList<BalanceModelType>>> getAll() async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to get by field";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final balances = await datasource!.request(url, body, header);
      return balances.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, BalanceModelType>> getBalance(dynamic id) => get(id);

  @override
  Future<Either<Failure, EntityModelList<BalanceModelType>>> getBy(
      Map params) async {
    try {
      final balanceList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<BalanceModelType>>> process(
          EntityModelList<BalanceModelType> list) {
        EntityModelList<BalanceModelType> listToReturn =
            DefaultEntityModelList<BalanceModelType>();
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

      return balanceList.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.balance));
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
  Future<Either<Failure, EntityModelList<BalanceModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<BalanceModelType> operations = await datasource!
              .getProvider
              .paginate<EntityModelList<BalanceModelType>>(start, limit, params)
          as EntityModelList<BalanceModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, BalanceModelType>> update(
      dynamic entityId, entity) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to update";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final balance = await datasource!.request(url, body, header);
      return Right(balance);
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
      datasource = RemoteBalanceDataSourceImpl();
    } else {
      datasource = LocalBalanceDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
