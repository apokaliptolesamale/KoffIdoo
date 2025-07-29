import 'package:apk_template/features/chinchal/presentation/providers/merchant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MerchantTile extends ConsumerWidget {
  const MerchantTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final merchantSelected = ref.watch(merchantSelectedProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /* ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CircleAvatar(
                    radius: 30,
                    child: //Image.asset('assets/images/cuenta.png'),
                        FadeInImage(
                            placeholder:
                                const AssetImage('assets/images/fotocomercio.png'),
                            image: NetworkImageSSL(
                                '${Environment.mediaHost}/${merchantSelected.avatar}')),
                  ),
                ), */
        CircleAvatar(
          backgroundColor: colors.primary,
          radius: width * 0.1,
          child: Icon(
            //! Este icono hay que cambiarlo por el fotocomercio
            Icons.store_mall_directory_rounded,
            size: width * 0.15,
            color: Colors.white,
            //! ------------------------------------------------
          ),
        ),
        SizedBox(
          width: width * 0.05,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 0.5,
              child: Text(
                merchantSelected!.name!,
                style: textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textScaler: TextScaler.noScaling,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
                width: width * 0.5,
                child: Text(
                  merchantSelected.username!, //'usuario',
                  style: textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textScaler: TextScaler.noScaling,
                ))
          ],
        )
      ],
    );
  }
}
