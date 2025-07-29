import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/local_storage.dart';
import '../../../../core/services/manager_authorization_service.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/bank_datasource.dart';
import '../../domain/models/bank_model.dart';
import '../../domain/repository/bank_repository.dart';

class BankRepositoryImpl<BankModelType extends BankModel>
    implements BankRepository<BankModelType> {
  late DataSource? datasource;

  BankRepositoryImpl();

  @override
  Future<Either<Failure, BankModelType>> add(entity) async {
    try {
      if (entity is Map) {
        entity = bankModelFromJson(json.encode(entity));
      }
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to add";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final bank = await datasource!.request(url, body, header);
      return Right(bank);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, BankModelType>> delete(dynamic entityId) async {
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
      final bank = await datasource!.request(url, body, header);
      return Right(bank);
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
  Future<Either<Failure, EntityModelList<BankModelType>>> filter(
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
      final banks = await datasource!.request(url, body, header);
      return Right(banks);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, BankModelType>> get(dynamic entityId) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to get";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final bank = await datasource!.request(url, body, header);
      return Right(bank);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<BankModelType>>> getAll() async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");

      var banks = await (datasource as RemoteBankDataSourceImpl)
          .getAll<EntityModelList<BankModelType>>();
      return banks.fold((l) => Left(ServerFailure(message: l.toString())),
          (banks) {
        LocalSecureStorage.storage.write("banks", json.encode(banks));
        return Right(banks);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, BankModelType>> getBank(dynamic id) => get(id);

  @override
  Future<Either<Failure, EntityModelList<BankModelType>>> getBy(
      Map params) async {
    try {
      final bankList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<BankModelType>>> process(
          EntityModelList<BankModelType> list) {
        EntityModelList<BankModelType> listToReturn =
            DefaultEntityModelList<BankModelType>();
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

      return bankList.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.bank));
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
  Future<Either<Failure, EntityModelList<BankModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<BankModelType> operations = await datasource!.getProvider
              .paginate<EntityModelList<BankModelType>>(start, limit, params)
          as EntityModelList<BankModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, BankModelType>> update(
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
      final bank = await datasource!.request(url, body, header);
      return Right(bank);
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
      datasource = RemoteBankDataSourceImpl();
    } else {
      datasource = LocalBankDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
