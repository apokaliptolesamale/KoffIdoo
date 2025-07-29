import 'package:apk_template/features/apk_comercio_experto/data/datasources/shopping_cart_datasource_impl.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';


import '../../domain/repository/shoping_cart_repository.dart';

class ShoppingCartRepositoryImpl extends ShoppingCartRepository {
  final ShoppingCartDatasourceImpl shoppingCartDatasource;

  ShoppingCartRepositoryImpl({required this.shoppingCartDatasource});
  @override
  Future<List> getSellTicket() {
    return shoppingCartDatasource.getSellTicket();
  }

  @override
  List<ProductModel> initailizeCart() {
    return shoppingCartDatasource.initailizeCart();
  }

  @override
  Future<void> sellProduct(List<ProductModel> listOfProducts) {
    return shoppingCartDatasource.sellProduct(listOfProducts);
  }
}
