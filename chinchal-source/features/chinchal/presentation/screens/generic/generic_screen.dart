import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class GenericScreen extends StatelessWidget {
  final bool appBar;
  final String? appBarText;
  final Widget header;
  final Widget content;

  const GenericScreen(
      {super.key,
      required this.appBar,
      this.appBarText = '',
      required this.header,
      required this.content});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: appBar == true ? AppBar(title: const Text('Perfil del comercio')) : null,
        body: SlideInDown(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                height: 260,
                width: 260,
                left: 300,
                bottom: 50,
                child: ZoomIn(
                  duration: const Duration(seconds: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        color: colors.secondary.withOpacity(0.1),
                        shape: BoxShape.circle),
                  ),
                )),
            Positioned(
                height: 200,
                width: 200,
                left: 30,
                top: 80,
                child: SlideInUp(
                  duration: const Duration(seconds: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        color: colors.secondary.withOpacity(0.1),
                        shape: BoxShape.circle),
                  ),
                )),
            Positioned(
                height: 160,
                width: 180,
                top: 150,
                left: 150,
                child: ElasticIn(
                  duration: const Duration(seconds: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        color: colors.secondary.withOpacity(0.15),
                        shape: BoxShape.circle),
                  ),
                )),
            Positioned(
                height: 180,
                width: 180,
                right: 280,
                top: 700,
                child: FadeIn(
                  duration: const Duration(seconds: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.secondary.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                  ),
                )),
            Positioned(
                height: 300,
                width: 300,
                left: 100,
                bottom: 600,
                child: JelloIn(
                  duration: const Duration(seconds: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.secondary.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                )),
            Positioned(
                left: 10,
                bottom: 30,
                child: Bounce(
                  duration: const Duration(seconds: 2),
                  child: Icon(
                    Icons.store_rounded,
                    size: width * 0.9,
                    color: colors.primary.withOpacity(0.1),
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideInLeft(
                  duration: const Duration(seconds: 2),
                  child: header
                  ),
                SizedBox(
                  height: height * 0.02,
                ),
                SlideInRight(
                  duration: const Duration(seconds: 2),
                  child: SizedBox(
                    height: height * 0.7,
                    width: width * 0.85,
                    child: Card(
                      color: colors.tertiaryContainer.withOpacity(0.5),
                      // elevation: 5,
                      child: content,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
