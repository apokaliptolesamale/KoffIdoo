import '/app/core/constants/constants.dart';
import 'api.dart';
import 'app.dart';
import 'design.dart';
import 'idp.dart';

class Config {
  final String name;
  final String logLevel;
  final String urlConnectionTest;
  final DateTime createAt;
  final DateTime updateAt;
  final List<Api> apis;
  final List<Idp> idps;
  final App app;
  final Design? design;
  final String loginRoute;
  final String indexRoute;
  final String homePageRoute;
  final bool useSystemProxy;
  final bool useTestConnection;
  final String localProxy;

  Config({
    required this.name,
    required this.createAt,
    required this.updateAt,
    required this.apis,
    required this.design,
    required this.app,
    required this.idps,
    required this.loginRoute,
    required this.homePageRoute,
    required this.indexRoute,
    this.logLevel = "ALL",
    this.useSystemProxy = true,
    this.localProxy = "",
    this.urlConnectionTest = Constants.redirectUri,
    this.useTestConnection = true,
  });
}
