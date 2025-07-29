import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../../widgets/minimalist_decoration_widget/minimalist_decoration_widget.dart';
import '../first_time_config_view.dart.dart';

class InitialConfig4 extends StatefulWidget {
  const InitialConfig4({Key? key}) : super(key: key);

  @override
  State<InitialConfig4> createState() => _InitialConfig4State();
}

class _InitialConfig4State extends State<InitialConfig4> {
  String? deviceId;
  String? deviceName;
  String? deviceBrand;
  String? deviceModel;

  String? eComerceName = 'TRD';
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late DeviceInfoPlugin androidInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    AndroidDeviceInfo androidDeviceInfo = await DeviceInfoPlugin().androidInfo;

    if (!mounted) return;

    setState(() {
      deviceId = androidDeviceInfo.id;
      deviceName = androidDeviceInfo.device;
      deviceBrand = androidDeviceInfo.brand;
      deviceModel = androidDeviceInfo.model;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        margin: const EdgeInsets.all(32),
        child: ListView(
          children: [
            Container(
              height: 24,
            ),
            const FittedBox(
              child: Text(
                'Ademas se han obtenido los siguientes datos:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 120,
                    width: 180,
                    decoration: minimalistDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.device_unknown_outlined,
                          size: 35,
                          color: Colors.teal,
                        ),
                        const Text('Marca del dispositivo:'),
                        Text('$deviceBrand'),
                      ],
                    )),
                Container(
                    height: 120,
                    width: 180,
                    decoration: minimalistDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.devices_rounded,
                          size: 35,
                          color: Colors.blue,
                        ),
                        const Text('Modelo del dispositivo:'),
                        Text('$deviceModel'),
                      ],
                    )),
              ],
            ),
            Container(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 120,
                    width: 180,
                    decoration: minimalistDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.person,
                          size: 35,
                          color: Colors.green,
                        ),
                        const Text('ID del dispositivo:'),
                        Text('$deviceId'),
                      ],
                    )),
                Container(
                    height: 120,
                    width: 180,
                    decoration: minimalistDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.android,
                          size: 35,
                          color: Colors.cyan,
                        ),
                        const Text('Nombre del dispositivo:'),
                        Text('$deviceName'),
                      ],
                    )),
              ],
            ),
            Container(
              height: 30,
            ),
            Container(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 120,
                    width: 180,
                    decoration: minimalistDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.store,
                          size: 35,
                          color: Colors.green,
                        ),
                        const Text('Nombre de la tienda:'),
                        Text(FirstTimeConfigView().storeName!),
                      ],
                    )),
                Container(
                    height: 120,
                    width: 180,
                    decoration: minimalistDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.storefront_outlined,
                          size: 35,
                          color: Colors.cyan,
                        ),
                        const Text('Cadena de tiendas:'),
                        Text('$eComerceName'),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
