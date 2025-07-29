import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../../../app/core/constants/constants.dart';
import '../../../../../app/core/interfaces/header_request.dart';
import '../../../../../app/core/services/logger_service.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../../../core/services/manager_authorization_service.dart';
import '../../../../core/services/paths_service.dart';
import '../../domain/models/account_model.dart';
import '../../domain/models/profile_model.dart';

class AccountProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    // TODO: implement addEntity
    //Map<String, String> headers = getHeader();
    throw UnimplementedError();
  }

  Future<Either<Exception, TModel>> changePasswordAccount<TModel>(
      dynamic id, dynamic entity) async {
    String url = "/account/v1.0.0/account/password";

    Map<String, String> headers =
        // {
        //   'Authorization': 'Bearer $accesToken',
        //   'accept': 'application/json',
        //   'Version': Constants.versionApk
        // };
        await HeaderRequestImpl(
      headers: {
        'accept': 'application/json',
        'Version': Constants.versionApk,
      },
      idpKey: "identity",
    ).getHeaders(accesToken: true);

    final resp = await processResponse(put(
      url,
      entity,
      headers: headers,
      decoder: (map) {
        log("ESTA ES RESPUESTA DE CHANGEACCOUNTPASSWORD EN EL PROVIDER>>>>>>>>>>>>>>>>>>>>>$map");
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return map.containsKey("account")
              ? AccountModel.fromJson(map["account"])
              : AccountModel.fromJson({});
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message":
                  "Error al intentar actualizar contraseña de la cuenta.",
              "description":
                  "Error al intentar actualizar contraseña de la cuenta."
            }));
      }
    });

    // throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) async {
    ////Map<String, String> headers = getHeader();
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }

  Future<Either<Exception, TModel>> editAccount<TModel>(
      String url, Map<String, dynamic> data) async {
    log("ESTE ES URL>>>>>>>>>>>>>>>>>>>>>>>$url");
    log("ESTE ES DATA>>>>>>>>>>>>>>>>>>>>>>>$data");
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        'Version': Constants.versionApk,
      },
      idpKey: "apiez",
    ).getHeaders();

    final resp = await processResponse(put(
      url,
      data,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return AccountModel.fromJson(map["account"]);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al intentar actualizar contraseña de pago.",
              "description": "Error al intentar actualizar contraseña de pago."
            }));
      }
    });
  }

  Future<Either<Exception, TModel>> editAccountPassword<TModel>(
      String url, String newPassword, String oldPassword) async {
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        'Version': Constants.versionApk,
      },
      idpKey: "apiez",
    ).getHeaders();
    var data = {
      "new_password": newPassword,
      "old_password": oldPassword,
    };
    log("ESTE ES URL>>>>>>>>>>>>>>>>>>>>>>>$url");
    log("ESTE ES DATA>>>>>>>>>>>>>>>>>>>>>>>$data");
    final resp = await processResponse(put(
      url,
      data,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return AccountModel.fromJson(map["account"]);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al intentar actualizar contraseña de pago.",
              "description": "Error al intentar actualizar contraseña de pago."
            }));
      }
    });
  }

  Future<Either<Exception, String>> enviarCodigoVerifPhone(String code) async {
    String url = "/account/v1.0.0/account/phone/code/number";
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        'Version': Constants.versionApk,
      },
      idpKey: "apiez",
    ).getHeaders();
    var data = {
      "number": code,
    };
    log("ESTE ES URL>>>>>>>>>>>>>>>>>>>>>>>$url");
    log("ESTE ES DATA>>>>>>>>>>>>>>>>>>>>>>>$data");
    final resp = await processResponse(post(
      url,
      data,
      headers: headers,
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al intentar actualizar contraseña de pago.",
              "description": "Error al intentar actualizar contraseña de pago."
            }));
      }
    });
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(
      Map<String, dynamic> filters) async {
    ////Map<String, String> headers = getHeader();
    // TODO: implement filter
    throw UnimplementedError();
  }

  Future<Either<Exception, String>> generarCodigoVerifPhone() async {
    String url = "/account/v1.0.0/account/phone/code";
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        'Version': Constants.versionApk,
      },
      idpKey: "apiez",
    ).getHeaders();
    final resp = await processResponse(get(
      url,
      headers: headers,
      /*decoder: (map) {
        if (map is Map<String, dynamic> &&
            map.containsKey("account") &&
            !map.containsKey("fault")) {
          return AccountModel.fromJson(map["account"]);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },*/
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al intentar actualizar contraseña de pago.",
              "description": "Error al intentar actualizar contraseña de pago."
            }));
      }
    });
  }

  Future<Either<Exception, TModel>> getAccount<TModel>(String params) async {
    log("Entrando a getAccount en ProfileRemoteDatasource");
    // var idp = getIdentityIdp();
    // var accesToken = idp!.accessToken;
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        'accept': 'application/json',
        'Version': Constants.versionApk,
      },
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    log("ESTOS SON LOS HEADERS PA LA CONSULTA EN EL ACCOUNTPROVIDER>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$headers");

    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    dynamic query;
    Map<String, dynamic> parameters = {};
    if (mas != null && await mas.isAuthenticated()) {
      if (params == "") {
        ProfileModel? aux = mas.getUserSession().getBy("profile");
        // var profileModel = profileModelFromJson(aux);

        if (aux == null) {
          parameters = {"username": ""};
        } else {
          log("ESTE ES SUB EN REPOSITORY IMPLEMENTATION>>>>>>>>>>>>>>>>> ${aux.sub}");
          parameters = {
            "username": aux.sub,
          };
        }

        log("PARAMS>>>>>>>>>>>>>>>>>$params");

        query = parameters.entries.map((p) => '${p.key}=${p.value}').join('&');
      } else {
        parameters = {"username": params};
        query = parameters.entries.map((p) => '${p.key}=${p.value}').join('&');
      }

      // var account = await (datasource as RemoteAccountDataSourceImpl)
      //     .getAccount<AccountModelType>(parameters);
      // if (params == "") {
      //   return account.fold((l) => Left(ServerFailure(message: l.toString())),
      //       (account) async {
      //     log("ESTA ES LA CUENTA TRAIDA EN REPOSITORY IMPL>>>>>>>>>>>>>>>${accountModelToJson(account)}");
      //     var tmp =
      //         await LocalSecureStorage.storage.existsOnSecureStorage("account");
      //     if (tmp.toString() == "false") {
      //       await LocalSecureStorage.storage
      //           .write("account", accountModelToJson(account));

      //       log("DEBE HABER EMPEZADO A ESCRIBIR");
      //     }

      //     return Right(account);
      //   });
      // } else {
      //   return account.fold((l) => Left(ServerFailure(message: l.toString())),
      //       (account) async {
      //     log("ESTA ES LA CUENTA TRAIDA EN REPOSITORY IMPL>>>>>>>>>>>>>>>${accountModelToJson(account)}");

      //     return Right(account);
      //   });
      // }
    }

    String url = "/account/v1.0.0/account?$query";
    log("ESTE ES URL EN PROVIDER >>>>>>>>>>>$baseUrl$url");
    final resp = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> &&
            map.containsKey("account") &&
            !map.containsKey("fault")) {
          log("ESTE ES MAP[ACCOUNT] EN EL ACCOUNTPROVIDER>>>>>>>>${map["account"]}");
          log("ESTE ES AccountModel.fromJson EN EL ACCOUNTPROVIDER>>>>>>>>${AccountModel.fromJson(map)}");
          return AccountModel.fromJson(map["account"]);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        log("RESP.BODY DE GETACCOUNT EN EL PROVIDER>>>>>>>>>>>>>>>>>>>>>>>>>>${resp.body}");
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al buscar la cuenta de enzona.",
              "description": "Error al buscar la cuenta de enzona."
            }));
      }
    });
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() async {
    //Map<String, String> headers = getHeader();
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) async {
    //Map<String, String> headers = getHeader();
    // TODO: implement paginate
    throw UnimplementedError();
  }

  Future<Either<Exception, TModel>> getDestinatarios<TModel>(
      Map<String, dynamic> entity) async {
    // print(baseUrl);
    var query = entity.entries.map((p) => '${p.key}=${p.value}').join('&');
    String url = "/allRecipient?$query";
    // baseUrl = "http://10.12.34.144:8080/allRecipient?$query";
    log("$baseUrl$url");
    // Map<String, String> headers = {
    //   'accept': 'application/json',
    //   // 'Version': Constants.versionApk,
    // };
    // await HeaderRequestImpl(
    //   headers: {s
    //     'accept': 'application/json',
    //     // 'Version': Constants.versionApk,
    //   },
    //   idpKey: "identity",
    // ).getHeaders(accesToken: true);
    final resp = await processResponse(get(
      url,
      // headers: headers,
      decoder: (map) {
        log("ESTE ES MAP DEgetDestinatarios EN EL PROVIDER>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$map");
        if (map is Map<String, dynamic> &&
            map.containsKey("reseted") &&
            !map.containsKey("fault")) {
          var tmp = jsonEncode(map);
          log("ESTE ES jsonEncode(map) EN EL PROVIDER>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${jsonEncode(map)}");
          // var aux = jsonDecode(map);
          log("ESTE ES accountModelFromJson(tmp) EN EL PROVIDER>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${accountModelFromJson(tmp)}");
          // AccountModel.fromJson(json)
          return accountModelFromJson(tmp);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al intentar actualizar contraseña de pago.",
              "description": "Error al intentar actualizar contraseña de pago."
            }));
      }
    });
  }

  Future<Either<Exception, TModel>> getDisableTotp<TModel>() async {
    String url = "/account/v1.0.0/account/TOTP/disable";
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        'accept': 'application/json',
        'Version': Constants.versionApk,
      },
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    final resp = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        log("ESTE ES MAP DE DISABLE+TOTP EN EL PROVIDER>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$map");
        if (map is Map<String, dynamic> &&
            map.containsKey("reseted") &&
            !map.containsKey("fault")) {
          var tmp = jsonEncode(map);
          log("ESTE ES jsonEncode(map) EN EL PROVIDER>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${jsonEncode(map)}");
          // var aux = jsonDecode(map);
          log("ESTE ES accountModelFromJson(tmp) EN EL PROVIDER>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${accountModelFromJson(tmp)}");
          // AccountModel.fromJson(json)
          return accountModelFromJson(tmp);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al intentar actualizar contraseña de pago.",
              "description": "Error al intentar actualizar contraseña de pago."
            }));
      }
    });
  }

  Future<Either<Exception, TModel>> getRefreshTotp<TModel>() async {
    // log("Este es CODE EN REPO IMPL>>>>>>>>>>>>>>>>>>$txt");
    var params = {
      // 'verificationCode': txt,
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    String url = "/account/v1.0.0/account/TOTP/validate?$query";
    log("URL DE TOTP VERIFICACION>>>>>>>>>>>>>>>>>>>$url");

    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        'Version': Constants.versionApk,
      },
      idpKey: "apiez",
    ).getHeaders();
    final resp = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> &&
            map.containsKey("account") &&
            !map.containsKey("fault")) {
          return map.toString();
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al intentar actualizar contraseña de pago.",
              "description": "Error al intentar actualizar contraseña de pago."
            }));
      }
    });
  }

  Future<Either<Exception, TModel>> getTotp<TModel>() async {
    String url = "/account/v1.0.0/account/TOTP/init";

    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        'accept': 'application/json',
        'Version': Constants.versionApk,
      },
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    final resp = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        log("ESTE ES MAP DE GET+TOTP EN EL PROVIDER>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$map");
        if (map is Map<String, dynamic> &&
            map.containsKey("response") &&
            !map.containsKey("fault")) {
          var tmp = jsonEncode(map);
          // AccountModel.fromJson(json)
          return accountModelFromJson(tmp);
          // : AccountModel.fromJson({});
          // return map["response"];
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al intentar obtener el ToTP Code.",
              "description": "Error al intentar obtener el ToTP Code."
            }));
      }
    });
  }

  Future<Either<Exception, TModel>> getVerifyTotp<TModel>(
      Map<String, dynamic> entity) async {
    log("Este es CODE EN PROVIDER GETVERIFYTOTP>>>>>>>>>>>>>>>>>>$entity");
    // var params = {
    //   'verificationCode': "$code",
    // };
    var query = entity.entries.map((p) => '${p.key}=${p.value}').join('&');
    String url = "/account/v1.0.0/account/TOTP/validate?$query";
    log("URL DE TOTP VERIFICACION>>>>>>>>>>>>>>>>>>>$url");

    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        'accept': 'application/json',
        'Version': Constants.versionApk,
      },
      idpKey: "identity",
    ).getHeaders(accesToken: true);
    final resp = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        log("ESTE ES MAP DE GET+VERIFY+TOTP EN EL PROVIDER>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$map");
        // log("ESTE ES MAP[ACCOUNT] EN EL ACCOUNTPROVIDER>>>>>>>>${map}");
        log("ESTE ES AccountModel.fromJson EN EL ACCOUNTPROVIDER>>>>>>>>${AccountModel.fromJson(map)}");
        if (map is Map<String, dynamic> &&
            map.containsKey("response") &&
            !map.containsKey("fault")) {
          var tmp = jsonEncode(map);
          log("ESTE ES accountModelFromJson(tmp) EN EL ACCOUNTPROVIDER>>>>>>>>${accountModelFromJson(tmp)}");
          return accountModelFromJson(tmp);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al verificar su código  ToTP.",
              "description": "Error al verificar su código  ToTP."
            }));
      }
    });
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = defaultDecoder = super.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && !map.containsKey("fault")) {
        return map.containsKey("orders")
            ? AccountList.fromJson(map)
            : AccountList.fromJson(map);
      } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
        return Fault.fromJson(map['fault']);
      }
    };
    //httpClient.baseUrl = 'YOUR-API-URL';
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    //Map<String, String> headers = getHeader();
    // TODO: implement paginate
    throw UnimplementedError();
  }

  Future<Either<Exception, TModel>> resetPaymentPassword<TModel>(
      dynamic id, dynamic entity) async {
    String url = "/account/v1.0.0/account/paymentpassword/reset";

    Map<String, String> headers =
        // {
        //   'Authorization': 'Bearer $accesToken',
        //   'accept': 'application/json',
        //   'Version': Constants.versionApk
        // };
        await HeaderRequestImpl(
      headers: {
        'accept': 'application/json',
        'Version': Constants.versionApk,
      },
      idpKey: "identity",
    ).getHeaders(accesToken: true);

    final resp = await processResponse(post(
      url,
      entity,
      headers: headers,
      decoder: (map) {
        log("ESTA ES RESPUESTA DE RESETPAYMENTPASSWORD EN EL PROVIDER>>>>>>>>>>>>>>>>>>>>>$map");
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return map.containsKey("account")
              ? AccountModel.fromJson(map["account"])
              : AccountModel.fromJson({});
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al intentar actualizar contraseña de pago.",
              "description": "Error al intentar actualizar contraseña de pago."
            }));
      }
    });

    // throw UnimplementedError();
  }

  // Future<Either<Exception, Map<String, dynamic>>>
  //     resetPaymentPassword(
  //   String fundingSourceUuid,
  //   String cadenaEncript,
  //   String? cm,
  // ) async {
  //   log("Este es FOUNDINGSOURCEUUID>>>>>>>>>>>>>>$fundingSourceUuid");
  //   log("Este es CADENAENCRIPT>>>>>>>>>>>>>>$cadenaEncript");
  //   log("Este es CARNETMILITAR>>>>>>>>>>>>>>${cm ?? ""}");
  //   String url = "/account/v1.0.0/account/paymentpassword/reset";
  //   var data = {
  //     "funding_source_uuid": fundingSourceUuid,
  //     "cadenaEncript": cadenaEncript,
  //     "CM": cm
  //   };
  //   Map<String, String> headers = await HeaderRequestImpl(
  //     headers: {
  //       'Version': Constants.versionApk,
  //     },
  //     idpKey: "apiez",
  //   ).getHeaders();

  //   log("ESTE ES URL>>>>>>>>>>>>>>>>>>>>>>>$url");
  //   log("ESTE ES DATA>>>>>>>>>>>>>>>>>>>>>>>$data");
  //   final resp = await processResponse(post(
  //     url,
  //     data,
  //     headers: headers,
  //   ));
  //   return resp.fold((l) => Left(l), (resp) {
  //     if (resp.statusCode == 200) {
  //       return Right(resp.body);
  //     } else {
  //       throw HttpServerException(
  //           response: resp,
  //           fault: Fault.fromJson({
  //             "code": resp.statusCode,
  //             "type": "Error",
  //             "message": "Error al intentar actualizar contraseña de pago.",
  //             "description": "Error al intentar actualizar contraseña de pago."
  //           }));
  //     }
  //   });
  // }

  @override
  AccountProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    String url = "/account/v1.0.0/account";
    // final entity = data;
    final account = (data as AccountModel).toJson();

    Map<String, String> headers =
        // {
        //   'Authorization': 'Bearer $accesToken',
        //   'accept': 'application/json',
        //   'Version': Constants.versionApk
        // };
        await HeaderRequestImpl(
      headers: {
        'accept': 'application/json',
        'Version': Constants.versionApk,
      },
      idpKey: "identity",
    ).getHeaders(accesToken: true);

    final resp = await processResponse(put(
      url,
      account,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          log("ESTA ES RESPUESTA DE EDITACCOUNT EN EL PROVIDER>>>>>>>>>>>>>>>>>>>>>${map["account"]}");
          return AccountModel.fromJson(map["account"]);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al intentar actualizar contraseña de pago.",
              "description": "Error al intentar actualizar contraseña de pago."
            }));
      }
    });
  }

  Future<Either<Exception, TModel>> updatePaymentPassword<TModel>(
      String url, Map<String, dynamic> data) async {
    log("ESTE ES URL>>>>>>>>>>>>>>>>>>>>>>>$url");
    log("ESTE ES DATA>>>>>>>>>>>>>>>>>>>>>>>$data");
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        'Version': Constants.versionApk,
      },
      idpKey: "apiez",
    ).getHeaders();

    final resp = await processResponse(put(
      url,
      data,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return AccountModel.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al intentar actualizar contraseña de pago.",
              "description": "Error al intentar actualizar contraseña de pago."
            }));
      }
    });
  }

  Future<Either<Exception, bool>> verificarCodigoVerifPhone(
      String codigo) async {
    String url = "/account/v1.0.0/account/phone/verified";
    var data = {
      "code": codigo,
    };
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        'Version': Constants.versionApk,
      },
      idpKey: "apiez",
    ).getHeaders();

    log("ESTE ES URL>>>>>>>>>>>>>>>>>>>>>>>$url");
    log("ESTE ES DATA>>>>>>>>>>>>>>>>>>>>>>>$data");
    final resp = await processResponse(put(
      url,
      data,
      headers: headers,
    ));
    return resp.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body.toString().toLowerCase() == "true");
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al intentar actualizar contraseña de pago.",
              "description": "Error al intentar actualizar contraseña de pago."
            }));
      }
    });
  }

  _readFileAsync(
    String path, {
    cache = true,
  }) {
    return rootBundle.loadString(
      path,
      cache: cache,
    );
  }
}
