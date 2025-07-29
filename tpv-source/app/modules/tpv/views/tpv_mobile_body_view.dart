// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/config/errors/errors.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/modules/product/domain/models/product_model.dart';
import '/app/modules/tpv/controllers/tpv_controller.dart';
import '../widgets/bouncing_loading_widget/bouncing_loading_widget.dart';

class CustomOrientationBuilder extends StatefulWidget {
  const CustomOrientationBuilder({Key? key}) : super(key: key);

  @override
  State<CustomOrientationBuilder> createState() =>
      _CustomOrientationBuilderState();
}

class TpvMobileBodyView extends GetResponsiveView<TpvController> {
  TpvMobileBodyView({
    Key? key,
  }) : super(
            key: key,
            settings: const ResponsiveScreenSettings(
              desktopChangePoint: 800,
              tabletChangePoint: 700,
              watchChangePoint: 600,
            ));

  @override
  Widget build(BuildContext context) {
    return CustomOrientationBuilder();
  }
}

class _CustomOrientationBuilderState extends State<CustomOrientationBuilder> {
  bool isFirstScreen = true;
  int cantArticulos = 0;
  List<ProductModel> list = [];
  List<ProductModel> listOfSelectedProducts = [];
  int elementIndex = 0;
  int newUnit = 0;
  double total = 0;
  TpvController tpvController = Get.find<TpvController>();
  @override
  Widget build(BuildContext context) {
    total = getTotalCash();

    return isFirstScreen
        ? FutureBuilder(
            future: tpvController.getAllProducts(),
            builder: (context,
                AsyncSnapshot<
                        dartz.Either<Failure, EntityModelList<ProductModel>>>
                    snapshot) {
              if (!snapshot.hasData) {
                return Center(child: BouncingLoadingWidget());
              } else {
                snapshot.data!.fold((l) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Error!!!"),
                          content: Text(l.toString()),
                        );
                      });
                }, (r) {
                  list = r.getList();
                });

                return firstScreenView(context, list);
              }
            },
          )
        : portraitSecond(context);
  }

  ///////////////////////////////////////////////////////////////////////////////////

  Widget firstScreenView(BuildContext context, List<ProductModel> list) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Container(
              margin: const EdgeInsets.only(top: 20, bottom: 15),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                  padding: const EdgeInsets.all(12),
                  itemCount: list.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    ProductModel productModel = list.elementAt(index);

                    return TextButton(
                      onPressed: () {
                        setState(() {
                          insertProduct(list[index]);
                        });
                      },
                      child: Container(
                        height: 150,
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Image.network(
                            //     productModel.images[0].imageURL),

                            Icon(
                              Icons.image,
                              color: Colors.black,
                            ),
                            Divider(
                              color: Colors.lightBlue,
                            ),
                            Text(
                              productModel.name.substring(6),
                              softWrap: true,
                              maxLines: 3,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            FittedBox(
                              child: Text(
                                '${productModel.salePrice} USD',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width / 2,
                child: TextButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FittedBox(
                        child: Text(
                          'Cobrar',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Color(0xFF024869)),
                        ),
                      ),
                      Text(
                        '${total.toStringAsFixed(2)} USD',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF024869)),
                      )
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.09,
                width: MediaQuery.of(context).size.width / 2,
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        isFirstScreen = false;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.055,
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: EdgeInsets.only(
                          left: 10, right: 10, bottom: 4, top: 4),
                      decoration: BoxDecoration(
                          color: Color(0xFF5091C9),
                          borderRadius: BorderRadius.circular(22)),
                      child: const FittedBox(
                        child: Text(
                          'Revisar',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget portraitSecond(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Container(
        margin: EdgeInsets.all(12),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 8 / 1,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: listOfSelectedProducts.length,
                  padding: const EdgeInsets.only(
                      top: 6, bottom: 2, left: 10, right: 10),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return TextButton(
                      onPressed: () {
                        Get.toNamed('/tpv-all-products');
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFFDCE4E7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              offset: const Offset(2, 2),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                            const BoxShadow(
                              color: Colors.white,
                              offset: Offset(-2, -2),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    int newQuantity =
                                        listOfSelectedProducts[index].quantity;
                                    return AlertDialog(
                                      title: Text(
                                          'Introduzca la cantidad deseada'),
                                      content: TextField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          newQuantity = int.tryParse(value) ??
                                              newQuantity;
                                        },
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Cancelar'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            setState(() {
                                              listOfSelectedProducts[index]
                                                  .quantity = newQuantity;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                  'x${listOfSelectedProducts[index].quantity}'),
                            ),
                            Text(
                              truncateString(
                                  listOfSelectedProducts[index].name),
                            ),
                            Row(
                              children: [
                                Text((listOfSelectedProducts[index].salePrice *
                                        listOfSelectedProducts[index].quantity)
                                    .toString()),
                                const Text(
                                  ' USD ',
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        listOfSelectedProducts.removeAt(index);
                                      });
                                    },
                                    child: Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                      size: 28,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  color: Color(0xFFDCE4E7),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  isFirstScreen = true;
                                });
                              },
                              child: Text(
                                '+',
                                style: TextStyle(fontSize: 50),
                              )),
                        ],
                      ),
                      Divider(
                        color: Colors.blue,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total'),
                          Text('${total.toStringAsFixed(2)} USD')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                          TextButton(
                              onPressed: () {
                                Get.toNamed('/tpv-invoice', arguments: {
                                  'total': total,
                                  'products': listOfSelectedProducts
                                });
                              },
                              child: Text('Cobrar')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double getTotalCash() {
    double total = 0;
    for (int i = 0; i < listOfSelectedProducts.length; i++) {
      total += (listOfSelectedProducts[i].salePrice *
          listOfSelectedProducts[i].quantity);
    }
    return total;
  }

  int searchElement(String id) {
    if (listOfSelectedProducts.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        if (list[i].id ==
            listOfSelectedProducts[
                    _CustomOrientationBuilderState().elementIndex]
                .id) {
          return i;
        }
      }
    }
    return -1;
  }

  void insertProduct(ProductModel p) {
    bool esta = false;
    int pos = 0;
    if (listOfSelectedProducts.isEmpty) {
      //se anade
      listOfSelectedProducts.add(ProductModel(
          name: p.name,
          idOrderService: p.idOrderService,
          salePrice: p.salePrice));
      listOfSelectedProducts[listOfSelectedProducts.length - 1].quantity = 1;
      //se annade el elemento por primera vez
    } else {
      for (int i = 0; i < listOfSelectedProducts.length; i++) {
        if (listOfSelectedProducts[i].name == p.name) {
          esta = true;
          pos = i;
        }
      }
      if (esta == false) {
        //el elemento no estaba y se annade
        listOfSelectedProducts
            .add(ProductModel(name: p.name, idOrderService: p.idOrderService));
        listOfSelectedProducts[listOfSelectedProducts.length - 1].quantity = 1;

        return;
      } else {
        //el elemento esta y se incrementa
        listOfSelectedProducts[pos].quantity++;
      }
    }
  }

  Future<bool> onBackPressed() async {
    setState(() {
      isFirstScreen = true;
    });
    return false;
  }

  String truncateString(String str) {
    List<String> words = str.split(' ');
    if (words.length > 5) {
      words = words.sublist(1, 5);
      return '${words.join(' ')}...';
    } else {
      return str;
    }
  }
}
