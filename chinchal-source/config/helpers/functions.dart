import 'dart:convert';

import 'package:intl/intl.dart';

String decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');
  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }
  return utf8.decode(base64Url.decode(output));
}
    
    String decodeIdToken(String idToken) {
  final parts = idToken.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }
  var decode = decodeBase64(parts[1]);
  return decode;
}

String slashFormatDate(dynamic date) {
  if (date is DateTime) {
    return DateFormat("dd/MM/yyyy")
        .format(date)
        .replaceRange(10, null, '')
        .replaceAll('-', '/');
  } else if (date is String) {
    return date.replaceRange(10, null, '').replaceAll('-', '/');
  }
  return date ?? "";
}

String slashFormatTime(dynamic date) {
  if (date is DateTime) {
    return DateFormat("dd/MM/yyyy")
        .format(date)
        .replaceRange(10, null, '')
        .replaceAll('-', '/');
  } else if (date is String) {
    return date
        .replaceRange(0, 11, '')
        .replaceAll('-', '/')
        .replaceRange(5, null, '');
  }
  return date ?? "";
}