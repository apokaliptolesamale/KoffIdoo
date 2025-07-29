// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '/app/core/helpers/snapshot.dart';
import '/app/core/interfaces/header_request.dart';
import '/app/widgets/botton/custom_flat_botton.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/utils/loading.dart';
import '../../../../app/widgets/promise/custom_future_builder.dart';
import '../../core/config/assets.dart';
import '../../core/helpers/store_short_cuts.dart';
import '../botton/custom_bottom_nav_bar.dart';
import '../images/background_image.dart';
import 'animated_notification.dart';
import 'bell.dart';

class CustomPdfViewer extends StatefulWidget {
  String url, name;
  String? password;
  bool canShowScrollHead,
      canShowScrollStatus,
      canShowPaginationDialog,
      canShowPasswordDialog,
      enableDoubleTapZooming,
      enableDocumentLinkAnnotation;
  PdfPageLayoutMode pageLayoutMode;
  PdfScrollDirection scrollDirection;
  LoadOptionMode mode;
  CustomPdfViewer({
    Key? key,
    required this.url,
    required this.name,
    this.mode = LoadOptionMode.fromBase64,
    this.password,
    this.canShowScrollHead = false,
    this.canShowScrollStatus = false,
    this.canShowPaginationDialog = false,
    this.canShowPasswordDialog = false,
    this.enableDoubleTapZooming = false,
    this.enableDocumentLinkAnnotation = false,
    this.pageLayoutMode = PdfPageLayoutMode.single,
    this.scrollDirection = PdfScrollDirection.horizontal,
  });

  @override
  State<CustomPdfViewer> createState() => _CustomPdfViewerState();
}

enum LoadOptionMode { fromBase64, fromRemoteUrl, fromAssets, fromFile }

class _CustomPdfViewerState extends State<CustomPdfViewer> {
  PdfViewerController? _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfTextSearchResult _searchResult;
  bool isSaveing = false;
  bool isSigning = false;
  OverlayEntry? _overlayEntry;
  Uint8List? pdfData;

  CustomAnimatedNotification notification =
      CustomAnimatedNotificationSingleton().create(
          message: "Creando Certificado de garantía en breve.",
          icon: BellWidget(
            autoRing: true,
            duration: Duration(
              seconds: 3,
            ),
          ),
          alignment: Alignment.topRight,
          duration: Duration(
            seconds: 3,
          ));

  @override
  Widget build(BuildContext context) {
    const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: CustomBotoonNavBar.fromRoute(
            Get.currentRoute,
            listOfPages: getListOfPages,
          ),
          appBar: AppBar(
            backgroundColor: Color(0xFF00b1a4),
            title: Text(
              widget.name,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  !isSaveing ? Icons.save : Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (pdfData != null) {
                    save2Local(pdfData!, "Cerfificado de garantía");
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.zoom_in,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (_pdfViewerController != null) {
                    _pdfViewerController!.zoomLevel = 2;
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (_pdfViewerController != null) {
                    _pdfViewerController!.previousPage();
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (_pdfViewerController != null) {
                    _pdfViewerController!.nextPage();
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.bookmark,
                  color: Colors.white,
                ),
                onPressed: () {
                  _pdfViewerKey.currentState?.openBookmarkView();
                },
              ),
              //to search
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (_pdfViewerController != null) {
                    _searchResult = _pdfViewerController!.searchText(
                      'la',
                      searchOption: TextSearchOption.caseSensitive,
                    );
                  }
                  if (kIsWeb) {
                    setState(() {});
                  } else {
                    _searchResult.addListener(() {
                      if (_searchResult.hasResult) {
                        setState(() {});
                      }
                    });
                  }
                },
              ),
              Visibility(
                visible: _searchResult.hasResult,
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _searchResult.clear();
                    });
                  },
                ),
              ),
              Visibility(
                visible: _searchResult.hasResult,
                child: IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _searchResult.previousInstance();
                  },
                ),
              ),
              Visibility(
                visible: _searchResult.hasResult,
                child: IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _searchResult.nextInstance();
                  },
                ),
              ),
              IconButton(
                icon: Icon(
                  !isSigning ? Icons.check : Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (pdfData != null) {
                    //Firmar el certificado
                  }
                },
              ),
            ],
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              SafeArea(
                child: _getByMode(widget.mode),
              ),
              notification
            ],
          ),
        )
      ],
    );
  }

  Future<Uint8List?> getFromUrl(String url) async {
    final header = HeaderRequestImpl(
        idpKey: "apiez", headers: {"accept": "application/xml"});
    final headers = await header.getHeaders();
    try {
      final result = await get(
        Uri.parse(url),
        headers: headers,
      );
      return base64Decode(result.body);
    } catch (ex) {
      return Future.value(null);
    }
  }

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    super.initState();
    isSaveing = false;
  }

  Future<bool> save2Local(Uint8List bytes, String name) async {
    // Crea un documento PDF desde el Uint8List
    final PdfDocument document = PdfDocument(inputBytes: bytes);

    // Agrega anotaciones, marcadores u otras características al documento aquí

    // Guarda el documento PDF en la memoria externa del dispositivo
    final fileName = '$name.pdf';
    final Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      final String path = directory.path;
      final File file = File('$path/$fileName');
      await file.writeAsBytes(await document.save());
      setState(() {
        notification = CustomAnimatedNotificationSingleton().create(
          message: "Descarga completada satisfactoriamente.",
          icon: BellWidget(
            autoRing: true,
            autoRemove: true,
            duration: Duration(
              seconds: 3,
            ),
          ),
          alignment: Alignment.topRight,
        );
      });
      return Future.value(true);
    } else {
      setState(() {
        notification = CustomAnimatedNotificationSingleton().create(
          message:
              "Error al intentar guardar el certificado en almacenamiento local.",
          icon: BellWidget(
            autoRing: true,
            duration: Duration(
              seconds: 3,
            ),
          ),
          alignment: Alignment.topRight,
        );
      });
    }
    return Future.value(false);
  }

  Widget _fromBase64() {
    return CustomFutureBuilder(
      context: context,
      future: pdfData == null ? getFromUrl(widget.url) : Future.value(pdfData),
      builder: (context, snapshot) {
        final loading =
            Loading.fromText(text: "Cargando certificado de garantía...");
        if (isWaiting(snapshot)) {
          return EmptyDataSearcherResult(
            child: loading,
          );
        } else if (isDone(snapshot)) {
          pdfData = snapshot.data as Uint8List;
          isSaveing = false;
          return SfPdfViewer.memory(
            pdfData!,
            key: _pdfViewerKey,
            password: widget.password,
            canShowScrollHead: widget.canShowScrollHead,
            canShowScrollStatus: widget.canShowScrollStatus,
            canShowPaginationDialog: widget.canShowPaginationDialog,
            canShowPasswordDialog: widget.canShowPasswordDialog,
            enableDocumentLinkAnnotation: widget.enableDocumentLinkAnnotation,
            controller: _pdfViewerController,
            currentSearchTextHighlightColor: Colors.yellow.withOpacity(0.6),
            otherSearchTextHighlightColor: Colors.yellow.withOpacity(0.3),
            onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
              if (details.selectedText == null && _overlayEntry != null) {
                _overlayEntry!.remove();
                //_overlayEntry = null;
              } else if (details.selectedText != null &&
                  _overlayEntry == null) {
                _showContextMenu(context, details);
              }
            },
          );
        } else if (isError(snapshot)) {
          return EmptyDataSearcherResult(
            child: Loading.fromText(
                text:
                    "Ha ocurrido un error al acceder al certificado de garantía."),
          );
        }
        return loading;
      },
    );
  }

  Widget _getByMode(LoadOptionMode mode) {
    switch (mode) {
      case LoadOptionMode.fromBase64:
        return _fromBase64();
      default:
    }
    return Container();
  }

  void _showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 55,
        left: details.globalSelectedRegion!.bottomLeft.dx,
        child: CustomFlatBotton(
          child: Text(
            'Copiar',
            style: TextStyle(fontSize: 17),
          ),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: details.selectedText ?? ""));
            if (_pdfViewerController != null) {
              _pdfViewerController!.clearSelection();
            }
          },
          color: Colors.white,
        ),
      ),
    );
    if (_overlayEntry != null) {
      overlayState.insert(_overlayEntry!);
    }
  }
}
