import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../widgets/images/network_image_ssl.dart';
import '../../../../widgets/utils/loading.dart';
import '../../controllers/gift_controller.dart';
import '../../domain/entities/categoryGift.dart';
import '../../domain/models/category_model.dart';
import '../../views/giftViews/seleccionar_Postal_view.dart';

class PostalesWidget extends StatelessWidget {
  final String importe;
  final String description;
  const PostalesWidget({key, required this.importe, required this.description});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<GiftController>(
      builder: (controller) => Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey, blurStyle: BlurStyle.outer, blurRadius: 5)
          ],
        ),
        //color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(left: 5, top: 8),
                child: Text(
                  'Postales',
                  style: TextStyle(color: Colors.grey),
                )),
            SizedBox(
              height: size.height / 60,
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              //color: Colors.grey,
              width: double.infinity,
              height: size.height / 6,
              child: FutureBuilder(
                  future: controller.getGiftsCategory(),
                  builder: (context,
                      AsyncSnapshot<
                              Either<Failure,
                                  EntityModelList<CategoryGiftModel>>>
                          snapshot) {
                    if (!snapshot.hasData) {
                      return Loading(
                        text: "Cargando postales...",
                        backgroundColor: Colors.lightBlue.shade700,
                        animationColor: AlwaysStoppedAnimation<Color>(
                            Colors.lightBlue.withOpacity(0.8)),
                        containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                      );
                    } else {
                      //var postalUrl = snapshot.data as CategoryGiftList;
                      return snapshot.data!.fold(
                          (l) => Container(
                                child: Text(l.toString()),
                              ), (r) {
                        //final listGift = r as CategoryGiftList;
                        List<CategoryGiftModel> categoryList = r.getList();
                        late CategoryGift category;
                        late String avatar;
                        late String denom;
                        //late CategoryModel categoryModel;
                        /* for (var i = 0; i < categoryList.length; i++) {
                          categoryModel = categoryList[i];
                        } */
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryList.length,
                          itemBuilder: ((context, index) {
                            for (var i = 0; i < categoryList.length; i++) {
                              category = categoryList[index];
                              avatar = categoryList[index].avatar;
                              denom = categoryList[index].denom;
                            }
                            return Container(
                              //color: Colors.red,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    width: size.width / 4,
                                    height: size.height / 5,
                                    child: GestureDetector(
                                        onTap: () async {
                                          Get.to(
                                            () => SelectPostcard(category.uuid),
                                          );
                                          //ListCardGift listCardGift =await _.getListCardGift(cardGiftUuid);

                                          /* var primarySource = await controller
                                            .getPrimarySourceCard();
                                        var fondingSourceUuid =
                                            primarySource.fundingSourceUuid;
                                        var currency = primarySource.currency; */

                                          /* var description = controller
                                            .descriptionController.text;
                                        var amount =
                                            controller.importeController.text; */
                                        },
                                        child: Stack(children: [
                                          FadeInImage(
                                              placeholder: AssetImage(
                                                  'assets/images/postales.png'),
                                              image: NetworkImageSSL(
                                                  Constants.mediaHost +
                                                      avatar)),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: size.height / 90),
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              denom,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: size.height / 80,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ]) /* Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImageSSL('${Constants.mediaHost +
                                                  category
                                                      .avatar}')
                                      
                                      /* AssetImage(
                                          'assets/images/postales.png'), */ /* NetworkImage(Constants.mediaHost +
                                                  category
                                                      .avatar /* 'https://media.enzona.net/'
                                              '${category.avatar}' */
                                               */
                                    ), */
                                        ), /* FadeInImage(
                                        placeholder: AssetImage(
                                            'assets/images/postales.png'),
                                        image: NetworkImage(
                                            'https://media.enzona.net/' +
                                                '${category.avatar}')) */
                                  ),
                                  SizedBox(
                                    width: size.width / 40,
                                  )
                                ],
                              ),
                            );
                          }),
                        );
                      });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
