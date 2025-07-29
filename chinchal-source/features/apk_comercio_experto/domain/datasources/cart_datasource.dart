import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/entities/entities.dart';

abstract class ShoppingCartDatasource {
 List<ProductModel> initailizeCart();
 Future<void> sellProduct(List<ProductModel> listOfProducts);
 Future<List<dynamic>> getSellTicket();
}
