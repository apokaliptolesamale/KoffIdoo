/*import '../../../../modules/tpv/data/product_data.dart';
import '../../../../modules/tpv/domain/entities/product_class.dart';

class InsertProduct {
  void insertProduct(Product p) {
    bool esta = false;
    int pos = 0;
    if (ProductListData.productsToGo.isEmpty) {
      //se anade
      ProductListData.productsToGo
          .add(Product(p.id, p.units, p.name, p.imageUrl, p.price, p.category));
      ProductListData
          .productsToGo[ProductListData.productsToGo.length - 1].units = 1;
      //se annade el elemento por primera vez
      p.units--;
    } else {
      for (int i = 0; i < ProductListData.productsToGo.length; i++) {
        if (ProductListData.productsToGo[i].id == p.id) {
          esta = true;
          pos = i;
        }
      }
      if (esta == false) {
        //el elemento no estaba y se annade
        ProductListData.productsToGo.add(
            Product(p.id, p.units, p.name, p.imageUrl, p.price, p.category));
        ProductListData
            .productsToGo[ProductListData.productsToGo.length - 1].units = 1;
        p.units--;
        return;
      } else {
        //el elemento esta y se incrementa
        if (p.units > 0) {
          ProductListData.productsToGo[pos].units++;
          p.units--;
        }
      }
    }
  }
}*/
