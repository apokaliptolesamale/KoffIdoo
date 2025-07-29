import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/qrcode_model.dart';

class QrCodeProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    final datos = (entity as QrCodeModel).toJson();
    datos.removeWhere((key, value) => value == null);
    httpClient.baseUrl = baseUrl;
    final response = await post(
      "qr/create",
      datos,
      contentType: 'application/json',
    );
    if (response.statusCode == 200) {
      entity.uuid = response.bodyString;
      return Right(entity);
    } else {
      throw HttpServerException(
          response: response,
          fault: Fault.fromJson({
            "code": response.statusCode,
            "type": "Error",
            "message": "Error al crear un código QR.",
            "description": "Error al crear un código QR."
          }));
    }
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) {
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(Map<String, dynamic> filters) {
    // TODO: implement filter
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (uuidValidation(map)) return map;
      if (map is Map<String, dynamic> && !map.containsKey("fault")) {
        return QrCodeList.fromJson(map);
      } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
        return Fault.fromJson(map['fault']);
      }
      return map;
    };
    //httpClient.baseUrl = 'YOUR-API-URL';
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) {
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  setBaseUrl(String baseUrl) => super.setBaseUrl(baseUrl);

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) {
    // TODO: implement updateEntity
    throw UnimplementedError();
  }

  uuidValidation(String uuid) {
    final regexUuid =
        r"^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$";
    RegExp regExp = RegExp(regexUuid);
    return regExp.hasMatch(uuid);
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
