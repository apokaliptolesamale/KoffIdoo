// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../core/config/assets.dart';
import '../images/background_image.dart';

class ReloadWidget extends StatefulWidget {
  final Widget child;
  final Future<void> Function()? onRefresh;
  const ReloadWidget({
    Key? key,
    required this.child,
    this.onRefresh,
  }) : super(key: key);

  @override
  _ReloadWidgetState createState() => _ReloadWidgetState();
}

class _ReloadWidgetState extends State<ReloadWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh ?? _reload,
      child: Stack(
        children: [
          BackGroundImage(
            backgroundImage: ASSETS_IMAGES_BACKGROUNDS_DEFAULT_JPG,
          ),
          widget.child,
        ],
      ),
    );
  }

  Future<void> _reload() async {
    // Aquí se puede colocar la lógica de recarga de la aplicación
    await Future.delayed(Duration(seconds: 2));
  }
}
