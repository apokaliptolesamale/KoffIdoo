// ignore_for_file: avoid_relative_lib_imports

import 'dart:async';
import 'dart:convert';
import 'dart:math';

//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '/app/core/services/auth/lib/flutter_appauth_platform_interface.dart';
import '/app/widgets/dialog/custom_dialog.dart';
import '../../../remote/crypto_master/crypto.dart';
import '../../routes/app_pages.dart';
import '../../widgets/images/background_image.dart';
import '../../widgets/utils/loading.dart';
import '../config/app_config.dart';
import '../config/assets.dart';
import '../helpers/functions.dart';
import '../helpers/widgets.dart';
import '../interfaces/app_page.dart';
import 'store_service.dart';

class CustomFlutterAppAuth {
  late String _clientId;
  late String redirectUri;
  late AuthorizationServiceConfiguration _conf;
  String? _sessionState;
  BuildContext? context;

  CustomDialogBox? box;

  String? _codeVerifier, codeChallenge, _consumerSecret, _authorizationCode;

  late String _authIssuer;

  //
  CustomFlutterAppAuth();

  Future<AuthorizationResponse?> authorize(AuthorizationRequest request) async {
    final AuthorizationResponse authorization = await _getAuthorizationCode();
    _authorizationCode = authorization.authorizationCode;
    if (_authorizationCode == null) return Future.value(null);
    return authorization;
  }

  Future<AuthorizationTokenResponse?> authorizeAndExchangeCode(
      AuthorizationTokenRequest request) async {
    StoreService().getStore("identityStore").flush();
    _codeVerifier = _generateCodeVerifier();
    final AuthorizationResponse authorization = await _getAuthorizationCode();
    _authorizationCode = authorization.authorizationCode;
    if (_authorizationCode == null) return Future.value(null);
    return _parseAuthorizationResponse(
      authorizationResponse: authorization,
    );
  }

  String createNonce({
    int longitud = 16,
  }) =>
      generateNonce(
        longitud: longitud,
      );
  Future<EndSessionResponse> endSession(EndSessionRequest endSessionRequest) {
    return Future.value(EndSessionResponse("state"));
  }

  CustomFlutterAppAuth load({
    required String clientId,
    required String redirectUri,
    required String authorizationEndpoint,
    required String tokenEndpoint,
    required String discoveryUrl,
    required String endSessionEndpoint,
    required String userinfoEndpoint,
    required String authIssuer,
    String source = '',
    String? clientSecret,
  }) {
    _clientId = clientId;
    _authIssuer = authIssuer;
    _consumerSecret = clientSecret;
    this.redirectUri = redirectUri;
    _conf = AuthorizationServiceConfiguration(
      endSessionEndpoint: endSessionEndpoint,
      tokenEndpoint: tokenEndpoint,
      authorizationEndpoint: authorizationEndpoint,
      userinfoEndpoint: userinfoEndpoint,
    );
    return this;
  }

  Future<dynamic>? openInAppWebView(Widget container) async {
    String key = "/identity/login";
    String route = ConfigApp.getInstance.configModel!.loginRoute;
    final page = IdentityLoginAppPageImpl.builder(
      name: key,
      builder: () {
        return container;
      },
    );
    AppPages.addRouteIfAbsent(page);
    Get.to(
      page.page,
      routeName: key,
    );
  }

  Future<TokenResponse> refreshAccessToken(String refreshToken) async {
    final String scope =
        "openid profile email offline_access"; // Especifica el alcance adecuado
    Map body = {
      'grant_type':
          refreshToken.isNotEmpty ? 'refresh_token' : 'client_credentials',
      'client_id': _clientId,
    };
    if (refreshToken.isNotEmpty) {
      body['refresh_token'] = refreshToken;
    }
    if (_codeVerifier != null) {
      body['code_verifier'] = _codeVerifier!;
    }
    if (_sessionState != null) {
      body['session_state'] = _sessionState!;
    }
    if (_authorizationCode != null) {
      body['code'] = _authorizationCode!;
    }
    if (!body.containsKey('code_verifier') &&
        !body.containsKey('session_state') &&
        !body.containsKey('code') &&
        _consumerSecret != null) {
      body['client_secret'] = _consumerSecret!;
    }
    //
    if (refreshToken.isEmpty) {
      body['redirect_uri'] = redirectUri;
      body['scope'] = scope;

      if (_codeVerifier != null) {
        body['code_verifier'] = _codeVerifier!;
      }
      if (_sessionState != null) {
        body['session_state'] = _sessionState!;
      }
      if (_authorizationCode != null) {
        body['code'] = _authorizationCode!;
      }
      if (!body.containsKey('code_verifier') &&
          !body.containsKey('session_state') &&
          !body.containsKey('code') &&
          _consumerSecret != null) {
        body['client_secret'] = _consumerSecret!;
      }
    }

    try {
      if (body.containsKey("refresh_token") &&
          body['refresh_token'].toString().isNotEmpty) {
        body = body..removeWhere((key, value) => key == "client_secret");
      }
      final response = await http.post(
        Uri.parse(_conf.tokenEndpoint),
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        /*final newAccessToken = responseData['access_token'];
        final newRefreshToken = responseData['refresh_token'];
        final expiresIn = responseData['expires_in'];
        // Aquí puedes actualizar el token de acceso y el token de actualización en tu aplicación
        */
        return TokenResponse.fromJson(responseData);
      } else {
        throw Exception(
            'Error al renovar el token de acceso: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  CustomFlutterAppAuth setContext(BuildContext context) {
    this.context = context;
    return this;
  }

  Future<TokenResponse?> token(TokenRequest tokenRequest) async {
    /*if (tokenRequest.authorizationCode == null && _authorizationCode == null) {
      final AuthorizationResponse authorization = await _getAuthorizationCode();
      _authorizationCode = authorization.authorizationCode;
      if (_authorizationCode == null) {
        return Future.value(null);
      }
    }*/
    final Map<String, dynamic> tokenResponse = {};
    final String scope =
        "openid profile email offline_access"; // Especifica el alcance adecuado
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };
    _authorizationCode = tokenRequest.authorizationCode ?? _authorizationCode;
    _codeVerifier = tokenRequest.codeVerifier ?? _codeVerifier;
    String grantType = tokenRequest.grantType ?? 'client_credentials';
    Map<String, String> body = {
      'grant_type': grantType,
      'client_id': _clientId,
      'redirect_uri': redirectUri,
      'scope': scope
    };
    if (_codeVerifier != null) {
      body['code_verifier'] = _codeVerifier!;
    }
    if (_sessionState != null) {
      body['session_state'] = _sessionState!;
    }
    if (_authorizationCode != null) {
      body['code'] = _authorizationCode!;
    }
    if (!body.containsKey('code_verifier') &&
        !body.containsKey('session_state') &&
        !body.containsKey('code') &&
        _consumerSecret != null) {
      if (tokenRequest.refreshToken == null ||
          tokenRequest.refreshToken!.isEmpty) {
        body['client_secret'] = _consumerSecret!;
      } else {
        body = <String, String>{
          'grant_type': 'refresh_token',
          'client_id': _clientId,
          //'client_secret': _consumerSecret!,
          'refresh_token': tokenRequest.refreshToken!,
          'scope': "openid",
        };
        http.Response response = await http.post(
          Uri.parse(_conf.tokenEndpoint),
          headers: headers,
          body: body,
        );
        if (response.statusCode != 200) {
          throw Exception('Failed to retrieve access token:${response.body}');
        }
        final data = json.decode(response.body);
        tokenResponse.addAll(data);
        return TokenResponse.fromJson(tokenResponse);
      }
    }
    http.Response response = await http.post(
      Uri.parse(_conf.tokenEndpoint),
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve access token:${response.body}');
    }

    tokenResponse.addAll(json.decode(response.body));
    _authorizationCode = tokenRequest.authorizationCode ?? _authorizationCode;
    _codeVerifier = tokenRequest.codeVerifier ?? _codeVerifier;
    grantType = tokenRequest.grantType ?? 'client_credentials';
    body = {
      'grant_type': grantType,
      'client_id': _clientId,
      'redirect_uri': redirectUri,
      'scope': scope,
    };
    if (_codeVerifier != null) {
      body['code_verifier'] = _codeVerifier!;
    }
    if (_sessionState != null) {
      body['session_state'] = _sessionState!;
    }
    if (_authorizationCode != null) {
      body['code'] = _authorizationCode!;
    } else {
      body['grant_type'] = grantType;
    }
    if (!body.containsKey('code_verifier') &&
        !body.containsKey('session_state') &&
        !body.containsKey('code') &&
        _consumerSecret != null) {
      body['client_secret'] = _consumerSecret!;
    }
    response = await http.post(
      Uri.parse(_conf.tokenEndpoint),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      tokenResponse.addAll(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get refresh token');
    }
    if (!tokenResponse.containsKey("refresh_token")) {
      body = {
        'grant_type': 'authorization_code',
        'client_id': _clientId,
        'redirect_uri': redirectUri,
        'scope': scope,
      };
      if (_codeVerifier != null) {
        body['code_verifier'] = _codeVerifier!;
      }
      if (_sessionState != null) {
        body['session_state'] = _sessionState!;
      }
      if (_authorizationCode != null) {
        body['code'] = _authorizationCode!;
      }
      if (!body.containsKey('code_verifier') &&
          !body.containsKey('session_state') &&
          !body.containsKey('code') &&
          _consumerSecret != null) {
        body['client_secret'] = _consumerSecret!;
        body['grant_type'] = 'client_credentials';
      }
      response = await http.post(
        Uri.parse(_conf.tokenEndpoint),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        tokenResponse.addAll(jsonDecode(response.body));
      }
    }
    return TokenResponse.fromJson(tokenResponse);
  }

  String _buildAuthorizationRequestUrl({
    required String codeChallenge,
    required String codeChallengeMethod,
  }) {
    // authorization request URL building logic goes here
    final Map<String, String> queryParams = {
      'response_type': 'code',
      'client_id': _clientId,
      'redirect_uri': redirectUri,
      'scope': 'openid profile email',
      'code_challenge': codeChallenge,
      'code_challenge_method': codeChallengeMethod,
      'access_type': 'offline'
    };

    final String queryString = Uri(queryParameters: queryParams).query;

    return '${_conf.authorizationEndpoint}?$queryString';
  }

  String _generateCodeChallenge(String codeVerifier) {
    Uint8List codeVerifierBytes = Uint8List.fromList(utf8.encode(codeVerifier));
    Digest codeChallengeDigest = sha256.convert(codeVerifierBytes);
    return codeChallenge = base64Url
        .encode(codeChallengeDigest.bytes)
        .replaceAll('=', '') // Elimina los caracteres de padding
        .replaceAll('+', '-') // Reemplaza los caracteres '+' por '-'
        .replaceAll('/', '_'); // Reemplaza los caracteres '/' por '_'
  }

  String _generateCodeVerifier() {
    final random = Random.secure();
    final codeUnits = List.generate(64, (index) {
      final n = random.nextInt(255);
      return n;
    });
    return _codeVerifier = base64Url
        .encode(Uint8List.fromList(codeUnits))
        .replaceAll('=', '') // Elimina los caracteres de padding
        .replaceAll('+', '-') // Reemplaza los caracteres '+' por '-'
        .replaceAll('/', '_'); // Reemplaza los caracteres '/' por '_'
  }

  Future<AuthorizationResponse> _getAuthorizationCode() async {
    codeChallenge =
        _generateCodeChallenge(_codeVerifier ?? _generateCodeVerifier());
    final String authorizationRequestUrl = _buildAuthorizationRequestUrl(
      codeChallenge: codeChallenge!,
      codeChallengeMethod: 'S256',
    );

    return _performAuthorizationRequest(
      authorizationRequestUrl: authorizationRequestUrl,
      codeVerifier: _codeVerifier!,
    );
  }

  Future<AuthorizationTokenResponse?> _parseAuthorizationResponse({
    required AuthorizationResponse authorizationResponse,
  }) async {
    TokenRequest request = TokenRequest(
      _clientId,
      redirectUri,
      authorizationCode: _authorizationCode =
          authorizationResponse.authorizationCode,
      codeVerifier: authorizationResponse.codeVerifier,
      nonce: authorizationResponse.nonce,
      //discoveryUrl: "$authIssuer/.well-known/openid-configuration",
      issuer: _authIssuer,
      allowInsecureConnections: true,
      clientSecret: _consumerSecret,
      serviceConfiguration: _conf,
      grantType: "client_credentials",
      session: authorizationResponse.sessionState,
    );
    final tokenize = await token(request);
    if (tokenize == null) return Future.value(null);
    final authResponse = AuthorizationTokenResponse(
      tokenize.accessToken,
      tokenize.refreshToken,
      tokenize.accessTokenExpirationDateTime,
      tokenize.idToken,
      tokenize.tokenType,
      tokenize.scopes,
      {}, //authorizationAdditionalParameters
      tokenize.tokenAdditionalParameters,
    );
    return authResponse;
  }

  Future<AuthorizationResponse> _performAuthorizationRequest({
    required String authorizationRequestUrl,
    required String codeVerifier,
  }) async {
    final Completer<AuthorizationResponse> completer =
        Completer<AuthorizationResponse>();
    //Para cambiar elementos de diseño en el identity se psa el source

    final color = "#3F899C";

    final base64Image = '';
    //await image2Base64(ASSETS_IMAGES_BACKGROUNDS_DEFAULT_JPG);
    final source = '''
            (function() {
              //var element = document.querySelector('#username');
              var element = document.querySelector('body');
              if (element) {
                element.focus();
                element.style.backgroundColor = '$color';
                //element.style.backgroundImage = 'url(data:image/png;base64,$base64Image)';
              }
              var elements = document.querySelectorAll('.login-html');
              if (elements) {
                for (var i = 0; i < elements.length; i++) {
                  element=elements[i];
                  element.style.backgroundColor = '$color';
                  //element.style.backgroundImage = 'url(data:image/png;base64,$base64Image)';
                }
              }
              var buttons = document.querySelectorAll('button');
              if (buttons) {
               for (var i = 0; i < buttons.length; i++){
                element=buttons[i];
                element.style.backgroundColor = '#3F888C';
               }               
              }

            })(); 
          ''';
    final auth = _AuthContainer(
      authorizationRequestUrl: authorizationRequestUrl,
      clientId: _clientId,
      redirectUri: redirectUri,
      context: context!,
      source: '',
    );
    openInAppWebView(defaultSplash = auth);
    Store store = StoreService().getStore("identityStore");
    final Completer<Map> step = Completer<Map>();

    // Esperar a que la variable tenga el valor deseado
    while (store.isEmpty) {
      await Future.delayed(Duration(milliseconds: 100));
    }

    // Señalar la finalización de la tarea asíncrona
    step.complete(store.getMapFields);

    // Esperar a que se complete la tarea asíncrona
    await step.future;
    //completer.complete(url.toString());
    //auth.hideInAppWebView();
    final response = AuthorizationResponse(
      authorizationCode: store.get("code", ""),
      codeVerifier: codeVerifier,
      nonce: createNonce(),
      sessionState: _sessionState = store.get("session_state", ""),
    );
    completer.complete(response);
    return completer.future;
  }

  _singleSignOn() async {
    final AuthorizationTokenResponse? result = await authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        _clientId,
        redirectUri,
        issuer: _authIssuer,
        scopes: ['openid', 'email', 'profile'],
        additionalParameters: {
          'prompt': 'consent',
          'session_state': _sessionState ?? "",
        },
      ),
    );
  }
}

class IdentityLoginAppPageImpl<T> extends CustomAppPageImpl<T> {
  @override
  final GetPageBuilder page;
  @override
  final bool? popGesture;
  @override
  final Map<String, String>? parameters;
  @override
  final String? title;
  @override
  final Transition? transition;
  @override
  final Curve curve;
  @override
  final bool? participatesInRootNavigator;
  @override
  final Alignment? alignment;
  @override
  final bool maintainState;
  @override
  final bool opaque;
  @override
  final double Function(BuildContext context)? gestureWidth;
  @override
  final Bindings? binding;
  @override
  final List<Bindings> bindings;
  @override
  final CustomTransition? customTransition;
  @override
  final Duration? transitionDuration;
  @override
  final bool fullscreenDialog;
  @override
  final bool preventDuplicates;

  @override
  final Object? arguments;

  @override
  final String name;

  @override
  final List<GetPage> children;
  @override
  final List<GetMiddleware>? middlewares;
  @override
  final PathDecoded customPath;
  @override
  final GetPage? unknownRoute;
  @override
  final bool showCupertinoParallax;
  @override
  String keyMap;
  @override
  int index;

  IdentityLoginAppPageImpl({
    required this.name,
    required this.keyMap,
    required this.page,
    this.index = -1,
    this.title,
    this.participatesInRootNavigator,
    this.gestureWidth,
    this.maintainState = true,
    this.curve = Curves.linear,
    this.alignment,
    this.parameters,
    this.opaque = true,
    this.transitionDuration,
    this.popGesture,
    this.binding,
    this.bindings = const [],
    this.transition,
    this.customTransition,
    this.fullscreenDialog = false,
    this.children = const <GetPage>[],
    this.middlewares,
    this.unknownRoute,
    this.arguments,
    this.showCupertinoParallax = true,
    this.preventDuplicates = true,
  })  : customPath = CustomAppPageImpl.nameToRegex(name),
        assert(name.startsWith('/'),
            'It is necessary to start route name [$name] with a slash: /$name'),
        super(
          name: name,
          keyMap: keyMap,
          page: page,
          index: index,
          title: title,
          participatesInRootNavigator: participatesInRootNavigator,
          gestureWidth: gestureWidth,
          maintainState: maintainState,
          curve: curve,
          alignment: alignment,
          parameters: parameters,
          opaque: opaque,
          transitionDuration: transitionDuration,
          popGesture: popGesture,
          binding: binding,
          transition: transition,
          customTransition: customTransition,
          fullscreenDialog: fullscreenDialog,
          children: children,
          middlewares: middlewares,
          unknownRoute: unknownRoute,
          arguments: Get.arguments,
          showCupertinoParallax: showCupertinoParallax,
          preventDuplicates: preventDuplicates,
        );

  @override
  Route<T> createRoute(BuildContext context) {
    final page = PageRedirect(
      route: this,
      settings: this,
      unknownRoute: unknownRoute,
    ).getPageToRoute<T>(this, unknownRoute);
    return page;
  }

  static IdentityLoginAppPageImpl builder({
    String name = "/identity/login",
    String keyMap = "IDENTITY_LOGIN",
    int index = -1,
    bool? popGesture,
    Widget Function()? builder,
    Map<String, String>? parameters,
    String? title,
    Transition? transition,
    Curve curve = Curves.linear,
    Alignment? alignment,
    bool maintainState = true,
    bool opaque = true,
    Bindings? binding,
    List<Bindings>? bindings,
    CustomTransition? customTransition,
    Duration? transitionDuration,
    bool fullscreenDialog = false,
    RouteSettings? settings,
    List<GetPage> children = const <GetPage>[],
    GetPage? unknownRoute,
    List<GetMiddleware>? middlewares,
    bool preventDuplicates = true,
    final double Function(BuildContext context)? gestureWidth,
    bool? participatesInRootNavigator,
    Object? arguments,
    bool showCupertinoParallax = true,
  }) =>
      IdentityLoginAppPageImpl(
        name: name,
        keyMap: keyMap,
        page: builder ??
            getPageBuilder(
                name, keyMap, builder != null ? builder() : Container()),
        index: index,
        title: title,
        participatesInRootNavigator: participatesInRootNavigator,
        gestureWidth: gestureWidth,
        maintainState: maintainState,
        curve: curve,
        alignment: alignment,
        parameters: parameters,
        opaque: opaque,
        transitionDuration: transitionDuration,
        popGesture: popGesture,
        binding: binding,
        transition: transition,
        customTransition: customTransition,
        fullscreenDialog: fullscreenDialog,
        children: children,
        middlewares: middlewares,
        unknownRoute: unknownRoute,
        arguments: Get.arguments,
        showCupertinoParallax: showCupertinoParallax,
        preventDuplicates: preventDuplicates,
      );

  static GetPageBuilder getPageBuilder(
      String name, String keyMap, Widget child) {
    Routes.getInstance.addRoute(keyMap, name);
    return () => IdentityLoginPage(
          child: child,
        );
  }
}

class IdentityLoginPage extends GetResponsiveView<GetxController> {
  final Widget? child;

  IdentityLoginPage({
    Key? key,
    required this.child,
  }) : super(
            key: key,
            settings: ResponsiveScreenSettings(
              desktopChangePoint: 800,
              tabletChangePoint: 700,
              watchChangePoint: 600,
            ));
  @override
  Widget build(BuildContext context) {
    return child ?? Container();
  }
}

class _AuthContainer extends StatefulWidget {
  final String _authorizationRequestUrl;
  final String _clientId;
  final String _redirectUri;
  final String _source;
  final BuildContext context;
  late _AuthContainerState? _state;
  _AuthContainer({
    required String authorizationRequestUrl,
    required String clientId,
    required String redirectUri,
    required this.context,
    required String source,
  })  : _authorizationRequestUrl = authorizationRequestUrl,
        _clientId = clientId,
        _redirectUri = redirectUri,
        _source = source;

  _AuthContainerState get getState => _state ?? createState();

  @override
  _AuthContainerState createState() => _state = _AuthContainerState();

  hideInAppWebView() {
    if (getState.mounted) {
      getState.hideInAppWebView();
    }
  }
}

class _AuthContainerState extends State<_AuthContainer>
    with WidgetsBindingObserver {
  bool _cargando = false;
  bool _showWebView = true;
  late InAppWebView _webView;
  late InAppWebViewController _webViewController;
  late String _clientId, _redirectUri;

  afterBuild() {
    callback(_) {
      /*setState(() {
        _cargando = false;
      });*/
    }

    WidgetsBinding.instance.addPostFrameCallback(callback);
  }

  @override
  Widget build(BuildContext context) {
    final form = _form(context);
    return form;
  }

  @override
  void didChangeMetrics() {
    // La función se llamará después de que el widget se haya construido completamente
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild());
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  hideInAppWebView() {
    setState(() {
      _showWebView = false;
    });
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _cargando = false;
    _showWebView = true;
    _clientId = widget._clientId;
    _redirectUri = widget._redirectUri;
  }

  Widget _form(BuildContext context) {
    String userAgent =
        "Mozilla/5.0 (Linux; Android 10; SM-G975U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Mobile Safari/537.36";
    _webView = InAppWebView(
      initialUrlRequest:
          URLRequest(url: Uri.parse(widget._authorizationRequestUrl)),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
          clearCache: true,
          userAgent: userAgent,
        ),
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        _webViewController = controller;
      },
      onLoadStop: (controller, url) {
        if (widget._source.isNotEmpty) {
          controller.evaluateJavascript(source: widget._source);
        }
      },
      gestureRecognizers: <Factory<VerticalDragGestureRecognizer>>{}..add(
          Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
      /* onLoadStop: (controller, url) async {
        final result = await controller.evaluateJavascript(
          source:
              'function test(){document.getElementById("username").focus(); return document.getElementById("username");}test();',
          //contentWorld: ContentWorld.world(name: name)
        );
      },*/
      onLoadStart: (InAppWebViewController controller, Uri? url) async {
        //controller.requestFocusNodeHref();
        if (url?.toString().startsWith(_redirectUri) ?? false) {
          //  await controller.clearCache();
          //await controller.clearCookies();
          await controller.stopLoading();
          Store store = StoreService().getStore("identityStore");
          store.from(url!.queryParameters);
          setState(() {
            _showWebView = false;
          });
          return Future.value();
        }
      },
    );
    _webViewController = InAppWebViewController(_clientId, _webView);
    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_DEFAULT_JPG,
        ),
        _showWebView
            ? _webView
            : Loading.fromText(text: "Autenticando usuario..."),
        if (_cargando)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}

class _AuthSplash extends StatelessWidget {
  final Map _data;
  final Future Function(
      CustomFlutterAppAuth auth, Map<dynamic, dynamic> parameters) handler;
  final CustomFlutterAppAuth auth;
  _AuthSplash({
    required Map data,
    required this.auth,
    required this.handler,
  }) : _data = data;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(process);
    return Stack(children: [
      BackGroundImage(
        backgroundImage: ASSETS_IMAGES_BACKGROUNDS_DEFAULT_JPG,
      ),
      Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          child: Loading.fromText(text: "Autenticando usuario"),
        ),
      )
    ]);
  }

  Future process(Duration _) async {
    Store store = StoreService().getStore("identityStore");
    return handler(auth, store.getMapFields);
  }
}
