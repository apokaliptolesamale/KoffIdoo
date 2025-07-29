import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '/app/core/helpers/functions.dart';
import '/app/core/helpers/snapshot.dart';
import '/app/core/services/logger_service.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '/app/widgets/utils/loading.dart';

class CustomPdfViewer extends StatefulWidget {
  final String path;

  CustomPdfViewer({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  State<CustomPdfViewer> createState() => _CustomPdfViewerState();
}

class PdfIframeViewer extends StatefulWidget {
  final String path;
  final Function()? onTap;
  final Function()? onDoubleTap;
  final BuildContext context;
  PdfIframeViewer({
    required this.path,
    required this.context,
    this.onTap,
    this.onDoubleTap,
  });

  @override
  State<PdfIframeViewer> createState() => _PdfIframeViewerState();
}

class _CustomPdfViewerState extends State<CustomPdfViewer> {
  /*final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();*/
  String pathPDF = "";
  String landscapePathPdf = "";
  String remotePDFpath = "";
  String corruptedPathPDF = "";
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final isRemote = isUrlRemote(widget.path);
    return CustomFutureBuilder(
      context: context,
      future: !isRemote ? createFileOfPdfUrl() : Future.value(widget.path),
      builder: (_, __) =>
          !isRemote ? getLocalBuilder()(_, __) : getRemoteBuilder()(_, __),
    );
    /*return PspdfkitWidget(
    documentPath: ,
   );*/
    /*return PDFView(
      filePath: widget.path,
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: false,
      pageFling: true,
      pageSnap: true,
      defaultPage: currentPage!,
      fitPolicy: FitPolicy.BOTH,
      preventLinkNavigation:
          false, // if set to true the link is handled in flutter
      onRender: (pages) {
        setState(() {
          pages = pages;
          isReady = true;
        });
      },
      onError: (error) {
        setState(() {
          errorMessage = error.toString();
        });

      },
      onPageError: (page, error) {
        setState(() {
          errorMessage = '$page: ${error.toString()}';
        });

      },
      onViewCreated: (PDFViewController pdfViewController) {
        _controller.complete(pdfViewController);
      },
      onLinkHandler: (String? uri) {

      },
      onPageChanged: (int? page, int? total) {

        setState(() {
          currentPage = page;
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Document"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            onRender: (pages) {
              setState(() {
                pages = pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });

            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });

            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {

            },
            onPageChanged: (int? page, int? total) {

              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Text("Go to ${pages! ~/ 2}"),
              onPressed: () async {
                await snapshot.data!.setPage(pages! ~/ 2);
              },
            );
          }

          return Container();
        },
      ),
    );*/
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    log("Start download file from internet:${widget.path}");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = widget.path;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();

      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      //throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();
    log("Start reading file from local:${widget.path}");
    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  AsyncWidgetBuilder<A> getLocalBuilder<A>() {
    builder(BuildContext context, AsyncSnapshot<A> snapshot) {
      final loading =
          Loading.fromText(text: "Cargando información de la garantía...");
      if (isWaiting(snapshot)) {
        return EmptyDataSearcherResult(
          child: loading,
        );
      } else if (isDone(snapshot)) {
        final File file = snapshot.data as File;
        return PdfIframeViewer(
          context: context,
          path: file.path,
        );
      } else if (isError(snapshot)) {
        return Text("Fallo al cargar la información de la garantía");
      }
      return loading;
    }

    return builder;
  }

  AsyncWidgetBuilder<A> getRemoteBuilder<A>() {
    builder(BuildContext context, AsyncSnapshot<A> snapshot) {
      final loading =
          Loading.fromText(text: "Cargando información de la garantía...");
      if (isWaiting(snapshot)) {
        return EmptyDataSearcherResult(
          child: loading,
        );
      } else if (isDone(snapshot)) {
        final String url = snapshot.data as String;
        return PdfIframeViewer(
          context: context,
          path: url,
        );
      } else if (isError(snapshot)) {
        return Text("Fallo al cargar la información de la garantía");
      }
      return loading;
    }

    return builder;
  }

  @override
  void initState() {
    super.initState();
    final url = widget.path;
    final isRemote = isUrlRemote(url);
    final filename = url.toLowerCase().endsWith(".pdf")
        ? url.substring(url.lastIndexOf("/") + 1)
        : "file.pdf";
    isRemote
        ? createFileOfPdfUrl().then((f) {
            setState(() {
              remotePDFpath = f.path;
            });
          })
        : fromAsset(url, filename).then((f) {
            setState(() {
              corruptedPathPDF = f.path;
            });
          });
  }
}

class _PdfIframeViewerState extends State<PdfIframeViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          widget.onTap ??
          () {
            _pdfViewerKey.currentState?.openBookmarkView();
          },
      onDoubleTap: widget.onDoubleTap ??
          () {
            _pdfViewerKey.currentState?.openBookmarkView();
          },
      child: isUrlRemote(widget.path)
          ? SfPdfViewer.network(
              widget.path,
              key: _pdfViewerKey,
            )
          : SfPdfViewer.file(File(widget.path)),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
