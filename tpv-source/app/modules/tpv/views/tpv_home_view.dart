import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/tpv/controllers/tpv_controller.dart';
import '../widgets/main_app_bar_widget/mainAppBar.dart';

enum ButtonState { init, loading, done }

class TpvHomeView extends GetResponsiveView<TpvController> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: mainAppBar(),
        body: OrientationBuilder(builder: ((context, orientation) {
          return Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                GridView.builder(
                  padding: const EdgeInsets.all(10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Data.Items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                    childAspectRatio:
                        orientation == Orientation.portrait ? 13 / 9 : 18 / 9,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          Get.toNamed(Data.Items[index].route);
                        },
                        child: Container(
                          padding: orientation == Orientation.portrait
                              ? const EdgeInsets.all(2)
                              : const EdgeInsets.all(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    Data.Items[index].icon.icon,
                                  )),
                              Text(Data.Items[index].name),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Container(
                //   height: 30,
                //   alignment: Alignment.bottomLeft,
                //   child: const Text(
                //     'Promociones',
                //     style: TextStyle(
                //       fontSize: 16,
                //       color: Colors.black,
                //       fontWeight: FontWeight.w900,
                //     ),
                //   ),
                // ),
                // LimitedBox(
                //   maxHeight: 250,
                //   child: PageView(
                //     allowImplicitScrolling: true,
                //     children: [
                //       AdsSlideCard(
                //         slideImage: 'assets/images/items/1.jpg',
                //       ),
                //       AdsSlideCard(
                //         slideImage: 'assets/images/items/2.jpg',
                //       ),
                //       AdsSlideCard(
                //         slideImage: 'assets/images/items/3.jpg',
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        })));
  }
}

class Item {
  final int id;
  final String name, route;
  final Icon icon;

  Item(
      {required this.id,
      required this.name,
      required this.route,
      required this.icon})
      : super();
}

class Data {
  // ignore: non_constant_identifier_names
  static List<Item> Items = [
    Item(
      id: 0,
      name: 'Punto de Venta',
      route: '/tpv-main',
      icon: const Icon(
        Icons.store,
      ),
    ),
    Item(
      id: 1,
      name: 'Clientes',
      route: '/tpv-clients',
      icon: const Icon(
        Icons.person,
      ),
    ),
    Item(
        id: 2,
        name: 'Proveedores',
        route: '/tpv-providers',
        icon: const Icon(
          Icons.car_rental,
        )),
    Item(
        id: 3,
        name: 'Productos',
        route: '/tpv-products',
        icon: const Icon(
          Icons.shopping_basket,
        )),
    Item(
        id: 4,
        name: 'Historial de ventas',
        route: '//tpv-sales-history',
        icon: const Icon(
          Icons.shopping_cart,
        )),
    Item(
        id: 5,
        name: 'Ajustes',
        route: '/tpv-settings',
        icon: const Icon(
          Icons.settings,
        )),
  ];
}
