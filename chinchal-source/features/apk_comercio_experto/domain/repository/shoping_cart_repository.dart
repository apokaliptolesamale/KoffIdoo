import '../../data/models/product_model.dart';

abstract class ShoppingCartRepository {
List<ProductModel> initailizeCart();
 Future<void> sellProduct(List<ProductModel> listOfProducts);
 Future<List<dynamic>> getSellTicket();
}