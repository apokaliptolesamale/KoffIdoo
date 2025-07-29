// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';

import '/app/core/config/assets.dart';
import '/app/modules/product/controllers/product_controller.dart';
import '/app/widgets/field/custom_get_view.dart';
import '../../../../widgets/images/background_image.dart';

class SendInfoPage extends CustomView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackGroundImage(
          backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.all(18),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 60,
                ),
                //FIRST SET OF ELEMENTS
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 35,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Color(0xFFd7d7d7),
                          border: Border.all(
                            color: Color(0xFFd7d7d7),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'No. de orden',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Color(0xFFd7d7d7),
                          border: Border.all(
                            color: Color(0xFFd7d7d7),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Código del producto',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //SECOND ELEMENT
                Container(
                  height: 35,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Color(0xFFd7d7d7),
                    border: Border.all(
                      color: Color(0xFFd7d7d7),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                //THIRD ELEMEMENT
                Container(
                  height: 200,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Color(0xFFd7d7d7),
                    border: Border.all(
                      color: Color(0xFFd7d7d7),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Descripción',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                //FOURTTH ELEMENT
                Container(
                  height: 50,
                  width: 320,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00b1a4),
                    ),
                    onPressed: () {},
                    child: Container(
                        child: Center(
                      child: Text(
                        'Enviar',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    )),
                  ),
                ),
              ],
            )),
          ),
        )
      ],
    );
  }
}
