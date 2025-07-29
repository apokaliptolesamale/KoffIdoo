import 'package:apk_template/config/errors/failure.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/datasources/cart_datasource.dart';
import 'package:dio/dio.dart';

class ShoppingCartDatasourceImpl extends ShoppingCartDatasource {
  List<ProductModel> _cart = [];

  final Dio dio = Dio();
  @override
  Future<List<Map<String, dynamic>>> getSellTicket() async {
    
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
      final response = await dio.post(
          'https://',
          options: options);

      if (response.statusCode == 200) {
        return [];
      } else {
        throw ServerFailure(
            errorMessage: 'Error al obtener los datos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al realizar la solicitud: $e');
    }
    
  }

  @override
  List<ProductModel> initailizeCart() {
    return _cart;
  }

  @override
  Future<void> sellProduct(List<ProductModel> listOfProducts) async {

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
      final response = await dio.post(
          'https://',
          options: options,data: ListProducts(results: listOfProducts).toJson());

      if (response.statusCode == 200) {
        return;
      } else {
        throw ServerFailure(
            errorMessage: 'Error al obtener los datos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al realizar la solicitud: $e');
    }
  }
}
