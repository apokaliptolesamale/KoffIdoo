// ignore_for_file: must_call_super, non_constant_identifier_names, prefer_function_declarations_over_variables, unused_element

/*

generic abstraction for get Network information before execute any action
that need netwoks resources. It's our recomendation the implementation of this contract
to prevent exceptions on any layer of the architecture. 

*/

import 'dart:async';
import 'dart:io';

//import 'package:connectivity/connectivity.dart';
//import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '/app/core/cache/future_cache.dart';
import '/app/core/config/app_config.dart';
import '/globlal_constants.dart';
import '../../../app/core/interfaces/router.dart';
import '../../../app/core/services/codes_app_service.dart';
import '../../../app/core/services/logger_service.dart';
import '../../../app/core/services/manager_authorization_service.dart';
import '../../../app/core/services/paths_service.dart';

class NetworkBinding extends Bindings {
  final NetworkInfo networkInfo = NetworkInfoImpl.instance;

  NetworkBinding() {
    dependencies();
  }
  // dependence injection attach our class.
  @override
  void dependencies() {
    Get.lazyPut<NetworkInfo>(() => networkInfo);
    Get.lazyPut<NetworkManager>(() => networkInfo.networkManager);
  }
}

class NetworkClient extends http.BaseClient {
  final http.Client _httpClient;
  final Duration timeout;

  NetworkClient({
    http.Client? httpClient,
    this.timeout = const Duration(seconds: 30),
  }) : _httpClient = httpClient ?? http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // wait for result between two Futures (the one that is reached first) in silent mode (no throw exception)
    _Either<http.StreamedResponse, Exception> result = await Future.any([
      Future.delayed(
          timeout,
          () => _Either.Right(
                TimeoutException(
                    'Client connection timeout after ${timeout.inMilliseconds} ms.'),
              )),
      Future(() async {
        try {
          return _Either.Left(await _httpClient.send(request));
        } on Exception catch (e) {
          return _Either.Right(e);
        }
      })
    ]);

    // this code is reached only for first Future response,
    // the second Future is ignorated and does not reach this point
    if (result.right != null) {
      throw result.right!;
    }

    return result.left!;
  }
}

abstract class NetworkInfo {
  NetworkStatus status = NetworkStatus.disconected;

  NetworkManager networkManager = NetworkManager();
  Duration get getTimeOut;
  Future<dynamic> getContent(String url);
  Future<bool> hasConnection(String url);
  /*Future<bool> isConnected() {
    return Future.value(status == NetworkStatus.conected);
  }*/
  Future<bool> isConnected();
  NetworkInfo setTimeOut(Duration timeOut);
}

class NetworkInfoImpl implements NetworkInfo {
  static final NetworkInfo instance = !Get.isRegistered()
      ? NetworkInfoImpl._internal(networkManager: NetworkManager())
      : Get.find();

  @override
  NetworkStatus status = NetworkStatus.disconected;
  @override
  NetworkManager networkManager;

  bool _isConnectionSuccessful = false;

  Duration? _timeOut;

  NetworkInfoImpl._internal({required this.networkManager}) {
    if (!Get.isRegistered<NetworkInfoImpl>()) Get.lazyPut(() => this);
  }

  @override
  Duration get getTimeOut => _timeOut ?? Duration(seconds: 30);

  /*NetworkInfoImpl({required this.networkManager}) {
    if (!Get.isRegistered<NetworkInfoImpl>()) Get.lazyPut(() => this);
    _checkConnection();
  }*/

  @override
  Future<dynamic> getContent(String url) async {
    try {
      log("Intentando conectar a:$url");
      final result = await http.get(Uri.parse(url));

      log("getContent -> Status Code:${result.statusCode}");
      return result.statusCode == 200
          ? result.body
          : throw Exception(
              "Error de conexión: StatusCode=${result.statusCode}");
    } catch (e) {
      log("Sin conexión a $url. Detalles del error:\n${e.toString()}");
      return Future.value(null);
    }
  }

  @override
  Future<bool> hasConnection(String url) async {
    try {
      int type = await networkManager.GetConnectionType();
      _isConnectionSuccessful = await _tryConnectionFrom(url);
      log("Tipo de conexión:$type");
      status = ((type == 1 || type == 2) && _isConnectionSuccessful)
          ? NetworkStatus.conected
          : NetworkStatus.disconected;
      return Future.value(status == NetworkStatus.conected);
    } catch (e) {
      log("Sin conexión a $url. Detalles del error:\n${e.toString()}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> isConnected() => _checkConnection();

  @override
  setTimeOut(Duration timeOut) {
    _timeOut = timeOut;
    return this;
  }

  Future<bool> _checkConnection() async {
    String checkUrl = "https://www.google.com.cu";
    if (ConfigApp.getInstance.modelConfig != null) {
      if (!ConfigApp.getInstance.modelConfig!.useTestConnection) {
        log("Se devolverá 'true' en el chequeo de conexión por configuración pero no se asegura si hay conexión de red o no");
        return true;
      } else {
        checkUrl = ConfigApp.getInstance.modelConfig!.urlConnectionTest;
      }
    }
    final response = FutureCache.instance.add(
      key: "networkManager.GetConnectionType()",
      future: () {
        return networkManager.GetConnectionType();
      },
    );
    int? type = await response;
    try {
      _isConnectionSuccessful = await _tryConnectionFrom(checkUrl);
      log("Tipo de conexión:$type");
      status = ((type == 1 || type == 2) && _isConnectionSuccessful)
          ? NetworkStatus.conected
          : NetworkStatus.disconected;
    } on Exception catch (e) {
      status = NetworkStatus.disconected;
      log(e.toString());
    }
    return Future.value(status == NetworkStatus.conected);
  }

  Future<bool> _tryConnectionFrom(String url) async {
    String lastUrl = "";
    try {
      //final authorizationUrl = Uri.parse(url);
      final List<String> sites = [url];
      _isConnectionSuccessful = false;
      status = NetworkStatus.checking;
      _timeOut = getTimeOut;
      NetworkClient networkClient = NetworkClient(
        httpClient: http.Client(),
        timeout: _timeOut!,
      );

      for (var site in sites) {
        log("Tring Connecting to: $site");
        lastUrl = site;
        final response = FutureCache.instance.add(
          key: "networkClient.get(Uri.parse(site))",
          future: () {
            return networkClient.get(Uri.parse(lastUrl = site));
          },
        );
        final result = await response;
        log("_tryConnectionFrom -> Status Code:${result != null ? result.statusCode : 'Error en la respuesta...'}");
        _isConnectionSuccessful = result != null && result.statusCode == 200;
      }
    } on SocketException {
      log("Error accediendo a dirección:$lastUrl");
      _isConnectionSuccessful = false;
    } on TimeoutException catch (ex) {
      log("Tiempo exedido accediendo a dirección:$lastUrl. Detalles del error:\n${ex.message}Tiempo:\n${ex.duration}");
      _isConnectionSuccessful = false;
    }
    return Future.value(_isConnectionSuccessful);
  }

  String _urlLogin() {
    final iS = ManagerAuthorizationService().get(defaultIdpKey);
    String uri =
        '${PathsService.identityAuthorizationEndpoint}?response_type=code';
    uri = '$uri&client_id=${CodesAppServices.clientId}&scope=openid';
    uri = '$uri&redirect_uri=${Router.redirectUri('/static.html')}';
    uri =
        '$uri&code_challange=${iS != null ? iS.read(key: 'codeChallenge') : ""}}';
    uri = '$uri&code_challange_method=S256';
    return uri;
  }
}

class NetworkManager extends GetxController {
  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  int connectionType = 0;
  //Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();

  //Stream to keep listening to network change state
  late StreamSubscription _streamSubscription;
  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<int> GetConnectionType() async {
    ConnectivityResult? connectivityResult;
    try {
      //connectivityResult = await (Connectivity().checkConnectivity());
      if (Platform.isAndroid || kIsWeb) {
        connectivityResult = await (_connectivity.checkConnectivity());
      } else if (Platform.isIOS || Platform.isLinux || Platform.isWindows) {}
    } on PlatformException catch (e) {
      log(e);
    }
    return _updateState(connectivityResult!);
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription.cancel();
  }

  @override
  void onInit() {
    GetConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  int _updateState(ConnectivityResult? result) {
    connectionType = 0;
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType = 1;
        log("Conexión por Wifi");
        update();
        break;
      case ConnectivityResult.mobile:
        log("Conexión por Datos móviles");
        connectionType = 2;
        update();
        break;
      case ConnectivityResult.none:
        log("Sin conexión");
        connectionType = 0;
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        connectionType = 0;
        break;
    }
    return connectionType;
  }
}

enum NetworkStatus { conected, disconected, checking }

class _Either<L, R> {
  final L? left;
  final R? right;

  _Either(this.left, this.right);
  _Either.Left(L this.left) : right = null;
  _Either.Right(R this.right) : left = null;
}
