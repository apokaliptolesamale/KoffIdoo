import 'dart:ui' as ui;

import 'package:dio/io.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class NetworkImageSSL extends ImageProvider<NetworkImageSSL> {
  final String url;
  final double scale;

  NetworkImageSSL(this.url, {this.scale = 1.0});

  @override
  ImageStreamCompleter loadImage(
      NetworkImageSSL key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: key.scale,
      informationCollector: () sync* {
        yield DiagnosticsProperty<ImageProvider>('Image provider', this);
        yield DiagnosticsProperty<NetworkImageSSL>('Image key', key);
      },
    );
  }

  Future<ui.Codec> _loadAsync(
      NetworkImageSSL key, ImageDecoderCallback decode) async {
    assert(key == this);

    final Dio dio = createDioClient();
    final Response<List<int>> response = await dio.get<List<int>>(
      key.url,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );

    if (response.statusCode == 200) {
      Uint8List uint8list = Uint8List.fromList(response.data!);
      return decode(await ui.ImmutableBuffer.fromUint8List(uint8list)
          //Uint8List.fromList(response.data!)
          );
    } else {
      throw Exception('Failed to load network image.');
    }
  }

  @override
  Future<NetworkImageSSL> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<NetworkImageSSL>(this);
  }
}

Dio createDioClient() {
  var dio = Dio();
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    HttpClient client = HttpClient();
    client.badCertificateCallback = (cert, host, port) => true;
    return client;
  };
  return dio;
}
