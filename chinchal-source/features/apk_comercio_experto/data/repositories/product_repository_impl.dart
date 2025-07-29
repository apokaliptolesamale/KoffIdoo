import 'package:apk_template/config/errors/failure.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/datasources/product_datasource.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/entities/product.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';


class ProductRepositoryImpl extends ProductRepository {
  final ProductDatasource productDataSource;

  ProductRepositoryImpl({required this.productDataSource});

  @override
  Future<Either<Failure, void>> add(entity) async {
    try {
      final result = await productDataSource.add(entity);

    return  const Right({});
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'Error $e'));
    }
  }

  @override
  Future<Either<Failure, void>> delete(entityId) async {
    try {
      final result = await productDataSource.delete(entityId);

      return Right( (){});
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'Error $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> exists(entityId) async {
    try {
      final result = await productDataSource.exists(entityId);

      return result;
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'Error $e'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> filterListOfProducts(
      String type) async {
    try {
      final result = await productDataSource.filterListOfProducts(type);

      return result;
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'Error $e'));
    }
  }

  @override
  Future< List<ProductModel>> getListOfProducts() async {
    try {
      final result = await productDataSource.getListOfProducts();

      return result;
    } catch (e) {
     throw ServerFailure(errorMessage: 'Error $e');
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(id) async {
    try {
      final result = await productDataSource.getProduct(id);

      return result;
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'Error $e'));
    }
  }

  @override
  Future<Either<Failure, String>> sellProducts(List<Product> products) async {
    try {
      final result = await productDataSource.sellProducts(products);

      return result;
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'Error $e'));
    }
  }

  @override
  Future<Either<Failure,void>> update(entityId, entity) async {
    try {
      final result = await productDataSource.update(entityId, entity);

      return result;
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'Error $e'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsbyPage(
      int start, int limit, Map params) async {
    try {
      final result =
          await productDataSource.getProductsbyPage(start, limit, params);

      return result;
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'Error $e'));
    }
  }
}
