import 'dart:async';

import 'package:dartz/dartz.dart';

import '/app/core/constants/IDPConstantes.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/modules/transaction/domain/models/invoice_charged_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/invoice_datasource.dart';
import '../../domain/models/invoice_model.dart';
import '../../domain/repository/invoice_repository.dart';

class InvoiceRepositoryImpl<InvoiceModelType extends InvoiceModel>
    implements InvoiceRepository<InvoiceModelType> {
  late DataSource? datasource;

  InvoiceRepositoryImpl();
  DataSource _buildDataSource(String path) {
    path = path.toLowerCase();

    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
      caseSensitive: true,
      multiLine: false,
    );
    if (path.startsWith(remoteRegExp)) {
      datasource = RemoteInvoiceDataSourceImpl();
    } else {
      datasource = LocalInvoiceDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, InvoiceModelType>> getInvoice(dynamic id) => get(id);

  @override
  Future<Either<Failure, InvoiceModelType>> add(entity) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to add";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final invoice = await datasource!.request(url, body, header);
      return Right(invoice);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, InvoiceModelType>> delete(dynamic entityId) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to delete";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final invoice = await datasource!.request(url, body, header);
      return Right(invoice);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, bool>> exists(entityId) async {
    final result = await get(entityId);
    return result.fold((exception) {
      return Left(ServerFailure(message: 'Error !!!'));
    }, (model) {
      return Right(true);
    });
  }

  @override
  Future<Either<Failure, EntityModelList<InvoiceModelType>>> filter(
      Map<String, dynamic> filters) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    if (mas != null) {
      String url = API_HOST;
      // String url = "assets/models/invoice response.json";
      buildDataSource(url);
      final invoices = await (datasource as RemoteDataSource).filter(filters);
      // return Right(invoices as EntityModelList<InvoiceModelType>);
      return invoices.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        return Right(r);
      });
    }
    return Left(
        NulleableFailure(message: " La instancia ManagerAutorization es nula"));
  }

  @override
  Future<Either<Failure, EntityModelList<InvoiceModelType>>> getAll() async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    if (mas != null) {
      String url = API_HOST;
      // String url = "assets/models/invoice response.json";
      buildDataSource(url);
      final invoices = await (datasource as RemoteDataSource).getAll();
      // return Right(invoices as EntityModelList<InvoiceModelType>);
      return invoices.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        return Right(r);
      });
    }
    return Left(
        NulleableFailure(message: " La instancia ManagerAutorization es nula"));
  }

  @override
  Future<Either<Failure, InvoiceModelType>> get(dynamic entityId) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to get";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final invoice = await datasource!.request(url, body, header);
      return Right(invoice);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<InvoiceModelType>>> getBy(
      Map params) async {
    try {
      final invoiceList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<InvoiceModelType>>> process(
          EntityModelList<InvoiceModelType> list) {
        EntityModelList<InvoiceModelType> listToReturn =
            DefaultEntityModelList<InvoiceModelType>();
        params.forEach((key, value) {
          final itemsList = list.getList();
          for (var element in itemsList) {
            final json = (element).toJson();
            if (json.containsKey(key) && json[value] == value) {
              listToReturn.getList().add(element);
            }
          }
        });

        return Right(listToReturn);
      }

      return invoiceList.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.invoice));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, InvoiceModelType>> getClientId(
      Map<String, dynamic> params) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    if (mas != null) {
      String url = API_HOST;
      // String url = "assets/models/invoice response.json";
      buildDataSource(url);
      final invoices =
          await (datasource as RemoteInvoiceDataSourceImpl).getAll();
      //return Right(invoices as EntityModelList<InvoiceModelType>);
      return invoices.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        return Right(r);
      });
    }
    return Left(
        NulleableFailure(message: " La instancia ManagerAutorization es nula"));
  }

  @override
  Future<Either<Failure, EntityModelList<InvoiceModelType>>>
      getInvoiceByClientId(Map<String, dynamic> filters) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    if (mas != null) {
      String url = API_HOST;
      // String url = "assets/models/invoice response.json";
      buildDataSource(url);
      final invoices = await (datasource as RemoteInvoiceDataSourceImpl)
          .getInvoiceByClientId(filters);
      //return Right(invoices as EntityModelList<InvoiceModelType>);
      return invoices.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        log(r.toString());
        return Right(r);
      });
    }
    return Left(
        NulleableFailure(message: " La instancia ManagerAutorization es nula"));
  }

  @override
  Future<Either<Failure, EntityModelList<InvoiceModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<InvoiceModelType> operations = await datasource!
              .getProvider
              .paginate<EntityModelList<InvoiceModelType>>(start, limit, params)
          as EntityModelList<InvoiceModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, InvoiceModelType>> update(
      dynamic entityId, entity) async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to update";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final invoice = await datasource!.request(url, body, header);
      return Right(invoice);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
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
  Future<Either<Failure, InvoiceChargedModel>> payElectricityService(
      Map<String, dynamic> params) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    if (mas != null) {
      //String url = API_HOST;
      String url = "assets/models/invoice charged.json";
      buildDataSource(url);
      final clientinvoice = await (datasource! as LocalInvoiceDataSourceImpl)
          .requestInvoiceCharged(url);
      // final clientinvoice = await (datasource! as RemoteInvoiceDataSourceImpl).payEletricityService(params);
      return Right(clientinvoice);
      /*return clientinvoice
        .fold((l) => Left(ServerFailure(message: l.exceptionMessage)), (r) {
      log(r.toString());
      return Right(r);
    });*/
    }
    {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Either<Local, Remote> getDataSourcePath<Local, Remote>(String path) {
    buildDataSource(path);
    return isRemote(path)
        ? Right(datasource as Remote)
        : Left(datasource as Local);
  }

  /* DataSource _buildDataSource(String path) {
    path = path.toLowerCase();

    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
      caseSensitive: true,
      multiLine: false,
    );
    if (path.startsWith(remoteRegExp)) {
      datasource = RemoteInvoiceDataSourceImpl();
    } else {
      datasource = LocalInvoiceDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }*/
}
