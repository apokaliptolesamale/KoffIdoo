// ignore_for_file: prefer_function_declarations_over_variables, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
//import 'package:native_flutter_proxy/custom_proxy.dart';
//import 'package:native_flutter_proxy/native_proxy_reader.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:pointycastle/asymmetric/api.dart';

import '/app/core/config/Permission.dart';
import '/app/core/config/api_path.dart';
import '/app/core/config/assets.dart';
import '/app/core/helpers/functions.dart';
import '/app/core/interfaces/module.dart';
import '/app/core/services/api_service.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/core/services/network_manager_service.dart';
import '/app/core/services/ssl_tls_service.dart';
import '/app/core/services/webservice.dart';
import '/app/modules/config/bindings/config_binding.dart';
import '/app/modules/config/domain/models/config_model.dart';
import '/app/modules/config/domain/usecases/list_config_usecase.dart';
import '/app/modules/security/domain/models/profile_model.dart';
import '/globlal_constants.dart';
import '../../routes/app_routes.dart';
import '../services/store_service.dart';

typedef DirectoryEntryCollector = Stream<FileSystemEntity> Function(
    Future<FileSystemEntity> futureEntity);

class ConfigApp {
  static List<DirectoryEntryCollector>? _directoryCollectors;

  static ConfigApp? _instance;

  static ConfigApp get getInstance => _instance ?? ConfigApp._internal();

  final List<Module> _modules = [];
  String applicationId = globalApplicationId;
  final Map<String, dynamic> _conf;
  bool appIsResizing = false;
  bool isAndroid = GetPlatform.isAndroid;
  bool isIos = GetPlatform.isIOS;
  bool isMacOs = GetPlatform.isMacOS;
  bool isWindows = GetPlatform.isWindows;
  bool isLinux = GetPlatform.isLinux;
  bool isFuchsia = GetPlatform.isFuchsia;
  bool isMobile = GetPlatform.isMobile;
  bool isWeb = GetPlatform.isWeb;
  bool isDesktop = GetPlatform.isDesktop;
  double screenHeight = Get.height;

  double screenWidth = Get.width;
  bool isTablet = false;
  bool isPhone = false;
  bool isLandScape = false;

  bool isPortrait = false;

  String proxy = "";

  String? logLevel = "all";

  BuildContext? context;

  ConfigModel? modelConfig;

  ConfigApp._internal() : _conf = {} {
    _instance ??= this;
    log("Iniciando instancia de configuración global...");
    //modelConfig = modelConfig ?? ConfigModel.getFromLocalStorage();
  }

  ConfigModel? get configModel => modelConfig;

  Directory get getCurrentDirectory => Directory.current;

  //final Directory root = findRoot(getApplicationDocumentsDirectory());

  Directory get getSystemTempDirectory => Directory.systemTemp;

  add(String key, dynamic value) {
    log("Registrando configuración global <key=$key,value=$value>.");
    _conf.addIf(!containsKey(key), key, value);
  }

  addIf(dynamic condition, String key, dynamic value) {
    _conf.addIf(condition, key, value);
  }

  containsKey(String key) {
    return _conf.containsKey(key);
  }

  List<Module> getApplicationModules() {
    return _modules;
  }

  Future<ConfigModel> getConfigModel() async {
    if (modelConfig == null) {
      final result = ConfigModel.getFromAssets("./models/config.json");
      result.then((value) async {
        modelConfig = value;
      });
    }
    modelConfig = modelConfig ?? ConfigModel.getFromLocalStorage();
    return Future.value(modelConfig);
  }

  Map<String, dynamic> getConfigModelAsMap() {
    return ConfigApp.getInstance.modelConfig != null
        ? ConfigApp.getInstance.modelConfig!.toJson()
        : {};
  }

  ConfigModel getConfigModelSync() {
    String contents = File(ASSETS_MODELS_CONFIG_JSON).readAsStringSync();
    final model = modelConfig ?? ConfigModel.fromStringJson(contents);
    return model;
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');
    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  Future<String> getProxy() async {
    if (modelConfig != null) {
      proxy = modelConfig!.useSystemProxy == false
          ? modelConfig!.localProxy
          : await getSystemProxy();
    }
    return Future.value(proxy);
  }

  Future<String> getSystemProxy() async {
    //bool enabled = false;
    String host = "";
    int port = -1;
    /* try {
      ProxySetting settings = await NativeProxyReader.proxySetting;
      enabled = settings.enabled;
      host = settings.host ?? "localhost";
      port = settings.port ?? 80;
    } catch (e) {
      log(e);
    }
    if (enabled && host != "localhost") {
      final _proxy = CustomProxy(ipAddress: host, port: port);
      _proxy.enable();
      log("proxy enabled");
    }*/
    return "http://$host:$port";
  }

  Future<Directory> getTemporaryDirectory() => pp.getTemporaryDirectory();

  Type? getValue<Type>(String key) {
    if (containsKey(key)) return _conf[key] as Type;
    return null;
  }

  Future<bool> hasValidProfile() async {
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    if (service != null) {
      ProfileModel? profile =
          (service.getUserSession()).getBy<ProfileModel>("profile");
      return profile != null ? profile.hasValidProfile() : false;
    }
    return false;
  }

  Future<List<Module>> initApplicationModules() async {
    log("Inicializando módulos de la aplicación...");
    return Future.value(_modules);
  }

  loadFromAssets(BuildContext context, String text) async {
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    return json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith(text));
  }

  loadProxySetting() async {}

  //
  Future<ConfigApp> onInit() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      // Maneja la excepción no controlada aquí.
      log('Unhandled exception: $details');
    };
    //Registro global de propiedades con GetX sencillo pero efectivo
    //Get.lazyPut(() => StoreService());
    //Clean Flutter caches images
    final sysStore = StoreService().getStore("system");
    imageCache.clear();
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
      var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController =
            AndroidServiceWorkerController.instance();

        await serviceWorkerController
            .setServiceWorkerClient(AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            return null;
          },
        ));
      }
    }

    /*
     For Flutter and Self-Signed SSL (REST): See https://stackoverflow.com/questions/71138496/how-to-accept-bad-certificates-on-web-client
    */
    SecurityContext security = SecurityContext(
      withTrustedRoots: true,
    );

    final rootCA = await rootBundle.load(ASSETS_RAW_ENZONA_NET_CRT_CRT);
    final deviceCert = await rootBundle.load(ASSETS_RAW_ENZONA_NET_CRT_CRT);

    security.useCertificateChainBytes(deviceCert.buffer.asUint8List());
    //security.usePrivateKeyBytes(privateKey.buffer.asUint8List());
    security.setTrustedCertificatesBytes(rootCA.buffer.asUint8List());
    SecurityContext.defaultContext
        .useCertificateChainBytes(deviceCert.buffer.asUint8List());
    SecurityContext.defaultContext
        .setTrustedCertificatesBytes(rootCA.buffer.asUint8List());

    //security.usePrivateKeyBytes(keyCertificate);
    SslTlsService.getInstance.addTrustedCertificate([
      TrustedCertificate(rootCA.buffer.asInt8List()), //CA
      /*TrustedCertificate(deviceCert.buffer.asInt8List()), //Client
      TrustedCertificate((await rootBundle.load(ASSETS_RAW_ENZONA_NET_KEY_KEY))
          .buffer
          .asInt8List()), //Key*/
    ]);

    HttpOverrides.global = MyHttpOverrides(
      proxyUrl: await getProxy(),
      context: security,
      certs: await SslTlsService.getInstance.getTrustedCertificates(),
    );

    //final config = await ConfigApp.getInstance.getConfigModel();
    log("Iniciando dependencias locales...");
    ConfigBinding();
    log("Dependencias locales iniciadas satisfactoriamente.");

    final result = await ListConfig(Get.find()).call(null);
    result.fold((error) {
      log("Ha currido un error al cargar configuraciones globales del sistema:${error.getMessage()}");
    }, (list) async {
      log("Se ha iniciado correctamente la configuración global de sistema...");
      if (list.getList().isNotEmpty) {
        ConfigModel conf = list.getList().elementAt(0) as ConfigModel;
        if (conf.design != null && !conf.design!.isValidId()) {
          final String designConfig =
              await readFileFromAssets(ASSETS_MODELS_DESIGN_JSON);
          Map designs = json.decode(designConfig);
          if (designs.containsKey("design") && designs["design"] is List) {
            conf.loadDesignFromMap((designs["design"] as List).elementAt(0));
          }
        }
        //conf = await conf.loadDesignFromAssets(ASSETS_MODELS_DESIGN_JSON);
        ConfigApp.getInstance.logLevel = conf.logLevel;
        if (await ConfigApp.getInstance.hasValidProfile()) {
          if (conf.homePageRoute.isNotEmpty) {
            Routes.getInstance.replaceRoute(
                Routes.getInstance.getPath("APP_HOME"), conf.homePageRoute);
          }
          conf.loginRoute = Routes.getInstance.getPath("APP_HOME");
        }
        Logger.getInstance.init();
        getInstance.applicationId = conf.app.applicationId;
        conf.save();
        ConfigApp.getInstance.modelConfig = modelConfig = conf;
        ManagerAuthorizationService().loadIdentityServices();
        final homePageRoute = ConfigApp.getInstance.configModel!.homePageRoute;
        final loginRoute = ConfigApp.getInstance.configModel!.loginRoute;
        final indexRoute = ConfigApp.getInstance.configModel!.indexRoute;
        sysStore.add("homePageRoute", homePageRoute);
        sysStore.add("loginRoute", loginRoute);
        sysStore.add("indexRoute", indexRoute);
        sysStore.add("defaultIdpKey", defaultIdpKey);

        add("sys_config", conf);
        log("Configuración salvada en LocalStorage");
      }
    });
    await initApplicationModules();
    ApiService api = ApiService.getInstance;
    api.registry(ApiPath.nomenclatorContext, "nomenclator/banks");
    api.registry(ApiPath.nomenclatorContext, "nomenclator/coordinates");
    add("networkStatus", await NetworkManagerService.instance.isConnected());
    Get.lazyReplace(() => sysStore);
    return Future.value(this);
  }

  onLicenseRegistry(List<String> packages, String licenseFile) {
    LicenseRegistry.addLicense(() async* {
      final license =
          await rootBundle.loadString(licenseFile /*'google_fonts/OFL.txt'*/);
      yield LicenseEntryWithLineBreaks(packages /*['google_fonts']*/, license);
    });
  }

  S parseKeyFromFile<S>(String keyString) {
    //create a instance of RSA key praser
    RSAKeyParser keyParser = RSAKeyParser();

    //and parse those string keys
    RSAAsymmetricKey key = keyParser.parse(keyString);
    return key as S;
  }

  putIfAbsent(String key, dynamic value) {
    _conf.putIfAbsent(key, value);
  }

  requestPermission() async {
    PermissionStatus permissionResult =
        await PermissionHandler.requestPermission(
            Permissions.WriteExternalStorage);
    if (permissionResult == PermissionStatus.authorized) {
      // code of read or write file in external storage (SD card)
    }
  }

  set(String key, dynamic value) {
    log("Registrando configuración global <key=$key,value=$value>.");
    _conf.addIf(true, key, value);
  }

  ConfigApp setConfigModel(ConfigModel model) {
    modelConfig = model;
    return this;
  }

  static void addDirectory(DirectoryEntryCollector collector) {
    _directoryCollectors ??= <DirectoryEntryCollector>[];
    _directoryCollectors!.add(collector);
  }

  static Directory findRoot(Future<FileSystemEntity> entity) {
    Directory dir = Directory.current;
    addDirectory((futureEntity) async* {
      final Directory parent = await futureEntity.then((value) async {
        final Directory parent = value.parent;
        if (parent.path == value.path) return dir = parent;
        return dir = findRoot(Future.value(parent));
      });
      yield parent;
    });
    return dir;
  }

  static SizeConfig getSize() => SizeConfig();

  static Future<void> onDestroy() async {
    ConfigApp.getInstance._conf.removeWhere((key, value) => key.isNotEmpty);
  }

  static ConfigApp refresh(BuildContext context) {
    getInstance.appIsResizing = false;
    getInstance.isAndroid = GetPlatform.isAndroid;
    getInstance.isIos = GetPlatform.isIOS;
    getInstance.isMacOs = GetPlatform.isMacOS;
    getInstance.isWindows = GetPlatform.isWindows;
    getInstance.isLinux = GetPlatform.isLinux;
    getInstance.isFuchsia = GetPlatform.isFuchsia;
    getInstance.isMobile = GetPlatform.isMobile;
    getInstance.isWeb = GetPlatform.isWeb;
    getInstance.isDesktop = GetPlatform.isDesktop;
    getInstance.screenHeight = Get.height;
    getInstance.screenWidth = Get.width;
    //From context
    getInstance.context = context;
    getInstance.isTablet = context.isTablet;
    getInstance.isPhone = context.isPhone;
    getInstance.isLandScape = context.isLandscape;
    getInstance.isPortrait = context.isPortrait;
    return getInstance;
  }
}

//import 'package:platform/platform.dart' as platform;

class SizeConfig {
  double screenWidth = 0;
  double screenHeight = 0;
  double blockSizeHorizontal = 0;
  double blockSizeVertical = 0;
  double _safeAreaHorizontal = 0;
  double _safeAreaVertical = 0;
  double safeBlockHorizontal = 0;
  double safeBlockVertical = 0;

  SizeConfig init(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    _safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    return this;
  }
}
