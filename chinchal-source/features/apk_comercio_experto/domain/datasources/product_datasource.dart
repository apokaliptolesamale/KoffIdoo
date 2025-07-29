import 'package:apk_template/config/errors/failure.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';

abstract class ProductDatasource {
  Future< List<ProductModel>> getListOfProducts();
  Future<Either<Failure, List<ProductModel>>> filterListOfProducts(String type );
  Future<Either<Failure, String>>        sellProducts(List<Product> products);
  Future<Either<Failure, void>>       update(dynamic entityId, Product entity);
  Future<Either<Failure, Product>>       getProduct(dynamic id);
  Future<Either<Failure, List<Product>>> getProductsbyPage(int start, int limit, Map params);
  Future<Either<Failure, void>>       delete(dynamic entityId);
  Future<Either<Failure, void>>       add(Product entity);
  Future<Either<Failure, bool>>          exists(dynamic entityId);
  
}
