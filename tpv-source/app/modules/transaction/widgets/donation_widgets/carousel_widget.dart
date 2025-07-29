import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../controllers/donation_controller.dart';
import '../../domain/models/donation_model.dart';

class CarouselWidget extends StatefulWidget {
  final DonationModel donationModel;
  const CarouselWidget({
    key,
    required this.donationModel,
  });

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int activePage = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PageController pageController =
        PageController(viewportFraction: 0.8, initialPage: 0);
    return GetBuilder<DonationController>(
      builder: (controller) => Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
          BoxShadow(blurRadius: 0, blurStyle: BlurStyle.outer)
        ]),
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height / 3,
              child: PageView.builder(
                controller: pageController,
                itemCount: 2,
                itemBuilder: ((context, index) {
                  var dona = widget.donationModel.images;
                  var listDona = dona!.values;
                  List list = listDona.toList();
                  List listImg = list[0];
                  /* for (var i = 0; i < list.length; i++) {
                    listImg = list[0];
                  } */
                  late var img;
                  for (var i = 0; i < listImg.length; i++) {
                    img = listImg[index];
                  }

                  /* late String img;
                  for (var i = 0; i < controller.listImage.length; i++) {
                    img= controller.listImage[i];
                  } */
                  return Container(
                      decoration: BoxDecoration(),
                      margin: EdgeInsets.all(10),
                      child: FadeInImage(
                          placeholder: AssetImage(
                              'assets/images/backgrounds/enzona/fondo_donar2.png'),
                          image: NetworkImage(Constants.mediaHost +
                              img.toString())) //Image.asset('assets/images/fondo_donar2.png')
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
                children: indicators(2, activePage)),
            SizedBox(
              height: size.height / 60,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }
}
