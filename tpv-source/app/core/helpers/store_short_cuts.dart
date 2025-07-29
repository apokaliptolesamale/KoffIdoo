import '/app/routes/route_pages.dart';
import '../services/store_service.dart';

List<String> get getListOfPages => RoutePages.instance.listOfPages.isEmpty
    ? RoutePages.instance.listOfPages
    : RoutePages.instance.listOfPages =
        StoreService().getStore("system").get("listOfPages", []);
