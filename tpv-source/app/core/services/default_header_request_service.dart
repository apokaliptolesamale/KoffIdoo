import '/globlal_constants.dart';
import '../../../app/core/services/manager_authorization_service.dart';
import '../interfaces/header_request.dart';
import 'codes_app_service.dart';

class DefaultHeaderRequestService {
  final HeaderRequestImpl requestHeader = HeaderRequestImpl(
    idpKey: "apiez",
  );
  DefaultHeaderRequestService();

  HeaderRequestImpl get getRequestHeader => requestHeader;

  static Map<String, String> getHttpDefaulHeader() {
    final headers = DefaultHeaderRequestService();
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    final toAdd = {
      'Authorization':
          'Bearer ${service != null ? service.read(key: 'accessToken') : ""}',
      'accept': 'application/json',
      'Version': CodesAppServices.versionApk
    };
    headers.getRequestHeader.headersRequest.addAll(toAdd);
    return headers.getRequestHeader.headersRequest
        .map((key, value) => MapEntry(key, value.toString()));
  }
}
