import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '/app/core/interfaces/header_request.dart';
import '/app/core/services/logger_service.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../domain/models/product_model.dart';

class ProductProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    // TODO: implement addEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) async {
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(
      Map<String, dynamic> filters) async {
    log("Entrando a filter en ProductProvider");
    // var idp = getIdentityIdp();
    // var accesToken = idp!.accessToken;
    Map<String, String> headers = await HeaderRequestImpl(
      idpKey: "apiez",
    ).getHeaders(accesToken: true);
    log("ESTOS SON LOS HEADERS PA LA CONSULTA EN EL ProductProvider>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$headers");
    var query = filters.entries.map((p) => '${p.key}=${p.value}').join('&');
    String url = "/products/getProductByFilter?$query";
    log("ESTE ES URL EN PROVIDER >>>>>>>>>>>$baseUrl$url");
    log("ESTE ES URL EN PROVIDER >>>>>>>>>>>$url");
    final resp = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          log("ESTE ES MAP EN EL PRODUCTPROVIDER>>>>>>>>$map");
          // log("ESTE ES AccountModel.fromJson EN EL ACCOUNTPROVIDER>>>>>>>>${AccountModel.fromJson(map)}");
          return ProductList.fromJson(map);
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
    log("Cargando listado de entidades...");
    String url = 'product/v1/products/getProductByFilter';
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      idpKey: "apiez",
    ).getHeaders(accesToken: true);

    final response = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return ProductList.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
    ));
    return response.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error al consultar listado de entidades.",
              "description": "Error al consultar listado de entidades."
            }));
      }
    });
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) {
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = defaultDecoder = super.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && !map.containsKey("fault")) {
        return map.containsKey("orders")
            ? ProductList.fromJson(map)
            : ProductList.fromJson(map);
      } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
        return Fault.fromJson(map['fault']);
      }
    };
    //httpClient.baseUrl = 'YOUR-API-URL';
  }

  @override
  Future<Either<Exception, TList>> paginate<TList>(
      int start, int limit, params) async {
    // TODO: implement paginate
    throw UnimplementedError();
  }

  @override
  ProductProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    // TODO: implement updateEntity
    throw UnimplementedError();
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
