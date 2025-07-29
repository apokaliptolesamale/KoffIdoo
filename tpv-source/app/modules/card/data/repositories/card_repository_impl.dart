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
import '../../data/datasources/card_datasource.dart';
import '../../domain/models/card_model.dart';
import '../../domain/repository/card_repository.dart';

class CardRepositoryImpl<CardModelType extends CardModel>
    implements CardRepository<CardModelType> {
  late DataSource? datasource;

  CardRepositoryImpl();

  @override
  Future<Either<Failure, CardModelType>> add(entity) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");

      var addCard =
          await (datasource as RemoteCardDataSourceImpl).addEntity(entity);
      return addCard.fold((l) => Left(ServerFailure(message: l.toString())),
          (addCard) {
        LocalSecureStorage.storage.write("cards", json.encode(addCard));
        return Right(addCard);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, CardModelType>> delete(dynamic entityId) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");

      var cards =
          await (datasource as RemoteCardDataSourceImpl).deleteEntity(entityId);
      return cards.fold((l) => Left(ServerFailure(message: l.toString())),
          (cards) {
        LocalSecureStorage.storage.write("cards", json.encode(cards));
        return Right(cards);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
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
  Future<Either<Failure, EntityModelList<CardModelType>>> filter(
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
      final cards = await datasource!.request(url, body, header);
      return Right(cards);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, CardModelType>> get(dynamic entityId) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");

      var card = await (datasource as RemoteCardDataSourceImpl).getEntity(null);
      return card.fold((l) => Left(ServerFailure(message: l.toString())),
          (card) {
        LocalSecureStorage.storage.write("cards", json.encode(card));
        return Right(card);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, EntityModelList<CardModelType>>> getAll() async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");

      var cards = await (datasource as RemoteCardDataSourceImpl)
          .getAll<EntityModelList<CardModelType>>();
      return cards.fold((l) => Left(ServerFailure(message: l.toString())),
          (cards) {
        LocalSecureStorage.storage.write("cards", json.encode(cards));
        return Right(cards);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, EntityModelList<CardModelType>>> getBy(
      Map params) async {
    try {
      final cardList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<CardModelType>>> process(
          EntityModelList<CardModelType> list) {
        EntityModelList<CardModelType> listToReturn =
            DefaultEntityModelList<CardModelType>();
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

      return cardList.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.card));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, CardModelType>> getCard(dynamic id) => get(id);

  @override
  Either<Local, Remote> getDataSourcePath<Local, Remote>(String path) {
    buildDataSource(path);
    return isRemote(path)
        ? Right(datasource as Remote)
        : Left(datasource as Local);
  }

  @override
  Future<Either<Failure, CardModelType>> getFirstCard() async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");

      var firstCard = await (datasource as RemoteCardDataSourceImpl)
          .getFirstCard<CardModelType>();
      return firstCard.fold((l) => Left(ServerFailure(message: l.toString())),
          (firstCard) {
        LocalSecureStorage.storage.write("cards", json.encode(firstCard));
        return Right(firstCard);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, CardModelType>> getSetAsDefault(entityId) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");

      var card = await (datasource as RemoteCardDataSourceImpl)
          .getSetAsDefault(entityId);
      return card.fold((l) => Left(ServerFailure(message: l.toString())),
          (card) {
        LocalSecureStorage.storage.write("card", json.encode(card));
        return Right(card);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
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
  Future<Either<Failure, EntityModelList<CardModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<CardModelType> operations = await datasource!.getProvider
              .paginate<EntityModelList<CardModelType>>(start, limit, params)
          as EntityModelList<CardModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, CardModelType>> update(
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
      final card = await datasource!.request(url, body, header);
      return Right(card);
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
      datasource = RemoteCardDataSourceImpl();
    } else {
      datasource = LocalCardDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
