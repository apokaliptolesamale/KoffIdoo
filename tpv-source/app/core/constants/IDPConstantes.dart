// ignore_for_file: non_constant_identifier_names, file_names

import '../../../app/core/config/api_path.dart';

final String ACCESS_COMPLETO = "$CALL_BACK_URL/?code=";

final String ACCESS_TOKEN = "access_token";
final String API_ACCOUNT = "$API_HOST/account/v1.0.0/";
final String API_CARD = "$API_HOST/cards/v1.0.0/";
final String API_CLAIMS = "$API_HOST/claim/v1.0.0/";
final String API_DONATION = "$API_HOST/donation/v1.0.0/";
final String API_HOST = "https://api.$ENZONA_HOST";
final String API_INVOICE = "$API_HOST/invoice/v1.0.0/";
final String API_MERCHANT = "$API_HOST/merchant/v1.0.0/";
final String API_NOTIFICACION = "$API_HOST/notification/v1.0.0/";
final String API_ONAT = "$API_HOST/onat/v1.0.0/";
final String API_OPERACIONES = "$API_HOST/operations/v1.0.0/";
final String API_PAYMENT = "$API_HOST/payment/v1.0.0/";
final String API_PAYMENT_PRODUCT = "$API_HOST/payment/v1.0.1/";
final String API_PRESTASHOP = "$API_HOST/prestashop/v1.0.0/";
final String API_PRODUCT = "$API_HOST/products/v1.0.0/";
final String API_QR = "$API_HOST/qr/v1.0.0/";
final String API_REGALO = "$API_HOST/giftapi/v1.0.0/";
final String API_TRANSFER = "$API_HOST/transfer/v1.0.0/";
final String CALL_BACK_URL = "https://www.$ENZONA_HOST";
// final String CRT_API_MANAGER="enzona_net.crt";
final String CRT_API_MANAGER = "enzona_2020.crt";
final String CRT_CA = "USERTrust_RSA_Certification_Authority.crt";
final String ENZONA_HOST = ApiPath.enzonaHost;

final int InitialTimeOut = 900000;
final String TEXTO_CARGANDO = "Procesando...";
final String TEXTO_SIN_CONEXION =
    "Sin conexión no es posible hacer esta operación.";
final String Update_APK = "https://util.$ENZONA_HOST/enzona.apk";
final String Update_MAPS = "https://util.$ENZONA_HOST/cuba.map";
final String URL_MEDIA = "https://media.$ENZONA_HOST/";
final String URL_TRAMITES = "https://transparencia.$ENZONA_HOST";
final String WSO2_HOST = "https://identity.$ENZONA_HOST";
final String WSO2_LOGOUT = "$WSO2_HOST/oidc/logout";
final String WSO2_OAUTH2_AUTHORIZE = "$WSO2_HOST/oauth2/authorize?";
final String WSO2_OAUTH2_TOKEN = "$WSO2_HOST/oauth2/token";
