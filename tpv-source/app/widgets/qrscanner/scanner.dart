// export 'src/types/features.dart';

// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/core/services/logger_service.dart';
import '../../../globlal_constants.dart';
import '../../core/helpers/functions.dart';

//

Widget createWebQrView(
        {onPlatformViewCreated, onPermissionSet, CameraFacing? cameraFacing}) =>
    const SizedBox();
// export 'src/types/camera_exception.dart';

typedef PermissionSetCallback = void Function(QRViewController, bool);
//  export 'src/qr_code_scanner.dart';

typedef QRViewCreatedCallback = void Function(QRViewController controller);

/// The [Barcode] object holds information about the barcode or qr code.
///
/// [code] is the string-content of the barcode.
/// [format] displays which type the code is.
/// Only for Android and iOS, [rawBytes] gives a list of bytes of the result.
class Barcode {
  final String? code;

  final BarcodeFormat format;

  /// Raw bytes are only supported by Android and iOS.
  final List<int>? rawBytes;

  Barcode(this.code, this.format, this.rawBytes);
}

// export 'src/types/barcode_format.dart';

enum BarcodeFormat {
  /// Aztec 2D barcode format.
  aztec,

  /// CODABAR 1D format.
  /// Not supported in iOS
  codabar,

  /// Code 39 1D format.
  code39,

  /// Code 93 1D format.
  code93,

  /// Code 128 1D format.
  code128,

  /// Data Matrix 2D barcode format.
  dataMatrix,

  /// EAN-8 1D format.
  ean8,

  /// EAN-13 1D format.
  ean13,

  /// ITF (Interleaved Two of Five) 1D format.
  itf,

  /// MaxiCode 2D barcode format.
  /// Not supported in iOS.
  maxicode,

  /// PDF417 format.
  pdf417,

  /// QR Code 2D barcode format.
  qrcode,

  /// RSS 14
  /// Not supported in iOS.
  rss14,

  /// RSS EXPANDED
  /// Not supported in iOS.
  rssExpanded,

  /// UPC-A 1D format.
  /// Same as ean-13 on iOS.
  upcA,

  /// UPC-E 1D format.
  upcE,

  /// UPC/EAN extension format. Not a stand-alone format.
  upcEanExtension,

  /// Unknown
  unknown
}

//export 'src/types/barcode.dart';

/// This is thrown when the plugin reports an error.
class CameraException implements Exception {
  /// Error code.
  String code;

  /// Textual description of the error.
  String? description;

  /// Creates a new camera exception with the given error code and description.
  CameraException(this.code, this.description);

  @override
  String toString() => 'CameraException($code, $description)';
}

//export 'src/types/camera.dart';

enum CameraFacing {
  /// Shows back facing camera.
  back,

  /// Shows front facing camera.
  front,

  /// Unknown camera
  unknown
}

// import 'lifecycle_event_handler.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  late final AsyncCallback resumeCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
    }
  }
}
// export 'src/qr_scanner_overlay_shape.dart';

class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;

  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  late double cutOutWidth;
  late double cutOutHeight;
  final double cutOutBottomOffset;
  QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 3.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 80),
    this.borderRadius = 0,
    this.borderLength = 40,
    double? cutOutSizeParams = 250,
    double? cutOutWidthParams,
    double? cutOutHeightParqams = 250,
    this.cutOutBottomOffset = 0,
  }) {
    cutOutWidth = cutOutWidthParams ?? cutOutSizeParams ?? 250;
    cutOutHeight = cutOutHeightParqams ?? cutOutSizeParams ?? 250;
    assert(
      borderLength <= min(cutOutWidth, cutOutHeight) / 2 + borderWidth * 2,
      "Border can't be larger than ${min(cutOutWidth, cutOutHeight) / 2 + borderWidth * 2}",
    );
  }

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return _getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final borderWidthSize = width / 2;
    final height = rect.height;
    final borderOffset = borderWidth / 2;
    var borderLength = this.borderLength >
            min(this.cutOutHeight, this.cutOutHeight) / 2 + borderWidth * 2
        ? borderWidthSize / 2
        : this.borderLength;
    var cutOutWidth =
        this.cutOutWidth < width ? this.cutOutWidth : width - borderOffset;
    var cutOutHeight =
        this.cutOutHeight < height ? this.cutOutHeight : height - borderOffset;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final boxPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - cutOutWidth / 2 + borderOffset,
      -cutOutBottomOffset +
          rect.top +
          height / 2 -
          cutOutHeight / 2 +
          borderOffset,
      cutOutWidth - borderOffset * 2,
      cutOutHeight - borderOffset * 2,
    );

    canvas
      ..saveLayer(
        rect,
        backgroundPaint,
      )
      ..drawRect(
        rect,
        backgroundPaint,
      )
      // Draw top right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - borderLength,
          cutOutRect.top,
          cutOutRect.right,
          cutOutRect.top + borderLength,
          topRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw top left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.top,
          cutOutRect.left + borderLength,
          cutOutRect.top + borderLength,
          topLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - borderLength,
          cutOutRect.bottom - borderLength,
          cutOutRect.right,
          cutOutRect.bottom,
          bottomRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.bottom - borderLength,
          cutOutRect.left + borderLength,
          cutOutRect.bottom,
          bottomLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          cutOutRect,
          Radius.circular(borderRadius),
        ),
        boxPaint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}

/// The [QRView] is the view where the camera
/// and the barcode scanner gets displayed.
class QRView extends StatefulWidget {
  /// [onQRViewCreated] gets called when the view is created
  final QRViewCreatedCallback onQRViewCreated;

  /// Use [overlay] to provide an overlay for the view.
  /// This can be used to create a certain scan area.
  final QrScannerOverlayShape? overlay;

  /// Use [overlayMargin] to provide a margin to [overlay]
  final EdgeInsetsGeometry overlayMargin;

  /// Set which camera to use on startup.
  ///
  /// [cameraFacing] can either be CameraFacing.front or CameraFacing.back.
  /// Defaults to CameraFacing.back
  final CameraFacing cameraFacing;

  /// Calls the provided [onPermissionSet] callback when the permission is set.
  final PermissionSetCallback? onPermissionSet;

  /// Use [formatsAllowed] to specify which formats needs to be scanned.
  final List<BarcodeFormat> formatsAllowed;

  const QRView({
    required Key key,
    required this.onQRViewCreated,
    this.overlay,
    this.overlayMargin = EdgeInsets.zero,
    this.cameraFacing = CameraFacing.back,
    this.onPermissionSet,
    this.formatsAllowed = const <BarcodeFormat>[],
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewState();
}

class QRViewController {
  final MethodChannel _channel;

  final CameraFacing _cameraFacing;
  final StreamController<Barcode> _scanUpdateController =
      StreamController<Barcode>();
  bool _hasPermissions = false;

  QRViewController._(MethodChannel channel, GlobalKey? qrKey,
      PermissionSetCallback? onPermissionSet, CameraFacing cameraFacing)
      : _channel = channel,
        _cameraFacing = cameraFacing {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onRecognizeQR':
          if (call.arguments != null) {
            final args = call.arguments as Map;
            final code = args['code'] as String?;
            final rawType = args['type'] as String;
            // Raw bytes are only supported by Android.
            final rawBytes = args['rawBytes'] as List<int>?;
            final format = BarcodeTypesExtension.fromString(rawType);
            if (format != BarcodeFormat.unknown) {
              final barcode = Barcode(code, format, rawBytes);
              _scanUpdateController.sink.add(barcode);
            } else {
              throw Exception('Unexpected barcode type $rawType');
            }
          }
          break;
        case 'onPermissionSet':
          if (call.arguments != null && call.arguments is bool) {
            _hasPermissions = call.arguments;
            if (onPermissionSet != null) {
              onPermissionSet(this, _hasPermissions);
            }
          }
          break;
      }
    });
  }

  bool get hasPermissions => _hasPermissions;
  Stream<Barcode> get scannedDataStream => _scanUpdateController.stream;

  /// Stops the camera and disposes the barcode stream.
  void dispose() {
    if (defaultTargetPlatform == TargetPlatform.iOS) stopCamera();
    _scanUpdateController.close();
  }

  /// Flips the camera between available modes
  Future<CameraFacing> flipCamera() async {
    try {
      return CameraFacing
          .values[await _channel.invokeMethod('flipCamera') as int];
    } on PlatformException catch (e) {
      throw CameraException(e.code, e.message);
    }
  }

  /// Gets information about which camera is active.
  Future<CameraFacing> getCameraInfo() async {
    try {
      var cameraFacing = await _channel.invokeMethod('getCameraInfo') as int;
      if (cameraFacing == -1) return _cameraFacing;
      return CameraFacing
          .values[await _channel.invokeMethod('getCameraInfo') as int];
    } on PlatformException catch (e) {
      throw CameraException(e.code, e.message);
    }
  }

  /// Get flashlight status
  Future<bool?> getFlashStatus() async {
    try {
      return await _channel.invokeMethod('getFlashInfo');
    } on PlatformException catch (e) {
      throw CameraException(e.code, e.message);
    }
  }

  /// Returns which features are available on device.
  Future<SystemFeatures> getSystemFeatures() async {
    try {
      var features =
          await _channel.invokeMapMethod<String, dynamic>('getSystemFeatures');
      if (features != null) {
        return SystemFeatures.fromJson(features);
      }
      throw CameraException('Error', 'Could not get system features');
    } on PlatformException catch (e) {
      throw CameraException(e.code, e.message);
    }
  }

  /// Pauses the camera and barcode scanning
  Future<void> pauseCamera() async {
    try {
      await _channel.invokeMethod('pauseCamera');
    } on PlatformException catch (e) {
      throw CameraException(e.code, e.message);
    }
  }

  /// Resumes barcode scanning
  Future<void> resumeCamera() async {
    try {
      await _channel.invokeMethod('resumeCamera');
    } on PlatformException catch (e) {
      throw CameraException(e.code, e.message);
    }
  }

  //Starts/Stops invert scanning.
  Future<void> scanInvert(bool isScanInvert) async {
    if (defaultTargetPlatform == getTargetPlatform()) {
      try {
        await _channel
            .invokeMethod('invertScan', {"isInvertScan": isScanInvert});
      } on PlatformException catch (e) {
        throw CameraException(e.code, e.message);
      }
    }
  }

  /// Stops barcode scanning and the camera
  Future<void> stopCamera() async {
    try {
      await _channel.invokeMethod('stopCamera');
    } on PlatformException catch (e) {
      throw CameraException(e.code, e.message);
    }
  }

  /// Toggles the flashlight between available modes
  Future<void> toggleFlash() async {
    try {
      await _channel.invokeMethod('toggleFlash') as bool?;
    } on PlatformException catch (e) {
      throw CameraException(e.code, e.message);
    }
  }

  /// Starts the barcode scanner
  Future<void> _startScan(GlobalKey key, QrScannerOverlayShape? overlay,
      List<BarcodeFormat>? barcodeFormats) async {
    // We need to update the dimension before the scan is started.
    try {
      await QRViewController.updateDimensions(key, _channel, overlay: overlay);
      return await _channel.invokeMethod(
          'startScan', barcodeFormats?.map((e) => e.asInt()).toList() ?? []);
    } on PlatformException catch (e) {
      throw CameraException(e.code, e.message);
    }
  }

  /// Updates the view dimensions for iOS.
  static Future<bool> updateDimensions(GlobalKey key, MethodChannel channel,
      {QrScannerOverlayShape? overlay}) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      // Add small delay to ensure the render box is loaded
      await Future.delayed(const Duration(milliseconds: 300));
      if (key.currentContext == null) return false;
      final renderBox = key.currentContext!.findRenderObject() as RenderBox;
      try {
        await channel.invokeMethod('setDimensions', {
          'width': renderBox.size.width,
          'height': renderBox.size.height,
          'scanAreaWidth': overlay?.cutOutWidth ?? 0,
          'scanAreaHeight': overlay?.cutOutHeight ?? 0,
          'scanAreaOffset': overlay?.cutOutBottomOffset ?? 0
        });
        return true;
      } on PlatformException catch (e) {
        throw CameraException(e.code, e.message);
      }
    } else if (defaultTargetPlatform == getTargetPlatform()) {
      if (overlay == null) {
        return false;
      }
      await channel.invokeMethod('changeScanArea', {
        'scanAreaWidth': overlay.cutOutWidth,
        'scanAreaHeight': overlay.cutOutHeight,
        'cutOutBottomOffset': overlay.cutOutBottomOffset
      });
      return true;
    }
    return false;
  }
}

//if (dart.library.html) 'web/flutter_qr_web.dart';

class SystemFeatures {
  final bool hasFlash;

  final bool hasFrontCamera;

  final bool hasBackCamera;
  SystemFeatures(this.hasFlash, this.hasBackCamera, this.hasFrontCamera);
  factory SystemFeatures.fromJson(Map<String, dynamic> features) =>
      SystemFeatures(
          features['hasFlash'] ?? false,
          features['hasBackCamera'] ?? false,
          features['hasFrontCamera'] ?? false);
}

class _QrCameraSettings {
  final CameraFacing cameraFacing;

  _QrCameraSettings({
    this.cameraFacing = CameraFacing.unknown,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cameraFacing': cameraFacing.index,
    };
  }
}

class _QRViewState extends State<QRView> {
  late MethodChannel _channel;
  late LifecycleEventHandler _observer;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: SizeChangedLayoutNotifier(
        child: (widget.overlay != null)
            ? _getPlatformQrViewWithOverlay()
            : _getPlatformQrView(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(_observer);
  }

  @override
  void initState() {
    super.initState();
    _observer = LifecycleEventHandler(resumeCallBack: updateDimensions);
    WidgetsBinding.instance.addObserver(_observer);
  }

  bool onNotification(notification) {
    updateDimensions();
    return false;
  }

  Future<void> updateDimensions() async {
    await QRViewController.updateDimensions(
        widget.key as GlobalKey<State<StatefulWidget>>, _channel,
        overlay: widget.overlay);
  }

  Widget _getPlatformQrView() {
    Widget platformQrView;
    if (kIsWeb) {
      platformQrView = createWebQrView(
        onPlatformViewCreated: widget.onQRViewCreated,
        onPermissionSet: widget.onPermissionSet,
        cameraFacing: widget.cameraFacing,
      );
    } else {
      log("Plataforma:$defaultTargetPlatform");
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          platformQrView = AndroidView(
            viewType: '$globalApplicationId/qrview',
            onPlatformViewCreated: _onPlatformViewCreated,
            creationParams:
                _QrCameraSettings(cameraFacing: widget.cameraFacing).toMap(),
            creationParamsCodec: const StandardMessageCodec(),
          );
          break;
        case TargetPlatform.iOS:
          platformQrView = UiKitView(
            viewType: '$globalApplicationId/qrview',
            onPlatformViewCreated: _onPlatformViewCreated,
            creationParams:
                _QrCameraSettings(cameraFacing: widget.cameraFacing).toMap(),
            creationParamsCodec: const StandardMessageCodec(),
          );
          break;
        default:
          throw UnsupportedError(
              "Trying to use the default qrview implementation for $defaultTargetPlatform but there isn't a default one");
      }
    }
    return platformQrView;
  }

  Widget _getPlatformQrViewWithOverlay() {
    return Stack(
      children: [
        _getPlatformQrView(),
        Padding(
          padding: widget.overlayMargin,
          child: Container(
            decoration: ShapeDecoration(
              shape: widget.overlay!,
            ),
          ),
        )
      ],
    );
  }

  void _onPlatformViewCreated(int id) {
    _channel = MethodChannel('$globalApplicationId/qrview_$id');

    // Start scan after creation of the view
    final controller = QRViewController._(
        _channel,
        widget.key as GlobalKey<State<StatefulWidget>>?,
        widget.onPermissionSet,
        widget.cameraFacing)
      .._startScan(widget.key as GlobalKey<State<StatefulWidget>>,
          widget.overlay, widget.formatsAllowed);

    // Initialize the controller for controlling the QRView
    widget.onQRViewCreated(controller);
  }
}

extension BarcodeTypesExtension on BarcodeFormat {
  String get formatName {
    switch (this) {
      case BarcodeFormat.aztec:
        return 'AZTEC';
      case BarcodeFormat.codabar:
        return 'CODABAR';
      case BarcodeFormat.code39:
        return 'CODE_39';
      case BarcodeFormat.code93:
        return 'CODE_93';
      case BarcodeFormat.code128:
        return 'CODE_128';
      case BarcodeFormat.dataMatrix:
        return 'DATA_MATRIX';
      case BarcodeFormat.ean8:
        return 'EAN_8';
      case BarcodeFormat.ean13:
        return 'EAN_13';
      case BarcodeFormat.itf:
        return 'ITF';
      case BarcodeFormat.maxicode:
        return 'MAXICODE';
      case BarcodeFormat.pdf417:
        return 'PDF_417';
      case BarcodeFormat.qrcode:
        return 'QR_CODE';
      case BarcodeFormat.rss14:
        return 'RSS14';
      case BarcodeFormat.rssExpanded:
        return 'RSS_EXPANDED';
      case BarcodeFormat.upcA:
        return 'UPC_A';
      case BarcodeFormat.upcE:
        return 'UPC_E';
      case BarcodeFormat.upcEanExtension:
        return 'UPC_EAN_EXTENSION';
      default:
        return 'UNKNOWN';
    }
  }

  int asInt() {
    return index;
  }

  static BarcodeFormat fromString(String format) {
    switch (format) {
      case 'AZTEC':
        return BarcodeFormat.aztec;
      case 'CODABAR':
        return BarcodeFormat.codabar;
      case 'CODE_39':
        return BarcodeFormat.code39;
      case 'CODE_93':
        return BarcodeFormat.code93;
      case 'CODE_128':
        return BarcodeFormat.code128;
      case 'DATA_MATRIX':
        return BarcodeFormat.dataMatrix;
      case 'EAN_8':
        return BarcodeFormat.ean8;
      case 'EAN_13':
        return BarcodeFormat.ean13;
      case 'ITF':
        return BarcodeFormat.itf;
      case 'MAXICODE':
        return BarcodeFormat.maxicode;
      case 'PDF_417':
        return BarcodeFormat.pdf417;
      case 'QR_CODE':
        return BarcodeFormat.qrcode;
      case 'RSS14':
        return BarcodeFormat.rss14;
      case 'RSS_EXPANDED':
        return BarcodeFormat.rssExpanded;
      case 'UPC_A':
        return BarcodeFormat.upcA;
      case 'UPC_E':
        return BarcodeFormat.upcE;
      case 'UPC_EAN_EXTENSION':
        return BarcodeFormat.upcEanExtension;
      default:
        return BarcodeFormat.unknown;
    }
  }
}
