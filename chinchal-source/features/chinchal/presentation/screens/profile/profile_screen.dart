import 'package:apk_template/features/chinchal/presentation/providers/merchant_provider.dart';
import 'package:apk_template/features/chinchal/presentation/screens/generic/generic_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/options_menu.dart';

class ProfileScreen extends ConsumerWidget {
  static const String name = 'profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final merchant = ref.watch(merchantSelectedProvider);
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return GenericScreen(
        appBar: true,
        header: Text(
          merchant!.name!,
          style: textTheme.titleLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        content: const OptionsMenu());
  }
}
