import 'dart:convert' as convert;
import 'dart:io';
import 'dart:math';

import 'package:asn1lib/asn1lib.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' as wid;
import 'package:get/get.dart';
import 'package:pointycastle/export.dart';

import '/remote/rsa_pkcs/rsa_pkcs.dart' as pkcs;
import '../../../app/core/services/base16_encoded.dart';
import '../../../app/core/services/logger_service.dart';

class CustomRSAKey extends RSAAsymmetricKey implements PrivateKey, PublicKey {
  RSAPrivateKey? _private;
  RSAPublicKey? _public;

  /// Create an RSA public key for the given parameters.
  CustomRSAKey(RSAPublicKey? public, RSAPrivateKey? private)
      : super(public != null ? public.modulus : private?.modulus,
            public != null ? public.publicExponent : private?.privateExponent) {
    _public = public;
    _private = private;
  }

  /// Get public exponent [e]
  @Deprecated('Use get publicExponent')
  BigInt? get e => exponent;

  /// Get the private exponent (d)
  BigInt? get privateExponent => exponent;

  /// Get the public exponent (e)
  BigInt? get pubExp => _public?.publicExponent;

  /// Get the public exponent (e)
  @Deprecated('Use publicExponent.')
  BigInt? get pubExponent => publicExponent;

  /// Get the public exponent.
  BigInt? get publicExponent => exponent;

  @override
  bool operator ==(other) {
    if (other is RSAPublicKey) {
      return (other.modulus == modulus) &&
          (other.publicExponent == publicExponent);
    }
    if (other is RSAPrivateKey) {
      return other.privateExponent == privateExponent &&
          other.modulus == modulus;
    }
    return false;
  }
}

/// RSA PEM parser.
class CustomRSAKeyParser extends RSAKeyParser {
  static const String pkcsHeader = '-----';
  static const String pkcs1PublicHeader = '-----BEGIN RSA PUBLIC KEY-----';
  static const String pkcs8PublicHeader = '-----BEGIN PUBLIC KEY-----';
  static const String pkcs1PublicFooter = '-----END RSA PUBLIC KEY-----';
  static const String pkcs8PublicFooter = '-----END PUBLIC KEY-----';

  static const String pkcs1PrivateHeader = '-----BEGIN RSA PRIVATE KEY-----';
  static const String pkcs8PrivateHeader = '-----BEGIN PRIVATE KEY-----';
  static const String pkcs1PrivateFooter = '-----END RSA PRIVATE KEY-----';
  static const String pkcs8PrivateFooter = '-----END PRIVATE KEY-----';

  static const String pkcs8PrivateEncHeader =
      '-----BEGIN ENCRYPTED PRIVATE KEY-----';
  static const String pkcs8PrivateEncFooter =
      '-----END ENCRYPTED PRIVATE KEY-----';

  static const String certHeader = '-----BEGIN CERTIFICATE-----';
  static const String certFooter = '-----END CERTIFICATE-----';

  static const List<String> _headers = [
    pkcs1PublicHeader,
    pkcs8PublicHeader,
    pkcs1PrivateHeader,
    pkcs8PrivateHeader,
    pkcs8PrivateEncHeader,
    certHeader
  ];

  String? getStrPrivateKey(List<String> lines) {
    late int header;
    late int footer;

    if (lines.contains(pkcs1PrivateHeader)) {
      header = lines.indexOf(pkcs1PrivateHeader);
      footer = lines.indexOf(pkcs1PrivateFooter);
    } else if (lines.contains(pkcs8PrivateHeader)) {
      header = lines.indexOf(pkcs8PrivateHeader);
      footer = lines.indexOf(pkcs8PrivateFooter);
    } else if (lines.contains(pkcs8PrivateEncHeader)) {
      header = lines.indexOf(pkcs8PrivateEncHeader);
      footer = lines.indexOf(pkcs8PrivateEncFooter);
    } else {
      return null;
    }
    if (footer < 0) {
      throw FormatException('format error : cannot find footer');
    }
    return lines.sublist(header + 1, footer).join('');
  }

  String? getStrPublicKey(List<String> lines) {
    late int header;
    late int footer;
    if (lines.contains(pkcs1PublicHeader)) {
      header = lines.indexOf(pkcs1PublicHeader);
      footer = lines.indexOf(pkcs1PublicFooter);
    } else if (lines.contains(pkcs8PublicHeader)) {
      header = lines.indexOf(pkcs8PublicHeader);
      footer = lines.indexOf(pkcs8PublicFooter);
    } else if (lines.contains(certHeader)) {
      header = lines.indexOf(certHeader);
      footer = lines.indexOf(certFooter);
    } else {
      return null;
    }
    if (footer < 0) {
      throw FormatException('format error : cannot find footer');
    }
    return lines.sublist(header + 1, footer).join('');
  }

  /// Parses the PEM key no matter it is public or private, it will figure it out.
  @override
  RSAAsymmetricKey parse(String key) {
    final rows = key.split(RegExp(r'\r\n?|\n'));
    final header = rows.first;

    if (header == '-----BEGIN RSA PUBLIC KEY-----') {
      return _parsePublic(_parseSequence(rows));
    }

    if (header == '-----BEGIN PUBLIC KEY-----') {
      return _parsePublic(_pkcs8PublicSequence(_parseSequence(rows)));
    }

    if (header == '-----BEGIN RSA PRIVATE KEY-----') {
      return _parsePrivate(_parseSequence(rows));
    }

    if (header == '-----BEGIN PRIVATE KEY-----') {
      return _parsePrivate(_pkcs8PrivateSequence(_parseSequence(rows)));
    }
    log("Contiene:${key.contains(_headersPatterns())}");
    if (header == '-----BEGIN CERTIFICATE-----' ||
        key.contains(_headersPatterns())) {
      /*final pem = x509.parsePem(key).first as x509.X509Certificate;
      x509.PublicKey pub = pem.publicKey;
      log("PublicKey:${pub.toString()}");
      log("Signature Algorithm:${pem.signatureAlgorithm.toString()}");*/
      final parser = pkcs.RSAPKCSParser();
      final pair = parser.parsePEM(key);

      final public = pair.public != null
          ? RSAPublicKey(
              pair.public!.modulus, BigInt.from(pair.public!.publicExponent))
          : null;
      final private = pair.private != null
          ? RSAPrivateKey(
              pair.private!.modulus,
              pair.private!.privateExponent,
              pair.private!.prime1,
              pair.private!.prime2,
            )
          : null;
      //
      final customKey = CustomRSAKey(
        public,
        private,
      );
      return customKey;
    }

    throw FormatException('Unable to parse key, invalid format.', header);
  }

  List<String> parseContent(String content) {
    final List<String> lines = content
        .split('\n')
        .map((String line) => line.trim())
        .where((String line) => line.isNotEmpty)
        // .skipWhile((String line) => !line.startsWith(pkcsHeader))
        .toList();
    if (lines.isEmpty) {
      throw FormatException('format error');
    }
    return lines;
  }

  Pattern _headersPatterns() {
    String str = "";
    int c = 0;
    for (var e in _headers) {
      str += c == 0 ? "($e)|" : "|($e)";
      c++;
    }
    return RegExp("r'$str'");
  }

  RSAAsymmetricKey _parsePrivate(ASN1Sequence sequence) {
    final modulus = (sequence.elements[1] as ASN1Integer).valueAsBigInteger;
    final exponent = (sequence.elements[3] as ASN1Integer).valueAsBigInteger;
    final p = (sequence.elements[4] as ASN1Integer).valueAsBigInteger;
    final q = (sequence.elements[5] as ASN1Integer).valueAsBigInteger;

    return RSAPrivateKey(modulus!, exponent!, p, q);
  }

  RSAAsymmetricKey _parsePublic(ASN1Sequence sequence) {
    final modulus = (sequence.elements[0] as ASN1Integer).valueAsBigInteger;
    final exponent = (sequence.elements[1] as ASN1Integer).valueAsBigInteger;

    return RSAPublicKey(modulus!, exponent!);
  }

  ASN1Sequence _parseSequence(List<String> rows) {
    final keyText = rows
        .skipWhile((row) => row.startsWith('-----BEGIN'))
        .takeWhile((row) => !row.startsWith('-----END'))
        .map((row) => row.trim())
        .join('');

    final keyBytes = Uint8List.fromList(convert.base64.decode(keyText));
    final asn1Parser = ASN1Parser(keyBytes);

    return asn1Parser.nextObject() as ASN1Sequence;
  }

  ASN1Sequence _pkcs8PrivateSequence(ASN1Sequence sequence) {
    final ASN1Object bitString = sequence.elements[2];
    final bytes = bitString.valueBytes();
    final parser = ASN1Parser(bytes);

    return parser.nextObject() as ASN1Sequence;
  }

  ASN1Sequence _pkcs8PublicSequence(ASN1Sequence sequence) {
    final ASN1Object bitString = sequence.elements[1];
    final bytes = bitString.valueBytes().sublist(1);
    final parser = ASN1Parser(Uint8List.fromList(bytes));

    return parser.nextObject() as ASN1Sequence;
  }

  static Uint8List getBytesFromPEMString(String pem,
      {bool checkHeader = true}) {
    var lines = convert.LineSplitter.split(pem)
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
    String base64;
    if (checkHeader) {
      if (lines.length < 2 ||
          !lines.first.startsWith('-----BEGIN') ||
          !lines.last.startsWith('-----END')) {
        throw ArgumentError('The given string does not have the correct '
            'begin/end markers expected in a PEM file.');
      }
      base64 = lines.sublist(1, lines.length - 1).join('');
    } else {
      base64 = lines.join('');
    }

    return Uint8List.fromList(convert.base64Decode(base64));
  }
}

enum CypherAlgorithms { aes, rsa }

enum SslTlsEncodeType {
  none,
  base64,
  base16,
  byte,
}

class SslTlsService {
  static SslTlsService? _instance;
  static SslTlsService get getInstance =>
      _instance ?? SslTlsService._internal();

  late List<TrustedCertificate> _trustedCertificate;

  String _userInitialVector = "";
  IV? initVector;

  SslTlsService._internal() {
    Get.lazyPut<SslTlsService>(() => this);
    _trustedCertificate = [];
    _instance = this;
  }

  List<TrustedCertificate> get getTrustedCertificate => _trustedCertificate;

  SslTlsService addTrustedCertificate(List<TrustedCertificate> certs) {
    List<TrustedCertificate> tmp = _trustedCertificate;
    for (var element in certs) {
      tmp.addIf(!tmp.contains(element), element);
    }
    _trustedCertificate = tmp;
    return _instance = this;
  }

  Future<void> connect({
    SecurityContext? context,
    HttpClient? client,
    String? caCertPath,
    String? caChainPath,
    String? caPrivatePath,
  }) async {
    //
    context = context ?? SecurityContext.defaultContext;
    client = client ?? HttpClient(context: context);
    if (caCertPath != null) {
      final rootCA = await rootBundle.load(caCertPath);
      context.setClientAuthoritiesBytes(rootCA.buffer.asUint8List());
    }
    if (caChainPath != null) {
      final deviceCert = await rootBundle.load(caChainPath);
      context.useCertificateChainBytes(deviceCert.buffer.asUint8List());
    }
    if (caPrivatePath != null) {
      final privateKey = await rootBundle.load(caPrivatePath);
      context.usePrivateKeyBytes(privateKey.buffer.asUint8List());
    }
  }

  String decryptWithAES(
    Encrypted data, {
    RSAPublicKey? publicKey,
    RSAPrivateKey? privateKey,
    required SslTlsEncodeType type,
    AESMode mode = AESMode.cbc,
    Map<dynamic, dynamic>? userProfile,
  }) {
    String key = publicKey.toString();
    final cipherKey = Key.fromUtf8(key);
    //Using AES CBC encryption
    final encryptService = Encrypter(AES(
      cipherKey,
      mode: mode,
    ));
    //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.
    initVector = _getVector(
      userProfile: userProfile,
    );
    return encryptService.decrypt(data, iv: initVector);
  }

  String decryptWithRSA(
    Encrypted data, {
    RSAPublicKey? publicKey,
    RSAPrivateKey? privateKey,
    required SslTlsEncodeType type,
    RSAEncoding encoding = RSAEncoding.PKCS1,
    Map<dynamic, dynamic>? userProfile,
  }) {
    final rsa = RSA(
      publicKey: publicKey,
      privateKey: privateKey,
      encoding: encoding,
    );
    final encrypter = Encrypter(rsa);
    initVector = _getVector(
      userProfile: userProfile,
    );
    switch (type) {
      case SslTlsEncodeType.none:
        return encrypter.decrypt(
          data,
          iv: initVector,
        );
      case SslTlsEncodeType.byte:
        return convert.utf8.decode(encrypter.decryptBytes(
          data,
          iv: initVector,
        ));
      case SslTlsEncodeType.base16:
        return encrypter.decrypt16(
          data.base16,
          iv: initVector,
        );
      case SslTlsEncodeType.base64:
        return encrypter.decrypt64(
          data.base64,
          iv: null,
        );
      default:
        return encrypter.decrypt(
          data,
          iv: initVector,
        );
    }
  }

  ///Encrypts the given data using the key. Returns encrypted data
  Encrypted encryptWithAES(
    String data, {
    RSAPublicKey? publicKey,
    RSAPrivateKey? privateKey,
    required SslTlsEncodeType type,
    AESMode mode = AESMode.cbc,
    Map<dynamic, dynamic>? userProfile,
  }) {
    String key = privateKey.toString();
    final cipherKey = Key.fromUtf8(key);
    final encrypter = Encrypter(AES(
      cipherKey,
      mode: mode,
    ));
    /*final service =
        ManagerAuthorizationService().get(defaultIdpKey);*/
    //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.
    initVector = _getVector(
      userProfile: userProfile,
    );

    switch (type) {
      case SslTlsEncodeType.none:
        return encrypter.encrypt(
          data,
          iv: initVector,
        );
      case SslTlsEncodeType.byte:
        return encrypter.encryptBytes(
          convert.utf8.encode(data),
          iv: initVector,
        );
      case SslTlsEncodeType.base16:
        return encrypter.encrypt(
          base16encode(convert.utf8.encode(data)),
          iv: initVector,
        );
      case SslTlsEncodeType.base64:
        return encrypter.encrypt(
          convert.base64Encode(convert.utf8.encode(data)),
          iv: initVector,
        );
      default:
    }
    return encrypter.encrypt(
      data,
      iv: initVector,
    );
  }

  Encrypted encryptWithRSA(
    String data, {
    required RSAPublicKey? publicKey,
    required RSAPrivateKey? privateKey,
    required SslTlsEncodeType type,
    RSAEncoding encoding = RSAEncoding.PKCS1,
    Map<dynamic, dynamic>? userProfile,
  }) {
    final rsa = RSA(
      publicKey: publicKey,
      privateKey: privateKey,
      encoding: encoding,
    );
    final encrypter = Encrypter(rsa);
    initVector = _getVector(
      userProfile: userProfile,
    );
    switch (type) {
      case SslTlsEncodeType.none:
        return encrypter.encrypt(
          data,
          iv: initVector,
        );
      case SslTlsEncodeType.byte:
        return encrypter.encryptBytes(
          convert.utf8.encode(data),
          iv: initVector,
        );
      case SslTlsEncodeType.base16:
        return encrypter.encrypt(
          base16encode(convert.utf8.encode(data)),
          iv: initVector,
        );
      case SslTlsEncodeType.base64:
        return encrypter.encrypt(
          convert.base64Encode(convert.utf8.encode(data)),
          iv: initVector,
        );
      default:
    }
    return encrypter.encrypt(
      data,
      iv: initVector,
    );
  }

  IV generateRandomIV() {
    final blockSize = 16;
    final random = Random.secure();
    final iv = Uint8List(blockSize);
    for (var i = 0; i < blockSize; i++) {
      iv[i] = random.nextInt(256);
    }
    return IV.fromUtf8(String.fromCharCodes(
        Uint8List.fromList(List.generate(16, (_) => random.nextInt(256)))));
  }

  //https://stackoverflow.com/questions/65129935/flutter-dart-synchronous-way-to-read-file-in-asset-folder
  /*Future<Stream<File>> getPlaces(String pemFile) async {
  return   Stream.fromFuture(rootBundle.loadString(pemFile))
    .transform(json.decoder)
    .expand((jsonBody) => (jsonBody as Map)['results'])
    .map((jsonPlace) =>   Place.fromJson(jsonPlace));
}*/

  Future<Stream<File>> getCa(String certPath) async {
    return Stream.fromFuture(rootBundle.loadString(certPath))
        .map((event) => File.fromRawPath(Uint8List.fromList(event.codeUnits)));
  }

  File getCATrustedCertificate(String path) => File(path);

  File getClientTrustedCertificate(String path) => File(path);

  Future<T?> getKey<T>(String certPath) async {
    log("Reading:$certPath");
    final rsaKey = await readKeyFromFile<T>(certPath);
    log("Type returned:${rsaKey?.runtimeType}");
    return rsaKey;
  }

  File getKeyTrustedCertificate(String path) => File(path);

  T getRSAKeyFromStr<T>(String content) {
    log("Type required:$T ");
    final result = CustomRSAKeyParser().parse(content);
    /*if (result is CustomRSAKey) {
      if (result._public == null && result._private != null) {
        return result._private as T;
      }
    }*/
    log(result);
    log("Building instance of ${result.runtimeType} ");
    return result as T;
  }

  Future<RSAPublicKey> getRsaPublicKeyFromPem(String certificatePem) async {
    final publicKey =
        await getKey<RSAAsymmetricKey>(certificatePem) as RSAPublicKey;
    return publicKey;
  }

  Future<RSAPublicKey> getRsaPublicKeyFromStringCert(
    String certificateString,
  ) async {
    final publicKey = getRSAKeyFromStr<RSAPublicKey>(certificateString);
    log('Esta es la publicKey==> ${publicKey.toString()}');
    return publicKey;
  }

  Future<List<TrustedCertificate>> getTrustedCertificates() async {
    return Future.value(
        _trustedCertificate/*= [
      TrustedCertificate((await rootBundle.load(ASSETS_RAW_ENZONA_NET_CRT_CRT))
          .buffer
          .asInt8List()), //CA
      TrustedCertificate(
          (await rootBundle.load(ASSETS_RAW_ENZONA_NET_CLIENT_PEM))
              .buffer
              .asInt8List()), //Client
      TrustedCertificate((await rootBundle.load(ASSETS_RAW_ENZONA_NET_KEY_KEY))
          .buffer
          .asInt8List()), //Key
    ]*/
        );
  }

  String getUserInitialVectorString(Map userProfile) {
    if (_userInitialVector.isNotEmpty) return _userInitialVector;
    final String? atHash =
        userProfile.containsKey("at_hash") ? userProfile["at_hash"] : null;
    if (atHash != null) {
      return _userInitialVector = atHash;
    }
    return _userInitialVector = wid.UniqueKey().toString();
  }

  Future<T?> readKeyFromFile<T>(String certPath) async {
    log("Loading Certh From Path: $certPath");
    final content = await _readFileAsync(certPath);
    final rsaKey = getRSAKeyFromStr<T>(content);
    return Future.value(rsaKey);
  }

  SslTlsService removeTrustedCertificate(TrustedCertificate cert) {
    List<TrustedCertificate> tmp = _trustedCertificate;
    for (var element in _trustedCertificate) {
      tmp.removeWhere((item) => item == element && cert == item);
    }
    _trustedCertificate = tmp;
    return this;
  }

  IV _getVector({
    Map<dynamic, dynamic>? userProfile,
  }) {
    /*final vector = getUserInitialVectorString(userProfile ?? {});
    log("Vector de Seguridad:$vector");*/
    return initVector = generateRandomIV();
  }

  Future<String> _readFileAsync(String path) async {
    final byteData = await rootBundle.load(path);
    final bytes = byteData.buffer.asUint8List();
    final decodedString = String.fromCharCodes(bytes);
    //final result = await rootBundle.loadString(path);
    return Future.value(decodedString);
  }

  static Future<Encrypted?> cypher({
    required String data,
    required String certPath,
    CypherAlgorithms? cypherAlgorithms,
    SslTlsEncodeType? encodedType,
    RSAEncoding encoding = RSAEncoding.PKCS1,
    Map<dynamic, dynamic> args = const {},
  }) async {
    SslTlsService service = SslTlsService.getInstance;

    final cert = await service.getKey<RSAAsymmetricKey>(certPath);
    RSAPublicKey? publicKey;
    RSAPrivateKey? privateKey;

    if (cert is CustomRSAKey) {
      publicKey = cert._public;
      privateKey = cert._private;
      //await service.getKey<RSAAsymmetricKey>(certPath) as RSAPrivateKey;
    } else {
      publicKey = await service.getKey<RSAPublicKey>(certPath) as RSAPublicKey;
      privateKey =
          await service.getKey<RSAPrivateKey>(certPath) as RSAPrivateKey;
    }

    Map<dynamic, dynamic>? userProfile = args.containsKey("at_hash")
        ? args
        : {"at_hash": wid.UniqueKey().toString()};

    CypherAlgorithms algorithms = cypherAlgorithms ?? CypherAlgorithms.rsa;
    SslTlsEncodeType type = encodedType ?? SslTlsEncodeType.base64;

    switch (algorithms) {
      case CypherAlgorithms.rsa:
        log("CypherAlgorithms: ${algorithms.toString()}");
        return service.encryptWithRSA(
          data,
          publicKey: publicKey,
          privateKey: privateKey,
          type: type,
          encoding: encoding,
          userProfile: userProfile,
        );

      case CypherAlgorithms.aes:
        return service.encryptWithAES(
          data,
          publicKey: publicKey,
          privateKey: privateKey,
          type: type,
          mode: AESMode.cbc,
          userProfile: userProfile,
        );

      default:
    }

    return null;
  }

  static Future<String?> uncypher(
    Encrypted data, {
    required String certPath,
    CypherAlgorithms? cypherAlgorithms,
    SslTlsEncodeType? encodedType,
    RSAEncoding encoding = RSAEncoding.PKCS1,
    AESMode mode = AESMode.cbc,
    Map<dynamic, dynamic> args = const {},
  }) async {
    SslTlsService service = SslTlsService.getInstance;
    //certPath = certPath;
    //final mas = ManagerAuthorizationService().get(defaultIdpKey);
    final cert = await service.getKey<RSAAsymmetricKey>(certPath);
    RSAPublicKey? publicKey;
    RSAPrivateKey? privateKey;

    if (cert is CustomRSAKey) {
      publicKey = cert._public;
      privateKey = cert._private;
    } else {
      publicKey = await service.getKey<RSAPublicKey>(certPath) as RSAPublicKey;
      privateKey =
          await service.getKey<RSAPrivateKey>(certPath) as RSAPrivateKey;
    }
    /*final cipher = RSAEngine()
      ..init(false, PrivateKeyParameter<RSAPrivateKey>(privateKey!));
    final encryptedData = base64.decode(data.base64);
    final decryptedData = cipher.process(encryptedData);
    final response = utf8.decode(decryptedData);*/

    Map<dynamic, dynamic>? userProfile = args.containsKey("at_hash")
        ? args
        : {"at_hash": wid.UniqueKey().toString()};

    CypherAlgorithms algorithms = cypherAlgorithms ?? CypherAlgorithms.rsa;
    SslTlsEncodeType type = encodedType ?? SslTlsEncodeType.base64;
    switch (algorithms) {
      case CypherAlgorithms.rsa:
        log("UnCypherAlgorithms: ${algorithms.toString()}");
        return service.decryptWithRSA(
          data,
          publicKey: publicKey,
          privateKey: privateKey,
          type: type,
          encoding: encoding,
          userProfile: userProfile,
        );

      case CypherAlgorithms.aes:
        return service.decryptWithAES(
          data,
          publicKey: publicKey,
          privateKey: privateKey,
          type: type,
          mode: mode,
          userProfile: userProfile,
        );
      default:
    }
    return null;
  }
}
