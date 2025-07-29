import 'dart:developer';

import 'package:encrypt/encrypt.dart';
import 'extractPublicKeyFromCrt.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart' as l;

class RSAEncrypt {
  Future<String> getEncryptCertBank(RSAEncoding rsaEncoding,
      String certificateBank, String stringEncrypt) async {
    var publicKey = await ExtractPublicKeyFromCert()
        .getRsaPublicKeyFromBank(certificateBank);
    final encrypter =
        Encrypter(RSA(encoding: rsaEncoding, publicKey: publicKey));
    final encrypted = encrypter.encrypt(stringEncrypt);
    final encryptedb64 = encrypted.base64;
    log('Esta es la cadena encryptada en base 64==> $encryptedb64');
    return encryptedb64;
  }

  Future<String> getEncryptPublicKey(
      RSAEncoding rsaEncoding, String stringEncrypt, String path) async {
    var load = await rootBundle.loadString(path);
    var publicKey = RSAKeyParser().parse(load) as l.RSAPublicKey;
    final encrypter =
        Encrypter(RSA(encoding: rsaEncoding, publicKey: publicKey));
    final encrypted = encrypter.encrypt(stringEncrypt);
    final encryptedb64 = encrypted.base64;
    log('Esta es la cadena encryptada en base 64==> $encryptedb64');
    return encryptedb64;
  }

  Future<String> getEncryptCertPem(RSAEncoding rsaEncoding,
      String certificateBank, String stringEncrypt) async {
    var publicKey = await ExtractPublicKeyFromCert()
        .getRsaPublicKeyFromPem(certificateBank);
    final encrypter =
        Encrypter(RSA(encoding: rsaEncoding, publicKey: publicKey));
    final encrypted = encrypter.encrypt(stringEncrypt);
    final encryptedb64 = encrypted.base64;
    log('Esta es la cadena encryptada en base 64==> $encryptedb64');
    return encryptedb64;
  }
}
