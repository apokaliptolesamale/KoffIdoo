// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'package:apk_template/config/config.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/datasources/product_datasource.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/product_model.dart';

class ProductRemoteDataSourceImpl implements ProductDatasource {
  ProductRemoteDataSourceImpl();
  final Dio dio = Dio();

  final StreamController<List<ProductModel>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<ProductModel>> get suggestionStream =>
      _suggestionStreamController.stream;

  

  Future<Either<Failure, ProductModel>> patchProductModel(
      Map<String, dynamic> data) async {
    var options = Options(
      method: 'PATCH',
      headers: {
        'Authorization': '',
      },
    );

    dio.options.contentType = 'application/json';

    dio.options.validateStatus = (status) {
      return status! < 500;
    };
    try {
      final response = await dio.patch('http://', data: data, options: options);

      if (response.statusCode == null) {
        return Left(ServerFailure(
            errorMessage:
                'Error al Conectar con el Server:-${response.statusCode}'));
      } else {
        return Right(ProductModel.fromJson(response.data));
      }
    } catch (e) {
      throw Exception('Error al realizar la solicitud: $e');
    }
  }

  @override
  Future<Either<Failure, ProductModel>> add(entity) async {
    var options = Options(
      method: 'POST',
      headers: {
        'Authorization': '',
      },
    );

    dio.options.contentType = 'application/json';

    dio.options.validateStatus = (status) {
      return status! < 500;
    };
    try {
      final response =
          await dio.post('http://', data: entity, options: options);

      if (response.data == null) {
        return Left(ServerFailure(errorMessage: "Error requesting token"));
      } else {
        log("POstPRoduct...");
        final data = ProductModel.fromJson(response.data);
        return Right(data);
      }
    } catch (e) {
      throw Exception('Error al realizar la solicitud: $e');
    }
  }

  @override
  Future<Either<Failure, ProductModel>> delete(entityId) async {
    var options = Options(
      method: 'DELETE',
      headers: {
        'id': id.toString(),
        'Authorization': '',
      },
    );

    dio.options.contentType = 'application/json';

    dio.options.validateStatus = (status) {
      return status! < 500;
    };

    try {
      final response = await dio.delete('http://', options: options);

      if (response.statusCode == null) {
        return Left(ServerFailure(
            errorMessage:
                'Error al Conectar con el Server:-${response.statusCode}'));
      } else {
        return  Right(response.data );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, bool>> exists(entityId) async {
   var options = Options(
      method: 'GET',
      headers: {
        'Authorization': '',
      },
    );

    dio.options.contentType = 'application/json';

    dio.options.validateStatus = (status) {
      return status! < 500;
    };

    try {
      final response = await dio.get('http://', options: options);

      if (response.statusCode == null) {
        return Left(ServerFailure(
            errorMessage:
                'Error al Conectar con el Server:-${response.statusCode}'));
      } else {
        return  Right(response.data );
      }
    } catch (e) {
      rethrow;
    }
  }

 


  @override
  Future<List<ProductModel>> getListOfProducts() async {
    var options = Options(
      method: 'GET',
      headers: {
        'Authorization': '',
      },
    );

    dio.options.contentType = 'application/json';

    dio.options.validateStatus = (status) {
      return status! < 500;
    };

    try {
      final response = await dio.get('https://6791b5d2cf994cc68047425a.mockapi.io/api/v1/product', options: options);

      if (response.statusCode == 200) {
        return ListProducts.fromMap(response.data).results;
      } 
      
      else {
        

        throw  ServerFailure(
            errorMessage:
                'Error al obtener los datos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al realizar la solicitud: $e');
    }
  } 

  @override
  Future<Either<Failure, ProductModel>> getProduct(id) async {
  var options = Options(
      method: 'GET',
      headers: {
        'Authorization': '',
      },
    );

    dio.options.contentType = 'application/json';

    dio.options.validateStatus = (status) {
      return status! < 500;
    };

    try {
      final response = await dio.get('https://6791b5d2cf994cc68047425a.mockapi.io/api/v1/product/$id', options: options);

      if (response.statusCode == null) {
        return Left(ServerFailure(
            errorMessage:
                'Error al Conectar con el Server:-${response.statusCode}'));
      } else {
        return  Right(response.data );
      }
    } catch (e) {
      rethrow;
    }
  }



  @override
  Future<Either<Failure, ProductModel>> update(entityId, entity) async {
   var options = Options(
      method: 'PATCH',
      headers: {
        'Authorization': '',
      },
    );

    dio.options.contentType = 'application/json';

    dio.options.validateStatus = (status) {
      return status! < 500;
    };

    try {
      final response = await dio.patch('http://', options: options);

      if (response.statusCode == null) {
        return Left(ServerFailure(
            errorMessage:
                'Error al Conectar con el Server:-${response.statusCode}'));
      } else {
        return  Right(response.data );
      }
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Either<Failure, List<ProductModel>>> filterListOfProducts(String type) async {
  var options = Options(
      method: 'GET',
      headers: {
        'Authorization': '',
      },
    );

    dio.options.contentType = 'application/json';

    dio.options.validateStatus = (status) {
      return status! < 500;
    };

    try {
      final response = await dio.get('http://', options: options);

      if (response.statusCode == null) {
        return Left(ServerFailure(
            errorMessage:
                'Error al Conectar con el Server:-${response.statusCode}'));
      } else {
        return  Right(response.data );
      }
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Either<Failure, List<Product>>> getProductsbyPage(int start, int limit, Map params) async {
   var options = Options(
      method: 'GET',
      headers: {
        'Authorization': '',
      },
    );

    dio.options.contentType = 'application/json';

    dio.options.validateStatus = (status) {
      return status! < 500;
    };

    try {
      final response = await dio.get('http://', options: options);

      if (response.statusCode == null) {
        return Left(ServerFailure(
            errorMessage:
                'Error al Conectar con el Server:-${response.statusCode}'));
      } else {
        return  Right(response.data );
      }
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Either<Failure, String>> sellProducts(List<Product> products) {
    // TODO: implement sellProducts
    throw UnimplementedError();
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // getProductModel() async {
  //   //TODO:CAMBIAR POR EL URL CORRESPONDIENTE

  //   final jsonData = await _getJsonData();
  //   final clientResponse = ListProducts.fromMap(jsonData);

  //   return clientResponse.results;
  // }

  // deleteProductModel(int id) async {
  //   //TODO:CAMBIAR POR EL URL CORRESPONDIENTE
  //   final response = await _deleteProductModel(id);
  //   if (response == 'Eliminado Con Exito') {
  //     //TODO:ACTUALIZAR CLIENTETRAMITE

  //     return response;
  //   }
  // }

  // searchProductModel(String query) async {
  //   final url = Uri.http(
  //     'http://$query',
  //   );
  //   final response = await http.get(url, headers: {'auth-token': ''});

  //   final searchResponse = ListProducts.fromJson(response.body);
  //   return searchResponse.results;
  // }

  // void getSuggestionsByQuery(String SearchTerm) {
  //   debouncer.value = '';
  //   debouncer.onValue = (value) async {
  //     final results = await searchProductModel(value);
  //     _suggestionStreamController.add(results);
  //   };
  //   final timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
  //     debouncer.value = SearchTerm;
  //   });
  //   Future.delayed(const Duration(milliseconds: 1001))
  //       .then((_) => timer.cancel());
  // }
}
