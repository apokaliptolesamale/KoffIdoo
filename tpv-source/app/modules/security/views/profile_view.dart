// ignore_for_file: must_be_immutable, prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/globlal_constants.dart';
import '../../../../app/core/config/assets.dart';
import '../../../../app/core/config/errors/errors.dart';
import '../../../../app/core/services/manager_authorization_service.dart';
import '../../../../app/core/services/paths_service.dart';
import '../../../../app/modules/security/domain/models/profile_model.dart';
import '../../../../app/widgets/bar/custom_app_bar.dart';
import '../../../../app/widgets/images/background_image.dart';
import '../../../../app/widgets/layout/card/empty_card.dart';
import '../../../../app/widgets/layout/card/info_card.dart';
import '../../../../app/widgets/panel/custom_empty_data_search.dart';
import '../../../../app/widgets/promise/custom_future_builder.dart';
import '../../../../app/widgets/utils/loading.dart';
import '../controllers/security_controller.dart';

class ProfileView extends GetResponsiveView<SecurityController> {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _redirectHandle(context),
      builder: (_, __) => getProfileBuilder()(_, __),
      context: context,
    );
  }

  Widget createPage(BuildContext context, Widget body) {
    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_DEFAULT_JPG,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          //bottomNavigationBar: CustomBotoonNavBar.fromRoute(Get.currentRoute),
          appBar: CustomAppBar(
            keyStore: "appbar",
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back),
            ),
            title: Text('Mi perfil'),
            backgroundColor: Color(0xFF00b1a4),
          ),
          body: SafeArea(
            minimum: EdgeInsets.only(top: 30),
            child: body,
          ),
        )
      ],
    );
  }

  createWidgetFromProfile(ProfileModel? profile) {
    bool remoteLoaded = false;
    final avatarUrl = (remoteLoaded =
            (profile != null && profile.userName.isNotEmpty))
        ? "${PathsService.mediaHost}images/user/avatar/${profile!.userName}.png"
        : Assets.ASSETS_IMAGES_ICONS_APP_CUENTA_PNG.getPath;
    bool isValid = remoteLoaded;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            child: ClipRRect(
              child: isValid
                  ? Image.network(avatarUrl)
                  : Image.asset(
                      avatarUrl), // CustomImageResource.buildFromUrl(avatarUrl),
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          Text(
            isValid
                ? "${profile.givenName} ${profile.familyName}"
                : "Perfil del usuario",
            style: TextStyle(
              fontSize: 40,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontFamily: "Pacifico",
            ),
          ),
          Text(
            isValid ? profile.userName : "Usuario",
            style: TextStyle(
              fontSize: 30,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontFamily: "Source Sans Pro",
            ),
          ),
          SizedBox(
            height: 20,
            width: double.infinity,
            child: Divider(
              color: Colors.white,
            ),
          ),
          if (!isValid)
            EmptyDataCard(
                text: "No se inició correctamente el perfil del usuario.",
                margin: EdgeInsets.only(top: 100),
                onPressed: () {}),
          //Cards
          if (profile != null && profile.phoneNumber.isNotEmpty)
            InfoCard(
              text: isValid ? profile.phoneNumber : "",
              icon: Icon(
                Icons.phone,
                color: isValid ? Colors.teal : null,
              ),
              onPressed: () async {},
            ),
          if (profile != null && profile.identification.isNotEmpty)
            InfoCard(
              text: isValid ? profile.identification : "",
              icon: Icon(
                Icons.perm_identity,
                color: isValid ? Colors.teal : null,
              ),
              onPressed: () async {},
            ),
          if (profile != null && profile.email.isNotEmpty)
            InfoCard(
              text: isValid ? profile.email : "",
              icon: Icon(
                Icons.email,
                color: isValid ? Colors.teal : null,
              ),
              onPressed: () async {},
            ),
          if (profile != null && profile.birthday != null)
            InfoCard(
              text: isValid
                  ? DateFormat('dd/MM/yyyy').format(profile.birthday!)
                  : "",
              icon: Icon(
                Icons.cake,
                color: isValid ? Colors.teal : null,
              ),
              onPressed: () async {},
            ),
          if (profile != null && profile.zone.isNotEmpty)
            InfoCard(
              text: isValid
                  ? profile.address.isEmpty
                      ? profile.zone
                      : profile.getAllAddress()
                  : "",
              icon: Icon(
                Icons.location_city,
                color: isValid ? Colors.teal : null,
              ),
              onPressed: () async {},
            ),
        ],
      ),
    );
  }

  AsyncWidgetBuilder<A> getProfileBuilder<A>() {
    var builder = (BuildContext context, AsyncSnapshot<A> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return createPage(
            context,
            EmptyDataSearcherResult(
              child: Loading.fromText(
                  key: key, text: "Cargando perfil de usuario..."),
            ));
      }
      if (isDone(snapshot)) {
        return createPage(
            context, createWidgetFromProfile(snapshot.data as ProfileModel));
      } else if (isError(snapshot)) {
        //final fail = FailureExtractor.message(snapshot.data as dartz.Left);
        return createPage(context, createWidgetFromProfile(null));
      }
      return Loading.fromText(key: key, text: "Cargando perfil de usuario...");
    };
    return builder;
  }

  bool isDone(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
        snapshot.hasData &&
        snapshot.data != null &&
        snapshot.data is ProfileModel;
  }

  bool isError(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data == null ||
        snapshot.error != null ||
        snapshot.data is Failure;
  }

  _redirectHandle(context) async {
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    final session = service?.getUserSession();
    if (session != null && await session.isValid()) {
      ProfileModel? profile = session.getBy<ProfileModel>("profile");
      return Future.value(profile);
    }
    return Future.value(
        AuthenticationFailure(message: "Usuario sin autenticar."));
  }
}
