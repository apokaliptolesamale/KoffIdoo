import 'dart:convert';
import 'dart:developer';

import 'package:convert/convert.dart' as co;
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart' as l;

import '../../../../../remote/basic_utils/basic_utils.dart';

class ExtractPublicKeyFromCert {
  Future<l.RSAPublicKey> getRsaPublicKeyFromBank(String certificateBank) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String decodeCrt = stringToBase64.decode(certificateBank);
    log('Este es el certificado ==> $decodeCrt');
    X509CertificateData pem = X509Utils.x509CertificateFromPem(decodeCrt);
    TbsCertificate certificate = pem.tbsCertificate!;
    var publicKeyInfo = certificate.subjectPublicKeyInfo;
    final hex = co.hex.decode(publicKeyInfo.bytes!);
    log('Este es el hex==> $hex');
    final publicKey =
        CryptoUtils.rsaPublicKeyFromDERBytes(Uint8List.fromList(hex));
    log('Esta es la publicKey==> ${publicKey.toString()}');

    return publicKey;
  }

  Future<l.RSAPublicKey> getRsaPublicKeyFromPem(String certificatePem) async {
    final load = await rootBundle.loadString(certificatePem);
    X509CertificateData pem = X509Utils.x509CertificateFromPem(load);
    log('Este es el Pem==> $certificatePem');
    TbsCertificate certificate = pem.tbsCertificate!;
    var publicKeyInfo = certificate.subjectPublicKeyInfo;
    final hex = co.hex.decode(publicKeyInfo.bytes!);
    log('Este es el hex==> $hex');
    final publicKey =
        CryptoUtils.rsaPublicKeyFromDERBytes(Uint8List.fromList(hex));
    log('Esta es la publicKey==> ${publicKey.toString()}');

    return publicKey;
  }

  Future<l.RSAPublicKey> getRsaPublicKeyFromStringCert(
      String certificateString) async {
    X509CertificateData pem =
        X509Utils.x509CertificateFromPem(certificateString);
    log('Este es el Pem==> $certificateString');
    TbsCertificate certificate = pem.tbsCertificate!;
    var publicKeyInfo = certificate.subjectPublicKeyInfo;
    final hex = co.hex.decode(publicKeyInfo.bytes!);
    log('Este es el hex==> $hex');
    final publicKey =
        CryptoUtils.rsaPublicKeyFromDERBytes(Uint8List.fromList(hex));
    log('Esta es la publicKey==> ${publicKey.toString()}');

    return publicKey;
  }
}
