import 'package:apk_template/config/config.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
// import '../../../../core/interfaces/entity_model.dart';
// import '../../../../core/config/errors/errors.dart';
// import '../../../../core/interfaces/data_source.dart';
// import '../../../../core/interfaces/repository.dart';

abstract class ProductRepository {
  Future< List<ProductModel>> getListOfProducts();
  Future<Either<Failure, List<Product>>> filterListOfProducts(String type );
  Future<Either<Failure, void>>        sellProducts(List<Product> products);
  Future<Either<Failure, void>>       update(dynamic entityId, Product entity);
  Future<Either<Failure, Product>>       getProduct(dynamic id);
  Future<Either<Failure, List<Product>>> getProductsbyPage(int start, int limit, Map params);
  Future<Either<Failure, void>>       delete(dynamic entityId);
  Future<Either<Failure, void>>       add(Product entity);
  Future<Either<Failure, bool>>          exists(dynamic entityId);
}
