// ignore_for_file: must_be_immutable, prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart' as getit;

import '/app/core/config/assets.dart';
import '/globlal_constants.dart';
import '../../../app/core/interfaces/get_provider.dart';
import '../../../app/core/interfaces/use_case.dart';
import '../../../app/core/services/logger_service.dart';
import '../../../app/core/services/manager_authorization_service.dart';
import '../../../app/core/services/paths_service.dart';
import '../../../app/core/services/user_session.dart';
import '../../../app/modules/security/bindings/security_binding.dart';
import '../../../app/modules/security/controllers/security_controller.dart';
import '../../../app/modules/security/domain/models/profile_model.dart';
import '../../../app/modules/security/domain/usecases/get_profile_usecase.dart';
import '../../../app/widgets/images/custom_image_source.dart';
import '../../../app/widgets/promise/custom_future_builder.dart';
import '../../core/config/app_config.dart';
import '../../core/helpers/functions.dart';
import '../../routes/app_routes.dart';

Widget _profileImagePlaceholder(BuildContext context) {
  return Image.asset(Assets.ASSETS_IMAGES_ICONS_APP_CUENTA_PNG.getPath);
}

class UserProfileAvatar extends StatelessWidget {
  late UseCase usecase;
  late CustomFutureBuilder fututeBuilder;
  String? user;
  EdgeInsetsGeometry? margin;
  String? avatarUrl;
  double? radius;
  bool remoteLoaded = false;

  Map<String, Image?> imageDict = {};

  final controller = getit.Get.find<SecurityController>();

  UserProfileAvatar({
    Key? key,
    this.user,
    this.avatarUrl,
    this.margin,
    this.radius = 16,
  }) : super(key: key) {
    SecurityBinding().dependencies();
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    UserSession? usession = service?.getUserSession();
    ProfileModel? profile = usession?.getBy<ProfileModel>(
      "profile",
      converter: (data, key) {
        return ProfileModel.converter(data, key);
      },
    );
    user = profile?.userName;
    if ((avatarUrl == null || avatarUrl == "") && profile != null) {
      avatarUrl =
          "${PathsService.mediaHost}images/user/avatar/${profile.userName}.png";
    } else {
      // user = ASSETS_IMAGES_ICONS_APP_CUENTA_PNG;
      if ((avatarUrl == null || avatarUrl == "") && profile == null) {
        avatarUrl = ASSETS_IMAGES_ICONS_APP_CUENTA_PNG;
      }
    }
    log("Cargando perfil del usuario: ${user ?? 'Desconocido'} desde $avatarUrl");
  }

  @override
  Widget build(BuildContext context) =>
      rebuild(context, usecase = controller.getProfileUseCase);

  Future<Image?> fetchImage() async {
    if (imageDict[user] != null) {
      return imageDict[user];
    } else {
      //final header = "";
      final provider = GetDefautlProviderImpl();
      final response = await provider.get(avatarUrl!);
      if (response.statusCode == 200 && user != null) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        Image pic = Image.memory(response.body);
        imageDict[user!] = pic;
        return pic;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        return null;
      }
    }
  }

  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    if (uc is GetProfileUseCase) return getProfileBuilder();
    return getProfileBuilder();
  }

  Future<T> getFutureByUseCase<T>(UseCase uc) async {
    final result = controller.getFutureByUseCase<T>(uc);
    return result;
  }

  AsyncWidgetBuilder<dynamic> getProfileBuilder() {
    var builder = (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      final isremote = isUrlRemote(avatarUrl!);
      //
      var clipRRect = ClipRRect(
        child: isremote == true
            ? CustomImageResource(
                context: context,
                url: avatarUrl!,
              )
            : Image.asset(Assets.ASSETS_IMAGES_ICONS_APP_CUENTA_PNG
                .getPath), // CustomImageResource.buildFromUrl(avatarUrl),
        borderRadius: BorderRadius.circular(50.0),
      );

      return PopupMenuButton<String>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onSelected: (value) async {
          if (Routes.getInstance.pageExists(value)) {
            getit.Get.toNamed(Routes.getInstance.getPath(value));
            log("Enrutando $value hacia ${Routes.getInstance.getPath(value)}");
          } else {
            if (value == "END_SESSION") {
              final service = ManagerAuthorizationService().get(defaultIdpKey);
              if (service != null) {
                await service.endSession();
                String loginRoute =
                    ConfigApp.getInstance.configModel!.loginRoute;
                getit.Get.toNamed(Routes.getInstance.getPath(loginRoute));
              }
            }
            if (value == "USER_THEME_DATA") {
              controller.selectTheme(context);
            } else {
              log("Ruta $value sin implementar...");
            }
          }
        },
        icon: CircleAvatar(
          radius: radius,
          child: clipRRect,
        ),
        itemBuilder: (context) => [
          PopupMenuItem<String>(
            child: Row(
              children: [
                Icon(Icons.edit_attributes, color: Colors.teal),
                SizedBox(width: 8),
                Text("Perfil"),
              ],
            ),
            value: "SECURITY_PROFILE",
          ),
          PopupMenuItem<String>(
            child: Row(
              children: [
                Icon(Icons.notifications, color: Colors.teal),
                SizedBox(width: 8),
                Text("Notificaciones"),
              ],
            ),
            value: "SECURITY_USER_NOTIFICATIONS",
          ),
          PopupMenuItem<String>(
            child: Row(
              children: [
                Icon(
                  Icons.color_lens,
                  color: Colors.teal,
                ),
                SizedBox(width: 8),
                Text("Temas"),
              ],
            ),
            value: "USER_THEME_DATA",
          ),
          PopupMenuDivider(
            height: 10,
          ),
          PopupMenuItem<String>(
            child: Row(
              children: [
                Icon(Icons.logout, color: Colors.teal),
                SizedBox(width: 8),
                Text("Salir"),
              ],
            ),
            value: "END_SESSION",
          ),
        ],
      );
    };
    return builder;
  }

  Widget rebuild(BuildContext context, UseCase uc) =>
      fututeBuilder = CustomFutureBuilder(
        future: getFutureByUseCase(uc),
        builder: getBuilderByUseCase(uc),
        context: context,
      );

  Future<Widget> _displayProfilePic() async {
    if (avatarUrl != null) {
      Image? profilPic = await fetchImage();
      return profilPic ??
          Image.asset(Assets.ASSETS_IMAGES_ICONS_APP_CUENTA_PNG.getPath);
    }
    return Image.asset(Assets.ASSETS_IMAGES_ICONS_APP_CUENTA_PNG.getPath);
  }
}
