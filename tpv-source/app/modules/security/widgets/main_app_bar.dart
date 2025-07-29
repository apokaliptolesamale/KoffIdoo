// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

import '../../../widgets/utils/size_constraints.dart';

/*
class AvatarEz extends StatelessWidget {
  const AvatarEz({
    Key? key,
    required this.size,
  }) : super(key: key);

  final SizeConstraints size;

  @override
  Widget build(BuildContext context) {
    // HomeController ctl = Get.find<HomeController>();
    return FutureBuilder(
        // future: ctl.getAvatar(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                  backgroundColor: Colors.white54,
                  radius: 45,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  )),
            );
          } else {
            return Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 45,
                      child: Image.network(
                        "${ctl.getAvatar()}",
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          );
                        },
                      ))),
            );
          }
        });
  }
}*/

class LogoEZ extends StatelessWidget {
  final SizeConstraints size;

  const LogoEZ({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CircleAvatar(
        radius: size.getWidthByPercent(8),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child:
              // SvgPicture.asset(
              //     "assets/images/icons/app/enzona/iconos para probar/EZ2.svg"
              //     // "assets/images/backgrounds/enzona/ic_bm.svg",
              //     // 'assets/images/icons/app/enzona/iconos para probar/EZ1.svg',
              //     // color: Colors.transparent,
              //     // matchTextDirection: false,
              //     // theme: SvgTheme(currentColor: Color(0xFFFFFFFF)),
              //     ),
              Image.asset(
            'assets/images/icons/app/enzona/iconos para probar/3.png',
            color: Colors.lightBlue,
          ),
          // Image.asset('assets/images/backgrounds/enzona/icono_ez2.png'),
        ),
      ),
    );
  }
}

class MainAppBar extends StatelessWidget {
  final SizeConstraints size;

  late List<Widget> listWidgets;
  MainAppBar({Key? key, required this.size, List<Widget>? widgets})
      : super(key: key) {
    listWidgets = [
      RoundContainer(size: size),
      // LogoEZ(size: size),
      // AvatarEz(size: size)
    ];
    listWidgets.addAll(widgets ?? []);
    /*if(Get.currentRoute   != "/DatosPerfilView"){
        listWidgets.removeAt(2);
        listWidgets.addAll(widgets ?? []);
        // listWidgets.insert(2, AvatarEz(size: size));
    }else {
         listWidgets.removeAt(1);
         listWidgets.addAll(widgets ?? []);
         listWidgets.insert(1 ,LogoEZ(size: size)); 
    } */
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Stack(
        children: listWidgets,
      ),
    );
  }
}

class RoundContainer extends StatelessWidget {
  final SizeConstraints size;

  const RoundContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logoSize = size.getWidthByPercent(6);
    return Positioned(
      bottom: logoSize,
      left: -70.0 / 2,
      right: -70.0 / 2,
      height: size.getWidth + 70.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.lightBlue,
            Colors.indigo,
          ]),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(size.getSize.width / 5),
          ),
        ),
      ),
    );
  }
}
