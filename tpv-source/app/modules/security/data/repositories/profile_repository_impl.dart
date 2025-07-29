// ignore_for_file: unused_element, prefer_generic_function_type_aliases

import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../../app/modules/security/domain/models/profile_model.dart';
import '../../../../../app/modules/security/domain/repository/profile_repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../modules/security/data/datasources/token_datasource.dart';

typedef Future<ProfileModel> _ProfileModelFunction();

class ProfileRepositoryImpl<ProfileModel>
    implements ProfileRepository<ProfileModel> {
  late DataSource datasource;

  ProfileRepositoryImpl();

  @override
  Future<Either<Failure, ProfileModel>> add(entity) async {
    return Left(ServerFailure(message: 'Not implemented yet...'));
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, ProfileModel>> delete(dynamic entityId) async {
    return Left(ServerFailure(message: 'Not implemented yet...'));
  }

  @override
  Future<Either<Failure, bool>> exists(entityId) async {
    return Left(ServerFailure(message: 'Not implemented yet...'));
  }

  @override
  Future<Either<Failure, EntityModelList<ProfileModel>>> filter(
      Map<String, dynamic> filters) {
    // TODO: implement filter
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProfileModel>> get(dynamic entityId) async {
    return Left(ServerFailure(message: 'Error !!!'));
  }

  @override
  Future<Either<Failure, EntityModelList<ProfileModel>>> getAll() async {
    return Left(ServerFailure(message: 'Not implemented yet...'));
  }

  @override
  Future<Either<Failure, EntityModelList<ProfileModel>>> getBy(
      Map params) async {
    return Left(ServerFailure(message: 'Not implemented yet...'));
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfile(dynamic id) => get(id);

  @override
  Future<Either<Failure, EntityModelList<ProfileModel>>> paginate(
      int start, int limit, Map params) async {
    try {
      final users = await datasource.getProvider
              .paginate<EntityModelList<ProfileModel>>(start, limit, params)
          as EntityModelList<ProfileModel>;
      return Right(users);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> update(dynamic entityId, entity) async {
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
      return datasource = RemoteTokenDataSourceImpl();
    }
    return datasource = LocalTokenDataSourceImpl();
  }
}
