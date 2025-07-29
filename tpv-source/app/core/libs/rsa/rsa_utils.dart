// ignore_for_file: unused_field

import 'dart:convert' as convert;
import 'dart:math';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:get/get.dart';
import 'package:pointycastle/export.dart';

class RSAUtils {
  static RSAPublicKey? rsaPublicKey;
  static RSAPrivateKey? rsaPrivateKey;

  static final RSAUtils _instance = !Get.isRegistered()
      ? RSAUtils._internal(publicKey: "", privateKey: "")
      : Get.find();

  RSAUtils._internal({
    String? publicKey,
    String? privateKey,
  }) {
    if (publicKey != null) {
      rsaPublicKey = parse(publicKey) as RSAPublicKey?;
    }
    if (privateKey != null) {
      rsaPrivateKey = parse(privateKey) as RSAPrivateKey?;
    }
  }

  Uint8List? decryptByPrivateKey(Uint8List data) {
    try {
      /*final keyparameter =
          () => PublicKeyParameter<RSAPublicKey>(rsaPublicKey!);*/
      AsymmetricBlockCipher cipher = AsymmetricBlockCipher("RSA/PKCS1");
      cipher.reset();
      cipher.init(false, PrivateKeyParameter<RSAPrivateKey>(rsaPrivateKey!));
      int index = 0;
      int strlength = data.length;
      final keysize = rsaPublicKey!.modulus!.bitLength ~/ 8 - 11;
      final blocksize = rsaPublicKey!.modulus!.bitLength ~/ 8;
      final numblock =
          (strlength ~/ keysize) + ((strlength % keysize != 0) ? 1 : 0);
      Uint8List list = Uint8List(blocksize * numblock);
      int count = 0;
      int strindex = 0;
      while (index < strlength) {
        Uint8List listtmp =
            data.sublist(count * blocksize, (count + 1) * blocksize);

        Uint8List result = cipher.process(listtmp);
        for (var i = 0; i < result.length; i++) {
          list[count * keysize + i] = result[i];
        }
        count += 1;
        strindex += result.length;
        index += blocksize;
      }
      return list.sublist(0, strindex);
    } catch (e) {}
    return null;
  }

  Uint8List? decryptByPublicKey(Uint8List data) {
    try {
      /*final keyparameter =
          () => PublicKeyParameter<RSAPublicKey>(rsaPublicKey!);*/
      AsymmetricBlockCipher cipher = AsymmetricBlockCipher("RSA/PKCS1");
      cipher.reset();
      cipher.init(false, PublicKeyParameter<RSAPublicKey>(rsaPublicKey!));
      int index = 0;
      int strlength = data.length;
      final keysize = rsaPublicKey!.modulus!.bitLength ~/ 8 - 11;
      final blocksize = rsaPublicKey!.modulus!.bitLength ~/ 8;
      final numblock =
          (strlength ~/ keysize) + ((strlength % keysize != 0) ? 1 : 0);
      Uint8List list = Uint8List(blocksize * numblock);
      int count = 0;
      int strindex = 0;
      while (index < strlength) {
        Uint8List listtmp =
            data.sublist(count * blocksize, (count + 1) * blocksize);

        Uint8List result = cipher.process(listtmp);
        for (var i = 0; i < result.length; i++) {
          list[count * keysize + i] = result[i];
        }
        count += 1;
        strindex += result.length;
        index += blocksize;
      }
      return list.sublist(0, strindex);
    } catch (e) {}
    return null;
  }

  Uint8List? encryptByPrivateKey(Uint8List data) {
    try {
      /*final keyparameter =
          () => PublicKeyParameter<RSAPublicKey>(rsaPublicKey!);*/
      AsymmetricBlockCipher cipher = AsymmetricBlockCipher("RSA/PKCS1");
      cipher.reset();
      cipher.init(true, PrivateKeyParameter<RSAPrivateKey>(rsaPrivateKey!));
      int index = 0;
      int strlength = data.length;
      final keysize = rsaPublicKey!.modulus!.bitLength ~/ 8 - 11;
      final blocksize = rsaPublicKey!.modulus!.bitLength ~/ 8;
      final numblock =
          (strlength ~/ keysize) + ((strlength % keysize != 0) ? 1 : 0);
      Uint8List list = Uint8List(blocksize * numblock);
      int count = 0;
      while (index < strlength) {
        Uint8List listtmp;
        if (index + keysize > strlength) {
          listtmp = data.sublist(index, strlength);
          index = strlength;
        } else {
          listtmp = data.sublist(index, index + keysize);
          index += keysize;
        }
        Uint8List result = cipher.process(listtmp);
        for (var i = 0; i < blocksize; i++) {
          list[count * blocksize + i] = result[i];
        }
        count += 1;
      }
      return list;
    } catch (e) {}
    return null;
  }

  Uint8List? encryptByPublicKey(Uint8List data) {
    try {
      /*final keyparameter =
          () => PublicKeyParameter<RSAPublicKey>(rsaPublicKey!);*/
      AsymmetricBlockCipher cipher = AsymmetricBlockCipher("RSA/PKCS1");
      cipher.reset();
      cipher.init(true, PublicKeyParameter<RSAPublicKey>(rsaPublicKey!));
      int index = 0;
      int strlength = data.length;
      final keysize = rsaPublicKey!.modulus!.bitLength ~/ 8 - 11;
      final blocksize = rsaPublicKey!.modulus!.bitLength ~/ 8;
      final numblock =
          (strlength ~/ keysize) + ((strlength % keysize != 0) ? 1 : 0);
      Uint8List list = Uint8List(blocksize * numblock);
      int count = 0;
      while (index < strlength) {
        Uint8List listtmp;
        if (index + keysize > strlength) {
          listtmp = data.sublist(index, strlength);
          index = strlength;
        } else {
          listtmp = data.sublist(index, index + keysize);
          index += keysize;
        }
        Uint8List result = cipher.process(listtmp);
        for (var i = 0; i < blocksize; i++) {
          list[count * blocksize + i] = result[i];
        }
        count += 1;
      }
      return list;
    } catch (e) {}
    return null;
  }

  RSAAsymmetricKey? parse(String key) {
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
    return null;
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

  static RSAUtils createInstance({
    required String publicKey,
    required String privateKey,
  }) {
    return RSAUtils._internal(publicKey: publicKey, privateKey: privateKey);
  }

  static cryptoTest() {
    List<String>? list = RSAUtils.generateKeyAsString(1024);
    RSAUtils rsa =
        RSAUtils.createInstance(publicKey: list![0], privateKey: list[1]);
    String str = "Soy un salvaje!!!";
    Uint8List sstr = Uint8List.fromList(convert.utf8.encode(str));
    Uint8List? enstr = rsa.encryptByPublicKey(sstr);
    Uint8List? ssstre = rsa.decryptByPrivateKey(enstr!);

    enstr = rsa.encryptByPrivateKey(sstr);
    ssstre = rsa.encryptByPublicKey(enstr!);
  }

  static encodePrivateKeyToPemPKCS1(RSAPrivateKey privateKey) {
    final topLevel = ASN1Sequence();
    final version = ASN1Integer(BigInt.from(0));
    final modulus = ASN1Integer(privateKey.n!);
    final publicExponent = ASN1Integer(privateKey.exponent!);
    final privateExponent = ASN1Integer(privateKey.privateExponent!);
    final p = ASN1Integer(privateKey.p!);
    final q = ASN1Integer(privateKey.q!);
    final dp = privateKey.privateExponent! % (privateKey.p! - BigInt.from(1));
    final exp1 = ASN1Integer(dp);
    final dq = privateKey.privateExponent! % (privateKey.q! - BigInt.from(1));
    final exp2 = ASN1Integer(dq);
    final iq = privateKey.q!.modInverse(privateKey.p!);
    final co = ASN1Integer(iq);

    topLevel.add(version);
    topLevel.add(modulus);
    topLevel.add(publicExponent);
    topLevel.add(privateExponent);
    topLevel.add(p);
    topLevel.add(q);
    topLevel.add(exp1);
    topLevel.add(exp2);
    topLevel.add(co);
    final dataBase64 = convert.base64.encode(topLevel.encodedBytes);
    return """-----BEGIN RSA PRIVATE KEY-----\n$dataBase64\n-----END RSA PRIVATE KEY-----""";
  }

  static encodePublicKeyToPemPKCS1(RSAPublicKey publicKey) {
    final topLevel = ASN1Sequence();
    topLevel.add(ASN1Integer(publicKey.modulus!));
    topLevel.add(ASN1Integer(publicKey.exponent!));
    final dataBase64 = convert.base64.encode(topLevel.encodedBytes);
    return """-----BEGIN RSA PUBLIC KEY-----\n$dataBase64\n-----END RSA PUBLIC KEY-----""";
  }

  static List<String>? generateKeyAsString([int bits = 1024]) {
    final keys = generateKeys(bits);
    final pubKey = encodePublicKeyToPemPKCS1(keys[0] as RSAPublicKey);
    final privKey = encodePrivateKeyToPemPKCS1(keys[1] as RSAPrivateKey);
    return [pubKey, privKey];
  }

  static List<RSAAsymmetricKey> generateKeys([int bits = 1024]) {
    final rnd = getSecureRandom();
    final rsapair = RSAKeyGeneratorParameters(BigInt.parse("65537"), bits, 64);
    final params = ParametersWithRandom(rsapair, rnd);
    final keyGenerator = KeyGenerator("RSA");
    keyGenerator.init(params);
    AsymmetricKeyPair<PublicKey, PrivateKey> keypair =
        keyGenerator.generateKeyPair();
    RSAPrivateKey privateKey = keypair.privateKey as RSAPrivateKey;
    RSAPublicKey publicKey = keypair.publicKey as RSAPublicKey;

    return [publicKey, privateKey];
  }

  static SecureRandom getSecureRandom() {
    final secureRandom = FortunaRandom();
    final random = Random.secure();
    List<int> seeds = [];
    for (var i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }
}
