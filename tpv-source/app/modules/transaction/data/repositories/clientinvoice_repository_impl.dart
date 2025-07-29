import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import '/app/core/constants/IDPConstantes.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/modules/transaction/domain/models/client_service_model.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/body_request.dart';
import '../../../../core/interfaces/data_source.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/header_request.dart';
import '../../../../core/services/paths_service.dart';
import '../../data/datasources/clientinvoice_datasource.dart';
import '../../domain/models/clientinvoice_model.dart';
import '../../domain/models/etecsa_invoice_model.dart';
import '../../domain/repository/clientinvoice_repository.dart';

class ClientInvoiceRepositoryImpl<
        ClientInvoiceModelType extends ClientInvoiceModel,
        EtecsaModelType extends EtecsaModel>
    implements ClientInvoiceRepository<ClientInvoiceModelType> {
  late DataSource? datasource;

  ClientInvoiceRepositoryImpl();

  @override
  Future<Either<Failure, ClientInvoiceModelType>> add(entity) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    if (entity is Map) {
      entity = clientinvoiceModelFromJson(json.encode(entity));
    }
    if (mas != null) {
      String url = API_HOST;
      buildDataSource(url);
      final clientinvoice = await datasource!.addEntity(entity);
      return clientinvoice
          .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
        log(r.toString());
        return Right(r);
      });
    }
    {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, ClientServiceModel>> addClientId(entity) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    if (mas != null) {
      String url = API_HOST;
      buildDataSource(url);
      final clientinvoice =
          await (datasource! as RemoteClientInvoiceDataSourceImpl)
              .addClientId(entity);
      return clientinvoice
          .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
        log(r.toString());
        return Right(r);
      });
    }
    {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  DataSource buildDataSource(String path) => _buildDataSource(path);

  @override
  Future<Either<Failure, ClientInvoiceModelType>> delete(
      dynamic entityId) async {
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
      final clientinvoice = await datasource!.request(url, body, header);
      return Right(clientinvoice);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, ClientServiceModel>> deleteClientId(clientId) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    if (mas != null) {
      String url = API_HOST;
      buildDataSource(url);
      final clientIds = await (datasource as RemoteClientInvoiceDataSourceImpl)
          .deleteClientId<ClientServiceModel>(clientId);
      return clientIds.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        log(r.toString());
        return Right(r);
      });
    }
    {
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
  Future<Either<Failure, EntityModelList<ClientInvoiceModelType>>> filter(
      Map<String, dynamic> filters) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    log(ms.toString());
    if (mas != null) {
      // String url = API_HOST;
      // buildDataSource(url);
      buildDataSource("https://${PathsService.apiEndpoint}");
      final clientIds = await (datasource as RemoteClientInvoiceDataSourceImpl)
          .filter<EntityModelList<ClientInvoiceModelType>>(filters);
      return clientIds.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        log(r.toString());
        return Right(r);
      });
    }
    return Left(
        NulleableFailure(message: " La instancia ManagerAutorization es nula"));
  }

  @override
  Future<Either<Failure, ClientInvoiceModelType>> get(dynamic entityId) async {
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
      final clientinvoice = await datasource!.request(url, body, header);
      return Right(clientinvoice);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModelType>>>
      getAll() async {
    try {
      //TODO Asigne la url del API o recurso para adicionar
      String url = "Url to get by field";
      //TODO construya la instancia personalizada de BodyRequest o utilice EmptyBodyRequest
      BodyRequest body = EmptyBodyRequest();
      //TODO construya la instancia personalizada de HeaderRequest o utilice  HeaderRequestImpl
      HeaderRequest header = HeaderRequestImpl(
        idpKey: "apiez",
      );
      buildDataSource(url);
      final clientinvoices = await datasource!.request(url, body, header);
      return Right(clientinvoices);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModelType>>> getBy(
      Map params) async {
    try {
      final clientinvoiceList = await datasource!.getAll();

      FutureOr<Either<Failure, EntityModelList<ClientInvoiceModelType>>>
          process(EntityModelList<ClientInvoiceModelType> list) {
        EntityModelList<ClientInvoiceModelType> listToReturn =
            DefaultEntityModelList<ClientInvoiceModelType>();
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

      return clientinvoiceList.fold(
          (l) => Left(ServerFailure(message: l.toString())),
          (r) => process(r.clientinvoice));
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModelType>>> getClientId(
      Map params) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    log(ms.toString());
    if (mas != null) {
      String url = API_HOST;
      buildDataSource(url);
      final clientIds = await (datasource as RemoteClientInvoiceDataSourceImpl)
          .getClientId(params as Map<String, dynamic>);
      return clientIds.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        log(r.toString());
        return Right(r);
      });
    }
    return Left(
        NulleableFailure(message: " La instancia ManagerAutorization es nula"));
  }

  @override
  Future<Either<Failure, ClientInvoiceModelType>> getClientInvoice(
          dynamic id) =>
      get(id);

  @override
  Either<Local, Remote> getDataSourcePath<Local, Remote>(String path) {
    buildDataSource(path);
    return isRemote(path)
        ? Right(datasource as Remote)
        : Left(datasource as Local);
  }

  @override
  Future<Either<Failure, EtecsaModelType>> getFactMensualEtecsa(
      Map<String, dynamic> params) async {
    // final ms = ManagerAuthorizationService();
    // final mas = ms.get(PathsService.identityKey);
    // log(ms.toString());

    // String url = API_HOST;
    // buildDataSource(url);
    buildDataSource("https://${PathsService.apiEndpoint}");
    final facturas = await (datasource as RemoteClientInvoiceDataSourceImpl)
        .getFactMensualEtecsa<EtecsaModelType>(params);
    return facturas.fold((l) {
      return Left(ServerFailure(message: l.toString()));
    }, (r) {
      log(r.toString());
      return Right(r);
    });

    // return Left(
    //     NulleableFailure(message: " La instancia ManagerAutorization es nula"));
  }

  @override
  bool isRemote(String path) {
    // TODO: implement isRemote
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EntityModelList<ClientServiceModel>>> listClientConfig(
      Map<String, dynamic> params) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    if (mas != null) {
      String url = API_HOST;
      buildDataSource(url);
      final clientIds = await (datasource as RemoteClientInvoiceDataSourceImpl)
          .listClientConfig<EntityModelList<ClientServiceModel>>(params);
      return clientIds.fold((l) => Left(ServerFailure(message: l.toString())),
          (r) {
        log(r.toString());
        return Right(r);
      });
    }
    {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModelType>>> paginate(
      int start, int limit, Map params) async {
    try {
      buildDataSource(PathsService.apiOperationHost);

      EntityModelList<ClientInvoiceModelType> operations = await datasource!
          .getProvider
          .paginate<EntityModelList<ClientInvoiceModelType>>(
              start, limit, params) as EntityModelList<ClientInvoiceModelType>;

      return Right(operations);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  @override
  Future<Either<Failure, EntityModelList<InvoiceModel>>> payElectricityService(
      Map<String, dynamic> params) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    if (mas != null) {
      String url = API_HOST;
      buildDataSource(url);
      final clientinvoice =
          await (datasource! as RemoteClientInvoiceDataSourceImpl)
              .payEletricityService(params);
      return clientinvoice
          .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
        log(r.toString());
        return Right(r);
      });
    }
    {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  /* @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModelType>>>
      payElectricityService(Map<String, dynamic> params) async {
    final ms = ManagerAuthorizationService();
    final mas = ms.get(PathsService.identityKey);
    if (mas != null) {
      String url = API_HOST;
      buildDataSource(url);
      final clientinvoice =
          await (datasource! as RemoteClientInvoiceDataSourceImpl)
              .payEletricityService(params);
      return clientinvoice
          .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
        log(r.toString());
        return Right(r);
      });
    }
    {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }*/

  @override
  Future<Either<Failure, ClientInvoiceModelType>> update(
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
      final clientinvoice = await datasource!.request(url, body, header);
      return Right(clientinvoice);
    } on ServerException {
      return Left(ServerFailure(message: 'Error !!!'));
    }
  }

  DataSource _buildDataSource(String path) {
    path = path.toLowerCase();

    RegExp remoteRegExp = RegExp(
      r'^(http)|(https)|(ftp)|(ftps)|(ws)|(wss)]|(mms)$',
      caseSensitive: true,
      multiLine: false,
    );
    if (path.startsWith(remoteRegExp)) {
      datasource = RemoteClientInvoiceDataSourceImpl();
    } else {
      datasource = LocalClientInvoiceDataSourceImpl();
    }
    datasource!.getProvider.setBaseUrl(path);
    return datasource!;
  }
}
