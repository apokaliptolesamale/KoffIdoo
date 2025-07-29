import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../../widgets/images/network_image_ssl.dart';
import '../../bindings/gift_binding.dart';
import '../../controllers/gift_controller.dart';

import '../../domain/models/gift_model.dart';
import '../../views/giftViews/detail_gift_view.dart';

class TransferGiftWidget extends StatelessWidget {
  final GiftModel gift;
  final String imageByUser;
  const TransferGiftWidget(this.gift, {Key? key, required this.imageByUser})
      : super(key: key);

  String createDate(String createAt) {
    var date = createAt.replaceRange(10, null, '').replaceAll('-', '/');
    return date;
  }

  createTime(String createAt) {
    var timeA = createAt.replaceRange(0, 11, '').replaceAll('-', '/');
    var time = timeA.replaceRange(5, null, '');
    return time;
  }

  createBanksNames(String code) {
    switch (code) {
      case '95':
        return 'BANMET';

      case "05":
        return 'BANMET';

      case '06':
        return 'BANDEC';

      case '12':
        return 'BPA';

      case '04':
        return 'BICSA';

      default:
        return 'BANMET';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle styleText = TextStyle(fontSize: size.height / 70);
    return GetBuilder<GiftController>(
        builder: (controller) => Column(
              children: [
                ListTile(
                  onTap: () {
                    Get.to(() => DetailGiftView(),
                        binding: GiftBinding(), arguments: gift);
                  },
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: AssetImage(
                              'assets/images/backgrounds/enzona/im_foto_usuario.png'),
                          image: NetworkImageSSL(
                              '${Constants.mediaHost}$imageByUser') /* NetworkImage(
                            '${Constants.mediaHost}images/user/avatar/ez_56651781.png') */

                          )
                      /* Image.asset('assets/images/im_foto_usuario.png',
                            height: size.height / 15), */
                      ),
                  title: Row(
                    children: [
                      Text(
                        gift.recipient.name.isNotEmpty
                            ? '${gift.recipient.name} ${gift.recipient.lastname}'
                            : '${gift.source.name} ${gift.source.lastname}', //'Rene Martinez Correa',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.height / 60),
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Text(
                            gift.source.name.isEmpty
                                ? '-${gift.amount}'
                                : '+${gift.amount}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height / 60),
                          ),
                          Text(
                            ' ${gift.currency}',
                            style: TextStyle(fontSize: size.height / 70),
                          )
                        ],
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height / 60,
                      ),
                      Row(
                        children: [
                          Text(
                            gift.source.last4.isNotEmpty
                                ? '${createBanksNames(gift.source.bank)}'
                                    '(${(gift.source.last4)})' //'BANMET(${gift.source.last4})'
                                : '${createBanksNames(gift.recipient.bank)}'
                                    '(${gift.recipient.last4})', //'BANMET(${gift.recipient.last4})',
                            style: styleText,
                          ),
                          Expanded(child: Container()),
                          Text(
                            createDate(gift.createdAt), //gift.createdAt,//,
                            style: styleText,
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height / 60,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: gift.statusDenom == 'Aceptada'
                                    ? Colors.green
                                    : gift.statusDenom == 'Pendiente'
                                        ? Colors.amber
                                        : Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              gift.statusDenom,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height / 60),
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(createTime(gift.createdAt), style: styleText)
                        ],
                      ),
                    ],
                  ),
                ),
                Divider()
              ],
            ));
  }
}
