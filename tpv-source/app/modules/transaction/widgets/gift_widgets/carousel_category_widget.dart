import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/services/logger_service.dart';
import '../../../../core/services/store_service.dart';
import '../../controllers/gift_controller.dart';
import '../../domain/models/cardGift_model.dart';

class CarouselCategoryWidget extends StatefulWidget {
  final List<CardGiftModel> listCardGiftModel;
  const CarouselCategoryWidget({
    key,
    required this.listCardGiftModel,
  });

  @override
  State<CarouselCategoryWidget> createState() => _CarouselCategoryWidgetState();
}

class _CarouselCategoryWidgetState extends State<CarouselCategoryWidget> {
  int activePage = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Store store = StoreService().createStore("giftCard");
    String uuid;
    PageController pageController =
        PageController(viewportFraction: 1, initialPage: 0);
    log('Este es el lenght de la lista => ${widget.listCardGiftModel.length}');
    return GetBuilder<GiftController>(
      builder: (controller) => Container(
        decoration: BoxDecoration(color: Colors.black87, boxShadow: <BoxShadow>[
          BoxShadow(blurRadius: 20, blurStyle: BlurStyle.outer)
        ]),
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height / 1.5,
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.listCardGiftModel.length,
                itemBuilder: ((context, index) {
                  /*  var dona = widget.donationModel.images;
                  var listDona = dona.values;
                  List list = listDona.toList();
                  List listImg = list[0]; */
                  /* for (var i = 0; i < list.length; i++) {
                    listImg = list[0];
                  } */
                  late String cardReference;
                  for (var i = 0; i < widget.listCardGiftModel.length; i++) {
                    cardReference =
                        widget.listCardGiftModel[index].cardReference;
                    uuid = widget.listCardGiftModel[index].uuid;
                    store.add("uuidCardGift", uuid);
                  }

                  /* late String img;
                  for (var i = 0; i < controller.listImage.length; i++) {
                    img= controller.listImage[i];
                  } */
                  return Container(
                      //decoration: BoxDecoration(),
                      //margin: EdgeInsets.all(1),
                      child: FadeInImage(
                          placeholder: AssetImage(
                              'assets/images/backgrounds/enzona/fondo_donar2.png'),
                          image: NetworkImage(Constants.mediaHost +
                              cardReference
                                  .toString())) //Image.asset('assets/images/fondo_donar2.png')
                      );
                }),
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                  });
                },
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    indicators(widget.listCardGiftModel.length, activePage)),
            /* SizedBox(
              height: size.height / 20,
            ), */
          ],
        ),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    Size size = MediaQuery.of(context).size;
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: size.width / 20,
        height: size.height / 70,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.yellow : Colors.red,
            shape: BoxShape.circle),
      );
    });
  }
}
