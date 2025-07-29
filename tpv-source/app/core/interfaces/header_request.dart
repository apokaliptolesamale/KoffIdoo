// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../app/core/services/logger_service.dart';
import '../../../app/core/services/manager_authorization_service.dart';
import '../../../app/core/services/user_session.dart';

abstract class HeaderRequest implements Equatable {
  final Map<String, dynamic> _headers = {};
  Map<String, String> get headersRequest =>
      _headers.map((key, value) => MapEntry(key, value.toString()));
}

class HeaderRequestImpl implements HeaderRequest {
  @override
  Map<String, dynamic> _headers = {};
  String idpKey;
  HeaderRequestImpl({
    required this.idpKey,
    Map<String, String>? headers,
  }) {
    _headers = headers ?? {'accept': '*/*'};
  }

  @override
  Map<String, String> get headersRequest =>
      _headers.map((key, value) => MapEntry(key, value.toString()));

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
  bool forceAuthorizationHeader() {
    ManagerAuthorizationService mas = ManagerAuthorizationService();
    final key = idpKey;
    if (mas.has(key)) {
      final service = mas.get(key);

      if (service != null) {
        UserSession usession = service.getUserSession();
        usession.remove("expirationTime");
        return true;
      }
    }
    return false;
  }

  Future<Map<String, String>> getHeaders({
    Map<String, dynamic>? headers,
    bool forceAuthorization = false,
    bool accesToken = false,
    bool hostResolved = true,
  }) async {
    if (hostResolved = false) {
      return Future.value({
        //El host no está disponible
      });
    }
    ManagerAuthorizationService mas = ManagerAuthorizationService();
    final key = idpKey;
    if (mas.has(key)) {
      log("For $key=> Iniciando cabeceras de seguridad para configuraciones de Authentication Service");
      final service = mas.get(key);
      if (service != null /* && await service.isHostConfigurationResolved()*/) {
        UserSession usession = service.getUserSession();
        final session = usession;
        final valid = await service.isAuthenticated();
        if (valid) {
          final token = !accesToken &&
                  session.getToken != null &&
                  session.getToken!.isNotEmpty
              ? session.getToken
              : session.getAccessToken;
          _headers['Authorization'] = 'Bearer $token';
          log("For $key=> Cabeceras existentes y encontradas para Service");
        } else {
          service.removeWhereKeyStartWith(service.getPrefijo);
          return getHeaders(
            headers: headers,
            forceAuthorization: false,
          );
        }
        if (!_headers.containsKey('Authorization') || forceAuthorization) {
          {
            log("No existen cabeceras válidas de 'Authorization'. Se procede a forzar renegociación de token...");
            service.removeWhereKeyStartWith(service.getPrefijo);
            return getHeaders(
              headers: headers,
              forceAuthorization: true,
              hostResolved: await service.isHostConfigurationResolved(),
            );
          }
        }
      } else {
        return Future.value({
          //El host no está disponible
        });
      }
    }

    Map<String, dynamic> tmp = {};
    tmp.addAll(headers ?? {});
    tmp.addAll(_headers);
    log("For $key=> Retornando cabezeras...");
    return Future.value(
        tmp.map((key, value) => MapEntry(key, value.toString())));
  }
}
