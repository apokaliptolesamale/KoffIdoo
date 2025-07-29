import 'package:get/get.dart';

import '/app/core/services/identity_authorization_service.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/core/services/paths_service.dart';
import '/app/core/services/user_session.dart';
import '/app/modules/security/controllers/security_controller.dart';
import '/app/modules/security/domain/models/profile_model.dart';
import '/globlal_constants.dart';

Future<String> authenticate() {
  return getIdentityIdp()!.authorizeAndExchangeCode();
}

String? getAccessToken(IdentityAuthorizationService? idp) => idp?.accessToken;

ProfileModel? getAuthenticatedUserProfile() {
  final service = ManagerAuthorizationService().get(defaultIdpKey);
  UserSession? usession = service?.getUserSession();
  ProfileModel? profile = usession?.getBy<ProfileModel>(
    "profile",
    converter: (data, key) {
      return ProfileModel.converter(data, key);
    },
  );
  return profile;
}

String? getExpiresIn(IdentityAuthorizationService? idp) => idp?.expiresIn;

IdentityAuthorizationService? getIdentityIdp() {
  return ManagerAuthorizationService().get(PathsService.identityKey);
}

String? getIdToken(IdentityAuthorizationService? idp) => idp?.idToken;

String? getRefreshToken(IdentityAuthorizationService? idp) => idp?.refreshToken;

String? getTokenType(IdentityAuthorizationService? idp) => idp?.tokenType;

UserSession? getUserSession(IdentityAuthorizationService? idp) =>
    idp?.getUserSession();

Future<bool> isAuthenticated() async {
  final ctl = Get.find<SecurityController>();
  final auth =
      !await ctl.alreadyAuthenticated ? await ctl.isAuthenticated() : true;
  return Future.value(auth);
}
