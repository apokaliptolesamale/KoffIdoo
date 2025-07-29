/* import 'package:flutter/material.dart';



class Avatar extends StatelessWidget {
  final String urlAvatar;
  final double height;
  bool? verifiedUser;
  Avatar({
    required this.urlAvatar,
    required this.height,
    bool? verified,
    super.key,
  }) : verifiedUser = verified ?? false,
   super();
  // TransferController controller = TransferController();
  // String? error;
  // bool changeIcon = true;
  // List<Contact>? contacts;
  // Contact? data;
  // dartz.Either<Failure, AccountModel>? response;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //SizeConstraints sizeConstraints = SizeConstraints(context: context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            CircleAvatar(
              radius: height / 2,
              backgroundColor: Colors.lightBlue[300],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  size.width/30,
                ),
                child: FadeInImage(
                    height: height,
                    placeholderFit: BoxFit.fill,
                    fit: BoxFit.fill,
                    placeholder: AssetImage(
                        ''),
                    image: NetworkImageSSL(
                       allowCache: false,
                      urlAvatar,
                      errorImageUrl:
                          ASSETS_IMAGES_BACKGROUNDS_ENZONA_IM_FOTO_USUARIO_PNG,
                    )),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 0,
              // top: 60,
              height: height / 3,
              width: height / 3,
              child: Container(
                child: Roulette(
                  spins: 3,
                  infinite: true,
                  delay: Duration(seconds: 3),
                  child: CircleAvatar(
                    radius: sizeConstraints.getWidthByPercent(4),
                    backgroundColor: verifiedUser == true ?  Color.fromARGB(206, 115, 216, 85) : Colors.red,
                    child: verifiedUser == true ? Icon(
                      Icons.verified_user,
                      size: height / 5,
                      color: Colors.white,
                    ) : Icon(
                      Icons.cancel,
                      size: height / 5,
                      color: Colors.white,
                    )
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
 */