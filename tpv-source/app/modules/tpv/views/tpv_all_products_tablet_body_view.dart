import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/services/logger_service.dart';
import '/app/modules/tpv/controllers/tpv_controller.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../product/domain/models/product_model.dart';
import '../widgets/bouncing_loading_widget/bouncing_loading_widget.dart';

class CustomOrientationBuilder extends StatefulWidget {
  const CustomOrientationBuilder({Key? key}) : super(key: key);

  @override
  State<CustomOrientationBuilder> createState() =>
      _CustomOrientationBuilderState();
}

class TpvAllProductsTabletBodyView extends GetResponsiveView<TpvController> {
  TpvAllProductsTabletBodyView({
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
  List<ProductModel> list = [];
  bool isProductSelected = false;
  int selectedProductIndex = -1;

  @override
  // void initState() {
  //   super.initState();
  //   SystemChrome.setPreferredOrientations([]);

  // }

  @override
  Widget build(BuildContext context) {
    TpvController tpvController = Get.find<TpvController>();
    return SafeArea(
      child: Row(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width / 2,
            child: FutureBuilder(
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

                  return listOfProducts(context, list);
                }
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width / 2,
            child: selectedProductTabletView(),
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////

  Widget listOfProducts(BuildContext context, List<ProductModel> list) {
    log(list.length);
    return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 15),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
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
                    selectedProductIndex = index;
                    isProductSelected = true;
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
                        maxLines: 5,
                        style: TextStyle(color: Colors.black, fontSize: 12),
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
            })));
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////

  Widget selectedProductTabletView() {
    return isProductSelected
        ? SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.network(
                    //     productModel.images[0].imageURL),

                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Icon(
                        Icons.image,
                        color: Colors.black,
                      ),
                    ),
                    Divider(
                      color: Colors.lightBlue,
                    ),
                    Text(
                      list[selectedProductIndex].name.substring(6),
                      softWrap: true,
                      maxLines: 5,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Precio'),
                        FittedBox(
                          child: Text(
                            '${list[selectedProductIndex].salePrice} USD',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Codigo del producto'),
                        FittedBox(
                          child: Text(
                            '${list[selectedProductIndex].code} USD',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: () {}, child: Text('-')),
                    Container(
                        color: Colors.white,
                        child: Text(
                          list[selectedProductIndex].quantity.toString(),
                          style: TextStyle(color: Colors.blueAccent),
                        )),
                    TextButton(onPressed: () {}, child: Text('+')),
                  ],
                ),
              ],
            ),
          )
        : Center(
            child: Text('Selecciona un producto para mostrar'),
          );
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
