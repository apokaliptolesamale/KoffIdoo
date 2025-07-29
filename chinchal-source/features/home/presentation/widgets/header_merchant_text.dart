import 'package:flutter/material.dart';

class HeaderMerchantText extends StatelessWidget {
  const HeaderMerchantText({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: width * 0.7,
        child: Text(
          'Seleccione un comercio:',
          style: textTheme.headlineSmall,
          textScaler: TextScaler.noScaling,
          overflow: TextOverflow.ellipsis,
        ));
  }
}