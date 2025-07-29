// ignore_for_file: unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:warranty/app/core/services/auth/lib/flutter_appauth_platform_interface.dart';

import '../../../app/core/services/identity_authorization_service.dart';
import '../../../app/core/services/local_storage.dart';
import '../../../app/core/services/logger_service.dart';
import '../config/app_config.dart';

class UserSession {
  String? _codeVerifier;
  String _nonce = "";
  String? _authorizationCode;
  String? _refreshToken;
  String? _accessToken;
  String? _idToken;
  String? _tokenType;
  String? _userName;

  int _secoundToExpire = 0;

  late String _prefijo;

  final IdentityAuthorizationService authorizationService;

  DateTime? _accessTokenExpirationDateTime, _refreshTokenExpirationDateTime;

  Map<String, dynamic>? _authorizationAdditionalParameters;

  Map<String, dynamic>? _tokenAdditionalParameters;

  final Map<String, dynamic> _data = {};

  UserSession({
    required this.authorizationService,
  }) {
    _prefijo = authorizationService.getPrefijo;
    getCreateNonce().then((value) => _nonce = value);
  }

  String? get getAccessToken => _accessToken;
  String? get getAuthorizationCode => _authorizationCode;
  String? get getCodeVerifier => _codeVerifier;
  DateTime? get getExpirationDate => _accessTokenExpirationDateTime;
  String get getIdToken => _idToken ?? "";
  String get getNonce => _nonce;
  String? get getRefreshToken => _refreshToken;
  DateTime? get getrefreshTokenExpirationDate =>
      _refreshTokenExpirationDateTime;

  FutureOr<DateTime>? get getRefreshTokenExpirationTime =>
      _refreshTokenExpirationDateTime;
  int get getSecoundsToExpire => _secoundToExpire;

  String? get getToken => _idToken;

  String? get getTokenType => _tokenType;

  String? get getUserName => _userName;
  addAll(Map<String, dynamic> other) => _data.addAll(other);

  addData(String key, dynamic value, {bool replace = false}) async {
    !replace
        ? _data.putIfAbsent("$_prefijo$key", () => value)
        : _data["$_prefijo$key"] = value;
    return await LocalSecureStorage.storage
        .write("$_prefijo$key", value.toString());
  }

  canRefresh() {
    return (getAccessToken == null) && getRefreshToken != null;
  }

  clearSession() {
    log("For ${authorizationService.key}=> Borrando datos de sessión");
    ConfigApp.onDestroy();
    _clearData(authorizationService.key);
    _data.clear();
    _codeVerifier = null;
    _nonce = "";
    _authorizationCode = null;
    _refreshToken = null;
    _accessToken = null;
    _idToken = null;
    _tokenType = null;
    _userName = null;
    _tokenAdditionalParameters = {};
    _secoundToExpire = 0;
    _refreshTokenExpirationDateTime = null;
    _accessTokenExpirationDateTime = null;
  }

  UserSession decrease(int amount) {
    _secoundToExpire -= amount;
    return this;
  }

  T? getBy<T>(String key,
      {T Function(Map<String, dynamic> data, dynamic key)? converter}) {
    return _data.containsKey("$_prefijo$key") &&
            LocalSecureStorage.storage.hasData("$_prefijo$key")
        ? (_data["$_prefijo$key"] is T
            ? _data["$_prefijo$key"] as T
            : converter != null
                ? converter(_data, "$_prefijo$key")
                : null)
        : null;
  }

  String? getByAsString(String key, {String? callback}) {
    if (_data.containsKey("$_prefijo$key") &&
        LocalSecureStorage.storage.hasData("$_prefijo$key") &&
        _data["$_prefijo$key"] != null) {
      return _data["$_prefijo$key"].toString();
    }
    return null;
  }

  Future<String> getCreateNonce() async {
    _nonce = await LocalSecureStorage.storage.read('${_prefijo}nonce') ?? "";
    if (_nonce.isEmpty) {
      final Random random = Random.secure();
      _nonce =
          base64Url.encode(List<int>.generate(16, (_) => random.nextInt(256)));
    }
    return Future.value(_nonce);
  }

  bool hasExpired({
    bool autoClean = false,
  }) {
    final now = DateTime.now();
    if (_accessTokenExpirationDateTime == null || _secoundToExpire <= 0) {
      if (autoClean) {
        clearSession();
      }
      return true;
    }
    final bool isExpired = _accessTokenExpirationDateTime!.isBefore(now) ||
        _accessTokenExpirationDateTime == now;
    if (isExpired && autoClean) {
      clearSession();
    }
    return isExpired;
  }

  Future<bool> isValid({
    bool refreshIfExpired = true,
  }) =>
      authorizationService.isValid(refreshIfExpired: refreshIfExpired);

  bool loadAuthorizationResponse(AuthorizationResponse response) {
    _codeVerifier = response.codeVerifier;
    _nonce = response.nonce ?? "";
    _authorizationCode = response.authorizationCode;
    _authorizationAdditionalParameters =
        response.authorizationAdditionalParameters;
    return true;
  }

  bool loadAuthorizationTokenResponse(AuthorizationTokenResponse response) {
    _authorizationAdditionalParameters =
        response.authorizationAdditionalParameters;
    _accessToken = response.accessToken;
    _idToken = response.idToken;
    _accessTokenExpirationDateTime = response.accessTokenExpirationDateTime;
    _refreshToken = response.refreshToken;
    _tokenType = response.tokenType;
    _tokenAdditionalParameters = response.tokenAdditionalParameters;
    return true;
  }

  remove(String? key) async {
    _data.remove("$_prefijo$key");
    if ("$_prefijo$key".isNotEmpty) {
      await LocalSecureStorage.storage.delete("$_prefijo$key");
    }
    return true;
  }

  removeWhere(bool Function(String, dynamic) test) {
    _data.removeWhere(test);
    return true;
  }

  UserSession set<T>(String key, T data,
      {required String Function(T data) converter}) {
    _data["$_prefijo$key"] = data;
    LocalSecureStorage.storage.write(key, converter(data));
    return this;
  }

  setAccessToken(String? token) => _accessToken = token;

  setAuthorizationCode(String? code) => _authorizationCode = code;

  setCodeVerifier(String? code) => _codeVerifier = code;

  setExpirationDate(DateTime? expirationDateTime) {
    _accessTokenExpirationDateTime = expirationDateTime;
    if (getSecoundsToExpire <= 0 && expirationDateTime != null) {
      setSecoundsToExpire(
          expirationDateTime.difference(DateTime.now()).inSeconds.abs());
    }
  }

  setIdToken(String? token) => _idToken = token;

  setNonce(String nonce) => _nonce = nonce;

  setRefreshToken(String? token) => _refreshToken = token;

  UserSession setRefreshTokenExpirationTime(DateTime time) {
    _refreshTokenExpirationDateTime = time;
    return this;
  }

  UserSession setSecoundsToExpire(int secounds) {
    _secoundToExpire = secounds;
    return this;
  }

  setToken(String? token) => _idToken = token;

  setTokenType(String? type) => _tokenType = type;

  setUserName(String? user) => _userName = user;

  Map toJson() {
    return {
      "_secoundToExpire": _secoundToExpire,
      "_codeVerifier": _codeVerifier,
      "_nonce": _nonce,
      "_authorizationCode": _authorizationCode,
      "_refreshToken": _refreshToken,
      "_accessToken": _accessToken,
      "_idToken": _idToken,
      "_tokenType": _tokenType,
      "_accessTokenExpirationDateTime": _accessTokenExpirationDateTime != null
          ? _accessTokenExpirationDateTime!.toString()
          : "",
      "_refreshTokenExpirationDateTime": _refreshTokenExpirationDateTime != null
          ? _refreshTokenExpirationDateTime!.toString()
          : "",
      "_authorizationAdditionalParameters":
          _authorizationAdditionalParameters != null
              ? _authorizationAdditionalParameters.toString()
              : {},
      "_data": _data.toString(),
      "_scopes": authorizationService.getScopes
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }

  _clearData(String key) {
    LocalSecureStorage.storage.removeWhereKeyStartWith(key);
  }
}
