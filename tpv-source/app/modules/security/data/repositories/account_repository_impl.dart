import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '/app/core/services/local_storage.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/modules/security/domain/models/destinatario_model.dart';
import '/app/modules/security/domain/models/profile_model.dart';
import '../../../../../globlal_constants.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/account_datasource.dart';
import '../../domain/models/account_model.dart';
import '../../domain/repository/account_repository.dart';

class AccountRepositoryImpl<AccountModelType extends AccountModel>
    implements AccountRepository<AccountModelType> {
  late DataSource? datasource;
  FlutterSecureStorage storage = FlutterSecureStorage();

  AccountRepositoryImpl(this.storage);

  @override
  Future<Either<Failure, AccountModelType>> add(entity) async {
    try {
      if (entity is Map) {
        entity = accountModelFromJson(json.encode(entity));
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
      final account = await datasource!.request(url, body, header);
      return Right(account);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, AccountModelType>> changePasswordAccount(
      id, entity) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);

    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");
      // var account = entity as AccountModelType;
      /* params = {
        "email": account.email,
        "phone": account.phone,
      };*/
      final tmp = await (datasource as RemoteAccountDataSourceImpl)
          .changePasswordAccount<AccountModelType>(id, entity);
      return tmp.fold((l) => Left(ServerFailure(message: l.toString())),
          (tmp) async {
        await LocalSecureStorage.storage.existsOnSecureStorage("account");
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
  Future<Either<Failure, AccountModelType>> delete(dynamic entityId) async {
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
      final account = await datasource!.request(url, body, header);
      return Right(account);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  // Future<Either<Failure, AccountModelType>> getDisableTotp() async {
  //   buildDataSource(PathsService.identityApiUrl);
  //   final mas =
  //       ManagerAuthorizationService().get(PathsService.identityKey);

  //   if (mas != null) {
  //     final result =
  //         await (datasource as RemoteAccountDataSourceImpl).getDisableTotp();
  //     return result
  //         .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
  //       return Right(r);
  //     });
  //   }
  //   return Left(NulleableFailure(
  //       message: "La instancia de ManagerAuthorizationService es nula."));
  // }

  Future<Either<Failure, AccountModelType>> editAccount(
      Map<String, dynamic> data) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    log(data);
    buildDataSource(PathsService.identityApiUrl);
    String url = "/account/v1.0.0/account";
    if (mas != null) {
      final account = await (datasource as RemoteAccountDataSourceImpl)
          .editAccount<AccountModelType>(url, data);
      return account.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        storage.write(
            key: "account", value: json.encode(r), aOptions: storage.aOptions);
        // LocalSecureStorage.storage.write("account", json.encode(r));
        return Right(r);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  Future<Either<Failure, AccountModelType>> editAccountPassword(
      String newPassword, String oldPassword) async {
    buildDataSource(PathsService.identityApiUrl);
    String url = "/account/v1.0.0/account/password";
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);

    if (mas != null) {
      final account = await (datasource as RemoteAccountDataSourceImpl)
          .editAccountPassword<AccountModelType>(url, newPassword, oldPassword);
      return account.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        return Right(r);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  Future<Either<Failure, bool>> enviarCodigoVerifPhone(String code) async {
    buildDataSource(PathsService.identityApiUrl);
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);

    if (mas != null) {
      final result = await (datasource as RemoteAccountDataSourceImpl)
          .verificarCodigoVerifPhone(code);
      return result.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        return Right(r);
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
  Future<Either<Failure, EntityModelList<AccountModelType>>> filter(
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
      final accounts = await datasource!.request(url, body, header);
      return Right(accounts);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  Future<Either<Failure, String>> generarCodigoVerifPhone() async {
    buildDataSource(PathsService.identityApiUrl);
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);

    if (mas != null) {
      final account = await (datasource as RemoteAccountDataSourceImpl)
          .generarCodigoVerifPhone();
      return account.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        return Right(r);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, AccountModelType>> get(dynamic entityId) async {
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
      final account = await datasource!.request(url, body, header);
      return Right(account);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, AccountModelType>> getAccount(dynamic id) => get(id);

  @override
  Future<Either<Failure, AccountModelType>> getAccountModel(
      dynamic params) async {
    buildDataSource("https://${PathsService.apiEndpoint}");
    var account = await (datasource as RemoteAccountDataSourceImpl)
        .getAccount<AccountModelType>(params);
    if (params == "") {
      return account.fold((l) => Left(ServerFailure(message: l.toString())),
          (account) async {
        log("ESTA ES LA CUENTA TRAIDA EN REPOSITORY IMPL>>>>>>>>>>>>>>>${accountModelToJson(account)}");
        var tmp =
            await LocalSecureStorage.storage.existsOnSecureStorage("account");
        if (tmp.toString() == "false") {
          await LocalSecureStorage.storage
              .write("account", accountModelToJson(account));

          log("DEBE HABER EMPEZADO A ESCRIBIR");
        }

        return Right(account);
      });
    } else {
      return account.fold((l) => Left(ServerFailure(message: l.toString())),
          (account) async {
        log("ESTA ES LA CUENTA TRAIDA EN REPOSITORY IMPL>>>>>>>>>>>>>>>${accountModelToJson(account)}");

        return Right(account);
      });
      // return Left(NulleableFailure(
      //     message: "La instancia de ManagerAuthorizationService es nula."));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<AccountModelType>>> getAll() async {
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
      final accounts = await datasource!.request(url, body, header);
      return accounts.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<AccountModelType>>> getBy(
      Map params) async {
    try {
      final accountList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<AccountModelType>>> process(
          EntityModelList<AccountModelType> list) {
        EntityModelList<AccountModelType> listToReturn =
            DefaultEntityModelList<AccountModelType>();
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

      return accountList.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.account));
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
  Future<Either<Failure, EntityModelList<DestinatarioModel>>> getDestinatarios(
      dynamic entity) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("http://10.12.34.144:8080");
      // buildDataSource("https://${PathsService.apiEndpoint}");

      var destinatarios = await (datasource as RemoteAccountDataSourceImpl)
          .getDestinatarios<EntityModelList<DestinatarioModel>>(entity);
      return destinatarios.fold(
          (l) => Left(ServerFailure(message: l.toString())), (destinatarios) {
        // LocalSecureStorage.storage.write("cards", json.encode(cards));
        return Right(destinatarios);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, AccountModelType>> getDisableTotp() async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");
      var resp = await (datasource as RemoteAccountDataSourceImpl)
          .getDisableTotp<AccountModelType>();
      return resp.fold((l) => Left(ServerFailure(message: l.toString())),
          (resp) async {
        log("ESTA ES LA Respuesta de DISABLE+TOTP TRAIDA EN REPOSITORY ${accountModelToJson(resp)}");
        final mas = ManagerAuthorizationService().get(defaultIdpKey);
        ProfileModel? profile =
            mas!.getUserSession().getBy<ProfileModel>("profile");
        if (profile!.secondFactor == "true") {
          profile.secondFactor = "false";

          mas.getUserSession().set(
            "profile",
            profile,
            converter: (data) {
              return profileModelToJson(profile);
            },
          );
          // var aux = profileModelToJson(profile);
          // await LocalSecureStorage.storage.write("identity_profile", aux);
          //       .write("identity_profile", profileModelToJson(profile));
        } else {
          // profile.secondFactor = "true";

          // var aux = profileModelToJson(profile);
          // await LocalSecureStorage.storage.write("identity_profile", aux);
        }
        // var tmp = await LocalSecureStorage.storage
        //     .existsOnSecureStorage("identity_profile");
        // if (tmp.toString() == "false") {
        //   // await LocalSecureStorage.storage
        //   //     .write("identity_profile", profileModelToJson(tmp!));

        //   log("No existe profile model del identity guardado en local secure storage ");
        // } else {
        //   var forRead =
        //       await LocalSecureStorage.storage.read("identity_profile");
        //   var profile = profileModelFromJson(forRead!);
        //   var aux = profile.secondFactor;
        //   if (aux.toString() == "true") {
        //     profile.secondFactor = "false";
        //   }
        //   await LocalSecureStorage.storage
        //       .write("identity_profile", profileModelToJson(profile));
        // }

        return Right(resp);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, AccountModelType>> getRefreshTotp() async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");
      // final ProfileModel profileModel = mas.getUserSession().getBy("profile");
      // log("ESTE ES SUB EN REPOSITORY IMPLEMENTATION>>>>>>>>>>>>>>>>> ${profileModel.sub}");
      // var params = {
      //   "username": profileModel.sub,
      // };
      // log("PARAMS>>>>>>>>>>>>>>>>>$params");

      var account = await (datasource as RemoteAccountDataSourceImpl)
          .getRefreshTotp<AccountModelType>();
      return account.fold((l) => Left(ServerFailure(message: l.toString())),
          (account) async {
        log("ESTA ES LA CUENTA TRAIDA EN REPOSITORY IMPL>>>>>>>>>>>>>>>${accountModelToJson(account)}");
        final mas = ManagerAuthorizationService().get(defaultIdpKey);
        ProfileModel? profile =
            mas!.getUserSession().getBy<ProfileModel>("profile");
        if (profile!.secondFactor == "true") {
          // profile.secondFactor = "false";

          // mas.getUserSession().set(
          //   "profile",
          //   profile,
          //   converter: (data) {
          //     return profileModelToJson(profile);
          //   },
          // );
        } else {
          profile.secondFactor = "true";

          mas.getUserSession().set(
            "profile",
            profile,
            converter: (data) {
              return profileModelToJson(profile);
            },
          );

          // profile.secondFactor = "true";
          // print(profile);
          // var aux = profileModelToJson(profile);
          // await LocalSecureStorage.storage.write("identity_profile", aux);
        }
        // var tmp =
        //     await LocalSecureStorage.storage.existsOnSecureStorage("account");
        // if (tmp.toString() == "false") {
        //   await LocalSecureStorage.storage
        //       .write("account", accountModelToJson(account));

        //   log("DEBE HABER EMPEZADO A ESCRIBIR");
        // }

        return Right(account);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, AccountModelType>> getTotp() async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");

      var resp = await (datasource as RemoteAccountDataSourceImpl)
          .getTotp<AccountModelType>();
      return resp.fold((l) => Left(ServerFailure(message: l.toString())),
          (resp) async {
        log("ESTA ES LA Respuesta de GET+TOTP TRAIDA EN REPOSITORY IMPL>>>>>>>>>>>>>>>${accountModelToJson(resp)}");

        return Right(resp);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  @override
  Future<Either<Failure, AccountModelType>> getVerifyTotp(
      dynamic entity) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");

      var account = await (datasource as RemoteAccountDataSourceImpl)
          .getVerifyTotp<AccountModelType>(entity);
      return account.fold((l) => Left(ServerFailure(message: l.toString())),
          (account) async {
        log("ESTA ES LA Respuesta de GETVERIFYTOTP TRAIDA EN REPOSITORY IMPL>>>>>>>>>>>>>>>${accountModelToJson(account)}");

        final mas = ManagerAuthorizationService().get(defaultIdpKey);
        ProfileModel? profile =
            mas!.getUserSession().getBy<ProfileModel>("profile");

        if (profile!.secondFactor == "true") {
          // profile.secondFactor = "false";

          // mas.getUserSession().set(
          //   "profile",
          //   profile,
          //   converter: (data) {
          //     return profileModelToJson(profile);
          //   },
          // );
        } else {
          profile.secondFactor = "true";

          mas.getUserSession().set(
            "profile",
            profile,
            converter: (data) {
              return profileModelToJson(profile);
            },
          );
        }

        return Right(account);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  // Future<Either<Failure, String>> verificarToTPCode(String text) async {
  //   buildDataSource(PathsService.identityApiUrl);
  //   final mas =
  //       ManagerAuthorizationService().get(PathsService.identityKey);

  //   if (mas != null) {
  //     final result = await (datasource as RemoteAccountDataSourceImpl)
  //         .verificarToTPCode(text);
  //     return result
  //         .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
  //       return Right(r);
  //     });
  //   }
  //   return Left(NulleableFailure(
  //       message: "La instancia de ManagerAuthorizationService es nula."));
  // }

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
  Future<Either<Failure, EntityModelList<AccountModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<AccountModelType> operations = await datasource!
              .getProvider
              .paginate<EntityModelList<AccountModelType>>(start, limit, params)
          as EntityModelList<AccountModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, AccountModelType>> resetPaymentPassword(
      id, entity) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);

    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");
      // var account = entity as AccountModelType;
      /* params = {
        "email": account.email,
        "phone": account.phone,
      };*/
      final tmp = await (datasource as RemoteAccountDataSourceImpl)
          .resetPaymentPassword<AccountModelType>(id, entity);
      return tmp.fold((l) => Left(ServerFailure(message: l.toString())),
          (tmp) async {
        var aux = Get.find<AccountModel>();
        log("ESTE ES AUX>>>>>>>$aux");
        aux.paymentPassword = "false";
        Get.replace<AccountModel>(aux);

        var tmp2 = Get.find<AccountModel>();
        log("ESTE ES TPM2>>>>>>$tmp2");
        // await LocalSecureStorage.storage.existsOnSecureStorage("account");
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
  }

  // @override
  // Future<Either<Failure, Map<String, dynamic>>> resetPaymentPassword(
  //   String fundingSourceUuid,
  //   String cadenaEncript,
  //   String? cm,
  // ) async {
  //   buildDataSource(PathsService.identityApiUrl);
  //   final mas =
  //       ManagerAuthorizationService().get(PathsService.identityKey);

  //   if (mas != null) {
  //     final result = await (datasource as RemoteAccountDataSourceImpl)
  //         .resetPaymentPassword(fundingSourceUuid, cadenaEncript, cm);
  //     return result
  //         .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
  //       return Right(r);
  //     });
  //   }
  //   return Left(NulleableFailure(
  //       message: "La instancia de ManagerAuthorizationService es nula."));
  // }

  @override
  Future<Either<Failure, AccountModelType>> update(
      dynamic entityId, dynamic entity) async {
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);

    if (mas != null) {
      buildDataSource("https://${PathsService.apiEndpoint}");
      // var account = entity as AccountModelType;
      var account = AccountModel.fromJson(entity) as AccountModelType;

      /* params = {
        "email": account.email,
        "phone": account.phone,
      };*/

      final tmp = await (datasource as RemoteAccountDataSourceImpl)
          .updateEntity<AccountModelType>(entityId, account);
      return tmp.fold((l) => Left(ServerFailure(message: l.toString())),
          (tmp) async {
        var aux =
            await LocalSecureStorage.storage.existsOnSecureStorage("account");
        if (aux.toString() == "false") {
          await LocalSecureStorage.storage.write(
            "account",
            accountModelToJson(tmp),
          );
          Get.delete<AccountModel>();
          Get.put<AccountModel>(tmp);

          // LocalSecureStorage.storage
          //     .writeEncoded("account", json.encode(account));
          // LocalSecureStorage.storage
          //     .write("account", accountModelToJson(account));
          log("escribio la modificada");
        } else {
          var readL = await LocalSecureStorage.storage.read("account");
          var readR = accountModelToJson(tmp);
          // var accountGetx = Get.find<AccountModel>();
          await Get.delete<AccountModel>();
          Get.put<AccountModel>(tmp);

          if (readL != readR) {
            LocalSecureStorage.storage.write(
              "account",
              accountModelToJson(tmp),
            );
          }
          log("Comparo y sobrescribio");
        }

        // LocalSecureStorage.storage.write("account", json.encode(r));
        return Right(tmp);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  Future<Either<Failure, AccountModelType>> updatePaymentPassword(
      AccountModel accountModel, String accessToken) async {
    try {
      var paymentPassword = accountModel.paymentPassword;
      var oldPaymentPassword = accountModel.oldPaymentPassword;
      buildDataSource(PathsService.identityApiUrl);
      log("Este es PAYMENTPASSWORD>>>>>>>>>>>>>>$paymentPassword");
      log("Este es OLDPAYMENTPASSWORD>>>>>>>>>>>>>>$oldPaymentPassword");
      String url = "/account/v1.0.0/account";
      var data = {
        "payment_password": paymentPassword,
        "old_payment_password": oldPaymentPassword,
      };
      final response = await (datasource as RemoteAccountDataSourceImpl)
          .updatePaymentPassword(url, data);
      return response.fold(
          (l) => Left(ServerFailure(message: l.toString())), (r) => Right(r));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> verificarCodigoVerifPhone(String codigo) async {
    buildDataSource(PathsService.identityApiUrl);
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);

    if (mas != null) {
      final result = await (datasource as RemoteAccountDataSourceImpl)
          .verificarCodigoVerifPhone(codigo);
      return result.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        return Right(r);
      });
    }
    return Left(NulleableFailure(
        message: "La instancia de ManagerAuthorizationService es nula."));
  }

  DataSource _buildDataSource(String path) {
    path = path.toLowerCase();

    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
      caseSensitive: true,
      multiLine: false,
    );
    if (path.startsWith(remoteRegExp)) {
      datasource = RemoteAccountDataSourceImpl();
    } else {
      datasource = LocalAccountDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
