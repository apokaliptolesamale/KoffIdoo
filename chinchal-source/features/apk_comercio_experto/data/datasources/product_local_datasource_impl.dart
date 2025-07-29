import 'package:apk_template/config/errors/failure.dart';
import 'package:apk_template/config/services/sqlite_database.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/datasources/product_datasource.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/entities/product.dart';
import 'package:dartz/dartz.dart';


class ProductLocalDatasource extends ProductDatasource {
  
  final sqliteDb = SqlLiteDataBase();

  Future<Either<Failure, void>> add(Product entity) async {
    // TODO: implement add
    try {
      return Right(sqliteDb.insertProduct(entity as ProductModel));
    } catch (e) {
      return Left(StoreFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(entityId) async {
    // TODO: implement delete
    try {
      return Right(sqliteDb.deleteProduct(entityId));
    } catch (e) {
      return Left(StoreFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> exists(entityId) {
    // TODO: implement exists
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductModel>>> filterListOfProducts(String type) {
    // TODO: implement filterListOfProducts
    throw UnimplementedError();
  }

  @override
  Future< List<ProductModel>> getListOfProducts() async {
    // TODO: implement getListOfProducts
    try {
      return sqliteDb.getProductList();
    } catch (e) {
      throw StoreFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(id) async {
    // TODO: implement getProduct
    try {
      List<Product> products = await sqliteDb.getProductList();
      return Right( products.where((element) => element.id! == id).first);
    } catch (e) {
      return Left(StoreFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsbyPage(
      int start, int limit, Map params) {
    // TODO: implement getProductsbyPage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> sellProducts(List<Product> products) {
    // TODO: implement sellProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> update(entityId, Product entity) async {
    try {
      return Right(sqliteDb.updateProduct(entity as ProductModel));
    } catch (e) {
      return Left(StoreFailure(errorMessage: e.toString()));
    }
  }
}
