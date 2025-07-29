import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/manager_authorization_service.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/transfer_datasource.dart';
import '../../domain/models/transfer_model.dart';
import '../../domain/repository/transfer_repository.dart';

class TransferRepositoryImpl<TransferModelType extends TransferModel>
    implements TransferRepository<TransferModelType> {
  late DataSource? datasource;

  TransferRepositoryImpl();

  // @override
  // Future<Either<Failure, TransferModelType>> getVendorIdCode(id, entity) async {
  //   final mas =
  //       ManagerAuthorizationService().get(PathsService.identityKey);

  //   if (mas != null) {
  //     buildDataSource("https://${PathsService.apiEndpoint}");
  //     // var account = entity as AccountModelType;
  //     /* params = {
  //       "email": account.email,
  //       "phone": account.phone,
  //     };*/
  //     final tmp = await (datasource as RemoteTransferDataSourceImpl)
  //         .getVendorIdCode<TransferModelType>(id, entity);
  //     return tmp.fold((l) => Left(ServerFailure(message: l.exceptionMessage)),
  //         (tmp) async {
  //       // var aux =
  //       //     await LocalSecureStorage.storage.existsOnSecureStorage("account");
  //       // if (aux.toString() == "false") {
  //       //   await LocalSecureStorage.storage.write(
  //       //     "account",
  //       //     accountModelToJson(tmp),
  //       //   );
  //       //   Get.delete<AccountModel>();
  //       //   Get.put<AccountModel>(tmp);

  //       //   // LocalSecureStorage.storage
  //       //   //     .writeEncoded("account", json.encode(account));
  //       //   // LocalSecureStorage.storage
  //       //   //     .write("account", accountModelToJson(account));
  //       //   log("escribio la modificada");
  //       // } else {
  //       //   var readL = await LocalSecureStorage.storage.read("account");
  //       //   var readR = accountModelToJson(tmp);
  //       //   // var accountGetx = Get.find<AccountModel>();
  //       //   Get.delete<AccountModel>();
  //       //   Get.put<AccountModel>(tmp);

  //       //   if (readL != readR) {
  //       //     LocalSecureStorage.storage.write(
  //       //       "account",
  //       //       accountModelToJson(tmp),
  //       //     );
  //       //   }
  //       //   log("Comparo y sobrescribio");
  //       // }

  //       // LocalSecureStorage.storage.write("account", json.encode(r));
  //       return Right(tmp);
  //     });
  //   }
  //   return Left(NulleableFailure(
  //       message: "La instancia de ManagerAuthorizationService es nula."));

  //   // buildDataSource(PathsService.identityApiUrl);
  //   // final mas =
  //   //     ManagerAuthorizationService().get(PathsService.identityKey);

  //   // if (mas != null) {
  //   //   final result = await (datasource as RemoteAccountDataSourceImpl)
  //   //       .changePasswordAccount(id, entity);
  //   //   return result
  //   //       .fold((l) => Left(ServerFailure(message: l.exceptionMessage)), (r) {
  //   //     return Right(r as AccountModelType);
  //   //   });
  //   // }
  //   // return Left(NulleableFailure(
  //   //     message: "La instancia de ManagerAuthorizationService es nula."));
  // }

  @override
  Future<Either<Failure, TransferModelType>> add(entity) async {
    try {
      if (entity is Map) {
        entity = transferModelFromJson(json.encode(entity));
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
      final transfer = await datasource!.request(url, body, header);
      return Right(transfer);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, TransferModelType>> delete(dynamic entityId) async {
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
      final transfer = await datasource!.request(url, body, header);
      return Right(transfer);
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
  Future<Either<Failure, EntityModelList<TransferModelType>>> filter(
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
      final transfers = await datasource!.request(url, body, header);
      return Right(transfers);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, TransferModelType>> get(dynamic entityId) async {
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
      final transfer = await datasource!.request(url, body, header);
      return Right(transfer);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<TransferModelType>>> getAll() async {
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
      final transfers = await datasource!.request(url, body, header);
      return transfers.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<TransferModelType>>> getBy(
      Map params) async {
    try {
      final transferList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<TransferModelType>>> process(
          EntityModelList<TransferModelType> list) {
        EntityModelList<TransferModelType> listToReturn =
            DefaultEntityModelList<TransferModelType>();
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

      return transferList.fold(
          (l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.transfer));
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
  Future<Either<Failure, TransferModelType>> getTransfer(dynamic id) => get(id);

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
  Future<Either<Failure, EntityModelList<TransferModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<TransferModelType> operations = await datasource!
          .getProvider
          .paginate<EntityModelList<TransferModelType>>(
              start, limit, params) as EntityModelList<TransferModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, TransferModelType>> transferToAccount(
      id, entity) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);

    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");
      // var account = entity as AccountModelType;
      /* params = {
        "email": account.email,
        "phone": account.phone,
      };*/
      final tmp = await (datasource as RemoteTransferDataSourceImpl)
          .transferToAccount<TransferModelType>(id, entity);
      return tmp.fold((l) => Left(ServerFailure(message: l.toString())),
          (tmp) async {
        // var aux =
        //     await LocalSecureStorage.storage.existsOnSecureStorage("account");
        // if (aux.toString() == "false") {
        //   await LocalSecureStorage.storage.write(
        //     "account",
        //     accountModelToJson(tmp),
        //   );
        //   Get.delete<AccountModel>();
        //   Get.put<AccountModel>(tmp);

        //   // LocalSecureStorage.storage
        //   //     .writeEncoded("account", json.encode(account));
        //   // LocalSecureStorage.storage
        //   //     .write("account", accountModelToJson(account));
        //   log("escribio la modificada");
        // } else {
        //   var readL = await LocalSecureStorage.storage.read("account");
        //   var readR = accountModelToJson(tmp);
        //   // var accountGetx = Get.find<AccountModel>();
        //   Get.delete<AccountModel>();
        //   Get.put<AccountModel>(tmp);

        //   if (readL != readR) {
        //     LocalSecureStorage.storage.write(
        //       "account",
        //       accountModelToJson(tmp),
        //     );
        //   }
        //   log("Comparo y sobrescribio");
        // }

        // LocalSecureStorage.storage.write("account", json.encode(r));
        return Right(tmp);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));

    // buildDataSource(PathsService.identityApiUrl);
    // final mas =
    //     ManagerAuthorizationService().get(PathsService.identityKey);

    // if (mas != null) {
    //   final result = await (datasource as RemoteAccountDataSourceImpl)
    //       .changePasswordAccount(id, entity);
    //   return result
    //       .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
    //     return Right(r as AccountModelType);
    //   });
    // }
    // return Left(NulleableFailure(
    //     message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, TransferModelType>> transferToCard(id, entity) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);

    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");
      // var account = entity as AccountModelType;
      /* params = {
        "email": account.email,
        "phone": account.phone,
      };*/
      final tmp = await (datasource as RemoteTransferDataSourceImpl)
          .transferToCard<TransferModelType>(id, entity);
      return tmp.fold((l) => Left(ServerFailure(message: l.toString())),
          (tmp) async {
        // var aux =
        //     await LocalSecureStorage.storage.existsOnSecureStorage("account");
        // if (aux.toString() == "false") {
        //   await LocalSecureStorage.storage.write(
        //     "account",
        //     accountModelToJson(tmp),
        //   );
        //   Get.delete<AccountModel>();
        //   Get.put<AccountModel>(tmp);

        //   // LocalSecureStorage.storage
        //   //     .writeEncoded("account", json.encode(account));
        //   // LocalSecureStorage.storage
        //   //     .write("account", accountModelToJson(account));
        //   log("escribio la modificada");
        // } else {
        //   var readL = await LocalSecureStorage.storage.read("account");
        //   var readR = accountModelToJson(tmp);
        //   // var accountGetx = Get.find<AccountModel>();
        //   Get.delete<AccountModel>();
        //   Get.put<AccountModel>(tmp);

        //   if (readL != readR) {
        //     LocalSecureStorage.storage.write(
        //       "account",
        //       accountModelToJson(tmp),
        //     );
        //   }
        //   log("Comparo y sobrescribio");
        // }

        // LocalSecureStorage.storage.write("account", json.encode(r));
        return Right(tmp);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));

    // buildDataSource(PathsService.identityApiUrl);
    // final mas =
    //     ManagerAuthorizationService().get(PathsService.identityKey);

    // if (mas != null) {
    //   final result = await (datasource as RemoteAccountDataSourceImpl)
    //       .changePasswordAccount(id, entity);
    //   return result
    //       .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
    //     return Right(r as AccountModelType);
    //   });
    // }
    // return Left(NulleableFailure(
    //     message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, TransferModelType>> update(
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
      final transfer = await datasource!.request(url, body, header);
      return Right(transfer);
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
      datasource = RemoteTransferDataSourceImpl();
    } else {
      datasource = LocalTransferDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
