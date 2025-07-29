// ignore_for_file: must_be_immutable, prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/globlal_constants.dart';
import '../../../../app/core/config/assets.dart';
import '../../../../app/core/config/errors/errors.dart';
import '../../../../app/core/services/manager_authorization_service.dart';
import '../../../../app/core/services/paths_service.dart';
import '../../../../app/core/services/user_session.dart';
import '../../../../app/modules/home/controllers/home_controller.dart';
import '../../../../app/modules/home/domain/models/notify_model.dart';
import '../../../../app/modules/security/domain/models/profile_model.dart';
import '../../../../app/widgets/bar/custom_app_bar.dart';
import '../../../../app/widgets/images/background_image.dart';
import '../../../../app/widgets/layout/card/empty_card.dart';
import '../../../../app/widgets/panel/custom_empty_data_search.dart';
import '../../../../app/widgets/promise/custom_future_builder.dart';
import '../../../../app/widgets/utils/loading.dart';

class UserNotificationsView extends GetResponsiveView<HomeController> {
  late NotifyList<NotifyModel> notifications;

  UserNotificationsView({
    Key? key,
  }) : super(key: key) {
    notifications = NotifyList.fromJson({});
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _redirectHandle(context),
      builder: (_, __) => getUserNotificationsBuilder()(_, __),
      context: context,
    );
  }

  createNotifyContainer() {}

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
            title: Text('Mis notificaciones'),
            backgroundColor: Color(0xFF00b1a4),
          ),
          body: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(color: Colors.teal),
            ),
            child: SafeArea(
              minimum: EdgeInsets.only(top: 30),
              child: body,
            ),
          ),
        )
      ],
    );
  }

  createWidgetFromNotifications(ProfileModel? profile) {
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
                : "Notificaciones del usuario",
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
              text: "Usted no tiene notificaciones.",
              margin: EdgeInsets.only(top: 100),
              onPressed: () {},
            ),
          //Cards
          /*if (profile != null && profile.phoneNumber.isNotEmpty)
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
          if (profile != null && profile.zone.isNotEmpty)
            InfoCard(
              text: isValid ? profile.zone : "",
              icon: Icon(
                Icons.location_city,
                color: isValid ? Colors.teal : null,
              ),
              onPressed: () async {},
            ),
          if (isValid && profile.email.isNotEmpty)
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
              text: isValid ? profile.birthday!.toIso8601String() : "",
              icon: Icon(
                Icons.cake,
                color: isValid ? Colors.teal : null,
              ),
              onPressed: () async {},
            ),*/
        ],
      ),
    );
  }

  AsyncWidgetBuilder<A> getUserNotificationsBuilder<A>() {
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
        return createPage(context,
            createWidgetFromNotifications(snapshot.data as ProfileModel));
      } else if (isError(snapshot)) {
        //final fail = FailureExtractor.message(snapshot.data as dartz.Left);
        return createPage(context, createWidgetFromNotifications(null));
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
    UserSession? session = service?.getUserSession();
    if (session != null && await session.isValid(refreshIfExpired: true)) {
      ProfileModel? profile = session.getBy<ProfileModel>("profile");
      return Future.value(profile);
    }
    return Future.value(
        AuthenticationFailure(message: "Usuario sin autenticar."));
  }
}
