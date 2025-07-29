import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui show instantiateImageCodec, Codec, ImmutableBuffer;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import '/app/core/config/assets.dart';
import '/app/core/services/local_storage.dart';
import '/app/core/services/logger_service.dart';

class NetworkImageSSL extends ImageProvider<NetworkImageSSL> {
  static final HttpClient _httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

  final String url;

  final double scale;

  final bool allowUpscaling;

  final bool allowCache;

  final int? cacheWidth, cacheHeight;

  final Map<String, String> headers;

  const NetworkImageSSL(
    this.url, {
    this.scale = 1.0,
    this.headers = const {},
    this.allowUpscaling = true,
    this.allowCache = true,
    this.cacheHeight = 16,
    this.cacheWidth = 16,
  });

  @override
  int get hashCode => Object.hash(url, scale);

  Future<bool> get wasCached =>
      LocalSecureStorage.storage.existsOnSecureStorage(url);

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final NetworkImageSSL typedOther = other;
    return url == typedOther.url && scale == typedOther.scale;
  }

  Future<void> evic() {
    final storage = LocalSecureStorage.storage;
    return storage.delete(url);
  }

  @override
  ImageStreamCompleter load(NetworkImageSSL key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, null, decode),
      scale: key.scale,
    );
  }

  @override
  ImageStreamCompleter loadBuffer(
      NetworkImageSSL key, DecoderBufferCallback decode) {
    try {
      Future<ui.Codec> decodeResize(ui.ImmutableBuffer buffer,
          {int? cacheWidth, int? cacheHeight, bool? allowUpscaling}) {
        assert(
          cacheWidth == null && cacheHeight == null && allowUpscaling == null,
          'ResizeImage cannot be composed with another ImageProvider that applies '
          'cacheWidth, cacheHeight, or allowUpscaling.',
        );
        return decode(
          buffer,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
          allowUpscaling: this.allowUpscaling,
        );
      }

      InformationCollector? collector;
      assert(() {
        collector = () => <DiagnosticsNode>[
              DiagnosticsProperty<ImageProvider>('Image provider', this),
              DiagnosticsProperty<NetworkImageSSL>('Image key', key),
            ];
        return true;
      }());
      return MultiFrameImageStreamCompleter(
        codec: _loadAsync(
            key,
            cacheWidth == null && cacheHeight == null ? decode : decodeResize,
            null),
        scale: key.scale,
        debugLabel: key.url,
        informationCollector: collector,
      );
    } on Exception catch (e) {
      log(e.toString());
    }
    //Por si falla la carga remota de la imagen muestra una desde los assets
    return MultiFrameImageStreamCompleter(
      codec: _loadAsyncFromLocal(),
      scale: key.scale,
    );
  }

  @override
  Future<NetworkImageSSL> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<NetworkImageSSL>(this);
  }

  @override
  String toString() => '$runtimeType("$url", scale: $scale)';

  Future<ui.Codec> _loadAsync(NetworkImageSSL key,
      DecoderBufferCallback? decode, DecoderCallback? decodeDeprecated) async {
    final String codec = allowCache && await wasCached
        ? await LocalSecureStorage.storage.read(key.url) ?? ""
        : "";
    if (codec.isNotEmpty) {
      return Future.value(
          ui.instantiateImageCodec(Uint8List.fromList(codec.codeUnits)));
    }
    assert(key == this);
    final storage = LocalSecureStorage.storage;
    if (!storage.hasData(key.url)) {
      final Uri resolved = Uri.base.resolve(key.url);
      try {
        final HttpClientRequest request = await _httpClient.getUrl(resolved);
        headers.forEach((String name, String value) {
          request.headers.add(name, value);
        });
        final HttpClientResponse response = await request.close();
        if (response.statusCode != HttpStatus.ok) {
          return _loadAsyncFromLocal();
          //throw Exception('HTTP request failed, statusCode: ${response.statusCode}. Imposible acceder al recurso remoto en: $resolved');
        }

        final Uint8List bytes =
            await consolidateHttpClientResponseBytes(response);
        if (bytes.lengthInBytes == 0) {
          throw Exception('NetworkImageSSL is an empty file: $resolved');
        }
        final image = await ui.instantiateImageCodec(bytes);
        await storage.write(key.url, String.fromCharCodes(bytes));
        return image;
      } on SocketException {
        return _loadAsyncFromLocal();
      }
    } else {
      final savedImg = await storage.read(key.url);
      if (savedImg == null) {
        throw Exception(
            "Error reading saved image from cache on LocalSecureStorage.\nSource:${key.url}");
      }
      return await ui
          .instantiateImageCodec(Uint8List.fromList(savedImg.codeUnits));
    }
  }

  Future<ui.Codec> _loadAsyncFromLocal() async {
    final bytes = await rootBundle.load(ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG);
    if (bytes.lengthInBytes == 0) {
      throw Exception(
          'NetworkImageSSL is an empty file: $ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG');
    }
    Uint8List audioUint8List =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    final image = await ui.instantiateImageCodec(audioUint8List);
    return image;
  }
}
