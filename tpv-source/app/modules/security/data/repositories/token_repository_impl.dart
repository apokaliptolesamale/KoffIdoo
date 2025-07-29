// ignore_for_file: unused_element, prefer_generic_function_type_aliases

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:pkce/pkce.dart';

import '../../../../../app/core/services/logger_service.dart';
import '../../../../../app/core/services/paths_service.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../modules/security/data/datasources/token_datasource.dart';
import '../../../../modules/security/data/providers/token_provider.dart';
import '../../../../modules/security/domain/repository/token_repository.dart';

typedef Future<TM> _CardModelFunction<TM>();

class TokenRepositoryImpl<TokenModel> implements TokenRepository<TokenModel> {
  late DataSource datasource;

  TokenRepositoryImpl();

  @override
  Future<Either<Failure, TokenModel>> add(entity) async {
    return Left(ServerFailure(message: 'Not implemented yet...'));
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, TokenModel>> delete(dynamic entityId) async {
    return Left(ServerFailure(message: 'Not implemented yet...'));
  }

  @override
  Future<Either<Failure, bool>> exists(entityId) async {
    return Left(ServerFailure(message: 'Not implemented yet...'));
  }

  @override
  Future<Either<Failure, EntityModelList<TokenModel>>> filter(
      Map<String, dynamic> filters) {
    // TODO: implement filter
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TokenModel>> get(dynamic entityId) async {
    return Left(ServerFailure(message: 'Error !!!'));
  }

  @override
  Future<Either<Failure, EntityModelList<TokenModel>>> getAll() async {
    return Left(ServerFailure(message: 'Not implemented yet...'));
  }

  @override
  Future<Either<Failure, EntityModelList<TokenModel>>> getBy(Map params) async {
    return Left(ServerFailure(message: 'Not implemented yet...'));
  }

  @override
  Future<Either<Failure, TokenModel>> getUser(dynamic id) => get(id);

  Future<bool> isAuthenticated() {
    final url = "https://${PathsService.identityHost}";
    buildDataSource(url);
    log("My url es:${datasource.getProvider.baseUrl}");
    final tp = (datasource.getProvider as TokenProvider);
    tp.setBaseUrl(url);
    return tp.isAuthenticated();
  }

  Future<Either<Failure, TokenModel>> login() async {
    buildDataSource(PathsService.identityTokenEndpoint);
    final result = await (datasource.getProvider as TokenProvider).login("");
    return result.fold((l) {
      return Future.value(Left(ServerFailure(message: 'Error')));
    }, (r) {
      return Future.value(Right(r as TokenModel));
    });
  }

  Future<Either<Failure, dynamic>> logOut() async {
    /*final result = await (datasource.getProvider as TokenProvider).logOut();
    return result.fold((l) {
      return Left(ServerFailure(message: 'Error'));
    }, (r) {
      return Right(r);
    });*/
    return Left(ServerFailure(message: 'Error'));
  }

  @override
  Future<Either<Failure, EntityModelList<TokenModel>>> paginate(
      int start, int limit, Map params) async {
    try {
      final tokens = await datasource.getProvider
              .paginate<EntityModelList<TokenModel>>(start, limit, params)
          as EntityModelList<TokenModel>;
      return Right(tokens);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  Future<Either<Failure, void>> savePkcePair(PkcePair pkcePair) async {
    buildDataSource(PathsService.identityTokenEndpoint);
    return (datasource.getProvider as TokenProvider).savePkcePair(pkcePair);
  }

  @override
  Future<Either<Failure, TokenModel>> update(dynamic entityId, entity) async {
    return Left(ServerFailure(message: 'Not implemented yet...'));
  }

  @override
  bool isRemote(String path) {
    path = path.toLowerCase();

    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
      caseSensitive: true,
      multiLine: false,
    );
    return path.startsWith(remoteRegExp);
  }

  @override
  Either<Local, Remote> getDataSourcePath<Local, Remote>(String path) {
    buildDataSource(path);
    return isRemote(path)
        ? Right(datasource as Remote)
        : Left(datasource as Local);
  }

  DataSource _buildDataSource(String path) {
    path = path.toLowerCase();
    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)|(mms)|(mmss)$',
      caseSensitive: true,
      multiLine: false,
    );
    if (path.startsWith(remoteRegExp)) {
      datasource = RemoteTokenDataSourceImpl();
    } else {
      datasource = LocalTokenDataSourceImpl();
    }
    datasource.getProvider.setBaseUrl(path);
    return datasource;
  }
}
