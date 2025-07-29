import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '/app/core/helpers/functions.dart';
import '/app/core/interfaces/header_request.dart';
import '/app/core/services/logger_service.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/config/errors/fault.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../../product/domain/models/product_model.dart';

class ProductProvider extends GetProviderImpl {
  @override
  Future<Either<Exception, TModel>> addEntity<TModel>(TModel entity) async {
    final datos = (entity as ProductModel).toJson();
    datos.removeWhere((key, value) =>
        value == null ||
        value.toString().isEmpty ||
        (value is List && value.isEmpty));
    // log(datos);
    //httpClient.baseUrl = baseUrl;
    final response = await processResponse(post(
      "products", jsonEncode(datos),
      headers: {"accept": "*/*", "Content-Type": "application/json"},
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return ProductModel.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
      //contentType: 'application/json',
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
              "message": "Error al crear una Orden.",
              "description": "Error al crear una Orden."
            }));
      }
    });
  }

  Future<Either<Exception, TModel>> checkEntity<TModel>(code) async {
    log("Cargando producto con código:$code");
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        // "accept": "*/*",
        // "Content-Type": "application/json",
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      },
      idpKey: "apiez",
    ).getHeaders();
    final response = await processResponse(get(
      "product-code/$code",
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          if (map.containsKey("getProductsByCodeResponse")) {
            log(map["getProductsByCodeResponse"]);
            return ProductModel.fromJson(map["getProductsByCodeResponse"]);
          } else {
            return ProductModel.fromJson(map);
          }
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
      //contentType: 'application/json',
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
              "message": "Error al crear un Producto.",
              "description": "Error al crear un Producto."
            }));
      }
    });
    /* final response = await processResponse(get(
      "product-code/$code",
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          if (map.containsKey("getProductsByCodeResponse")) {
            log(map["getProductsByCodeResponse"]);
            return ProductModel.fromJson(map["getProductsByCodeResponse"]);
          } else {
            return ProductModel.fromJson(map);
          }
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
      //contentType: 'application/json',
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
              "message": "Error al crear un Producto.",
              "description": "Error al crear un Producto."
            }));
      }
    });*/
  }

  @override
  Future<Either<Exception, TModel>> deleteEntity<TModel>(id) {
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, TList>> filter<TList>(
      Map<String, dynamic> filters) async {
    filters.removeWhere(
        (key, value) => value == null || (value is List && value.isEmpty));
    log("Buscando productos con filtro:${filters.toString()}");
    final url = filters.isNotEmpty
        ? "products/getProductByFilter?${getShemaQueryFromMap(filters)}"
        : "products/getProductByFilter";
    Map<String, String> headers = await HeaderRequestImpl(
      idpKey: "apiez",
    ).getHeaders();
    log("Url del API:$baseUrl$url");
    final resp = await processResponse(
      get(
        url,
        headers: headers,
      ),
    );
    return resp.fold((l) => Left(l), (resp) {
      if (resp.body is ProductList) {
        return Right(resp.body as TList);
      } else if (resp.body is Map) {
        return Right(ProductList.fromJson(resp.body) as TList);
      } else {
        return Right((resp.bodyString!.isNotEmpty
            ? ProductList.fromStringJson(resp.bodyString!)
            : ProductList.fromJson({})) as TList);
      }
    });
  }

  @override
  Future<Either<Exception, TList>> getAll<TList>() async {
    final url = "assets/models/products.json";
    final products = await _readFileAsync(url);
    return Right(ProductList.fromStringJson(products) as TList);
  }

  @override
  Future<Either<Exception, TList>> getBy<TList>(Map params) async {
    final url = "assets/models/products.json";
    final products = await _readFileAsync(url);
    return Right(ProductList.fromStringJson(products) as TList);
  }

  @override
  Future<Either<Exception, TModel>> getEntity<TModel>(id) async {
    final url = "products/id?id=$id";
    log("Cargando producto con id=$id desde $baseUrl$url");
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
      },
      idpKey: "apiez",
    ).getHeaders();

    final response = await processResponse(get(
      url,
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return ProductModel.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
      //contentType: 'application/json',
    ));
    return response.fold((l) => Left(l), (resp) {
      if (resp.statusCode == 200 && resp.body != null) {
        return Right(resp.body);
      } else {
        throw HttpServerException(
            response: resp,
            fault: Fault.fromJson({
              "code": resp.statusCode,
              "type": "Error",
              "message": "Error en la búsqueda del producto.",
              "description": "Error en la búsqueda del producto."
            }));
      }
    });
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && !map.containsKey("fault")) {
        return ProductModel.fromJson(map);
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
  ProductProvider setBaseUrl(String newBaseUrl) {
    super.setBaseUrl(httpClient.baseUrl = baseUrl = newBaseUrl);
    return this;
  }

  @override
  Future<Either<Exception, TModel>> updateEntity<TModel>(
      dynamic id, TModel data) async {
    final datos = data is ProductModel ? (data).toJson() : (data as Map);
    datos.removeWhere((key, value) =>
        value == null ||
        value.toString().isEmpty ||
        (value is List && value.isEmpty));
    log(datos);
    log("${baseUrl}products/updateProduct  -----------------------------------------");
    log(jsonEncode(datos));
    Map<String, String> headers = await HeaderRequestImpl(
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
      },
      idpKey: "apiez",
    ).getHeaders();
    final response = await processResponse(put(
      "products/updateProduct", jsonEncode(datos),
      headers: headers,
      decoder: (map) {
        if (map is Map<String, dynamic> && !map.containsKey("fault")) {
          return ProductModel.fromJson(map);
        } else if (map is Map<String, dynamic> && map.containsKey("fault")) {
          return Fault.fromJson(map['fault']);
        }
        return map;
      },
      //contentType: 'application/json',
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
              "message": "Error al crear una Orden.",
              "description": "Error al crear una Orden."
            }));
      }
    });
  }

  Future<String> _readFileAsync(
    String path, {
    cache = true,
  }) {
    return rootBundle.loadString(
      path,
      cache: cache,
    );
  }
}
