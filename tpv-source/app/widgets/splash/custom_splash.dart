// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/app/widgets/components/clock_loading.dart';
import '/app/widgets/utils/size_constraints.dart';
import '../../core/config/app_config.dart';
import '../../core/helpers/widgets.dart';
import '../../core/services/network_manager_service.dart';
import '../../modules/warranty/views/colors.dart';
import '../images/background_image.dart';

class CustomSplash extends StatefulWidget {
  Widget? child;
  bool isNetWorkAvaliable;
  int timeout = 5;
  Function()? onReload;
  Widget? backGround;
  CustomSplash({
    Key? key,
    this.child,
    this.isNetWorkAvaliable = true,
    this.timeout = 5,
    required this.onReload,
    this.backGround,
  }) : super(key: key);

  @override
  State<CustomSplash> createState() => _CustomSplashState();
}

class _CustomSplashState extends State<CustomSplash> {
  bool isNetWorkAvaliable = true;
  bool _showRefreshButton = false;
  bool reloaded = false;
  late Timer timer;
  OverlayEntry? overlayEntry;
  @override
  Widget build(BuildContext context) {
    final sizeC = SizeConstraints(context: context);
    final theme = Theme.of(context);
    return defaultSplash ??
        Scaffold(
          body: Stack(
            children: [
              widget.backGround ?? BackGroundColor(),
              RefreshIndicator(
                onRefresh: _reload,
                child: widget.child ??
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (!isNetWorkAvaliable && !_showRefreshButton) ...[
                            //CircularProgressIndicator(),
                            ClockLoading(
                              textLoading: Text(
                                'Espere unos segundos por favor...',
                                style: theme.textTheme.bodyLarge,
                              ),
                            )
                            /*Clock(
                          height: sizeC.getHeightByPercent(20),
                          width: sizeC.getWidthByPercent(20),
                        )*/
                            ,
                            SizedBox(height: 1),
                            Text(
                              'Sin servicio de red...',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                          if (_showRefreshButton) ...[
                            Container(
                              height: 40,
                              width: sizeC.getWidthByPercent(40),
                              margin: EdgeInsets.only(top: 25),
                              child: MaterialButton(
                                textTheme: theme.buttonTheme.textTheme,
                                onPressed: () => _reload(),
                                shape: StadiumBorder(),
                                color: aceptBottonColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 3.0,
                                    //horizontal: 24.0,
                                  ),
                                  child: Text(
                                    "Recargar",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          if (isNetWorkAvaliable && !_showRefreshButton) ...[
                            Text(
                              'Iniciando...',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ],
                      ),
                    ),
              ),
            ],
          ),
        );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isNetWorkAvaliable = widget.isNetWorkAvaliable;
    timer = Timer.periodic(
        Duration(
          seconds: widget.timeout,
        ), (Timer t) async {
      if (!isNetWorkAvaliable) {
        setState(() {
          _showRefreshButton = true;
        });
      }
    });
  }

  void showRestartMessage(BuildContext context) {
    // Crea la capa flotante
    final theme = Theme.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        child: Material(
          textStyle: theme.textTheme.bodyMedium,
          child: Container(
            height: 80,
            color: Colors.blue,
            child: InkWell(
              onTap: () {
                // Reinicia la aplicación
                overlayEntry?.remove();
                /*String homeRoute =
                    ConfigApp.getInstance.configModel!.homePageRoute;
                String loginRoute = ConfigApp.getInstance.configModel!.loginRoute;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  homeRoute,
                  (route) => route.settings.name == loginRoute,
                );*/
                SystemNavigator.pop(); // Cierra la aplicación
                //runApp(WarrantyApp()); // Vuelve a abrir la aplicación
                widget.onReload != null ? widget.onReload!() : null;
              },
              child: Center(
                child: Text(
                  'Presiona para reiniciar la aplicación',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Muestra la capa flotante
    Overlay.of(context).insert(overlayEntry!);
  }

  Future<void> _reload() async {
    //showRestartMessage(context);
    if (reloaded) return;
    reloaded = true;
    setState(() {
      isNetWorkAvaliable = false;
      _showRefreshButton = false;
    });
    final loaded = NetworkManagerService.instance.isConnected();

    loaded.then((value) {
      setState(() {
        isNetWorkAvaliable = value;
        _showRefreshButton = false;
        reloaded = false;
      });
      if (value) {
        ConfigApp.getInstance.set("networkStatus", value);
        showRestartMessage(context);
      }
    });
  }
}
