import 'dart:convert';

import 'package:apk_template/features/auth/data/infraestructure.dart';
import 'package:pkce/pkce.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:apk_template/config/config.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:apk_template/features/auth/presentation/providers/auth_provider.dart';


//---Provider
final loginScreenProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginState>((ref) {
  final keyValueStorageService = KeyValueStorageserviceImpl();

  //---UsesCase
  final loginCallback = ref.watch(authProvider.notifier).login;
  final logoutCallBack = ref.watch(authProvider.notifier).logout;

  return LoginNotifier(
    keyValueStorageService: keyValueStorageService,
    loginCallback: loginCallback,
    logoutCallback: logoutCallBack,
  );
});

//---Notifiaer
class LoginNotifier extends StateNotifier<LoginState> {
  final Function(String code) loginCallback;
  final Function() logoutCallback;
  final KeyValueStorageservice keyValueStorageService;

  LoginNotifier({
    required this.keyValueStorageService,
    required this.logoutCallback,
    required this.loginCallback,
  }) : super(LoginState());

  Future<String> getUriToLogin() async {
    final pkcePair = PkcePair.generate(length: 32);
    await keyValueStorageService.setKeyValue<String>(
        'codeVerifier', pkcePair.codeVerifier);
    await keyValueStorageService.setKeyValue<String>(
        'codeChallenge', pkcePair.codeChallenge);
    String uri = '${Environment.authorizationEndpoint}?response_type=code';
    uri = '$uri&client_id=${Environment.clientId}&scope=openid';
    uri = '$uri&redirect_uri=${Environment.redirectUri}';
    uri = '$uri&code_challange=${pkcePair.codeChallenge}';
    uri = '$uri&code_challange_method=S256';
    return Environment.identityHost + uri;
  }

  Future<String> getUriToLogout() async {
    final token = await keyValueStorageService.getValue<String>('token');
    final authCode = await keyValueStorageService.getValue<String>('authCode');
    final tokenEntity = TokenMapper.tokenJsonToEntity(json.decode(token!));
    String query = '?id_token_hint=${tokenEntity.idToken}';
    query = '$query&code=$authCode';
    query = '$query&post_logout_redirect_uri=${Environment.redirectUri}';
    await keyValueStorageService.clearData();
    return Environment.identityHost + Environment.logoutEndpoint + query;
  }

  onProgessChanged(InAppWebViewController webViewController, int progress) {
    final newProgress = progress;
    state = state.copyWith(progress: newProgress);
  }

  onLoadStop(InAppWebViewController webViewController, WebUri? uri) {
    final newUrl = uri.toString();
    if (newUrl.contains('logout')) {
      print('OnLoadStop - Cerrando sesion');
    } else {
      print('OnLoadStop - $newUrl');
    }
    state = state.copyWith(url: newUrl);
  }

  onLoadStar(InAppWebViewController webViewController, WebUri? uri) async {
    final newUrl = uri.toString();
    if (newUrl.contains('code=')) {
      print('OnLoadStart - iniciando sesion');
      await webViewController.stopLoading();
      final String code = WebUri(newUrl).queryParameters['code'] ?? "";
      print('code = $code');
      await loginCallback(code);
    }
    if (newUrl ==
        'https://www.enzona.net/?sp=admin_ppago-apk_PRODUCTION&tenantDomain=carbon.super') {
      await webViewController.stopLoading();
      await webViewController.clearHistory();
      await logoutCallback();
    }
    state = state.copyWith(url: newUrl);
  }
}

//---Satate
class LoginState {
  final int progress;
  final String url;

  LoginState({
    this.url = '',
    this.progress = 0,
  });

  LoginState copyWith({String? url, int? progress}) => LoginState(
        progress: progress ?? this.progress,
        url: url ?? this.url,
      );
}
