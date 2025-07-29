import 'package:apk_template/features/chinchal/presentation/providers/darkmode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:apk_template/features/account/presentation/providers/account_provider.dart';
import 'package:apk_template/features/chinchal/presentation/screens/commerce_list/commerce_list_screen.dart';

import '../../../../config/utils/utils.dart';
import '../../../auth/presentation/presentation.dart';
import '../../../shared/shared.dart';

import '../../../auth/auth.dart';

class OptionsMenu extends ConsumerWidget {
  const OptionsMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        // TODO: Ir a pantalla de selección de comercios
        ListTile(
          leading: Icon(
            Icons.store,
            color: colors.primary,
            size: width * 0.1,
          ),
          title: Text(
            'Cambiar de comercio',
            style: textTheme.bodyLarge,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: colors.primary,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommerceListScreen(
                      account: ref.watch(getAccountProvider).value!),
                ));
          },
        ),

        // TODO: Ir a pantalla de selección de temas
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: colors.primary,
            size: width * 0.1,
          ),
          title: const Text('Cambiar de tema'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: colors.primary,
          ),
          onTap: () {
            //ref.read(darkModeProvider.notifier).update((state) => !state);
            ref.read(darkModeStateNotifierProvider.notifier).changeIsDarkMode();
          },
        ),
          ListTile(
          leading: Icon(
            Icons.insert_chart,
            color: colors.primary,
            size: width * 0.1,
          ),
          title: const Text('Apertura de Caja'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: colors.primary,
          ),
          onTap: () {
            //ref.read(darkModeProvider.notifier).update((state) => !state);
            context.go('/aperture');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.insert_chart_outlined_sharp,
            color: colors.primary,
            size: width * 0.1,
          ),
          title: const Text('Cierre de Caja'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: colors.primary,
          ),
          onTap: () {
            //ref.read(darkModeProvider.notifier).update((state) => !state);
            context.go('/closure');
          },
        ),
        //TODO: Cerrar sesión
        ListTile(
          leading: Icon(
            Icons.power_settings_new_rounded,
            color: colors.primary,
            size: width * 0.1,
          ),
          title: const Text('Cerrar sesión'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: colors.primary,
          ),
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return CustomDialog(
                  message: '¿Desea cerrar la sesión?',
                  dialogType: DialogType.question,
                  acceptFuncion: () async {
                    await ref
                        .read(loginScreenProvider.notifier)
                        .getUriToLogout()
                        .then((value) {
                      context.goNamed('logout', pathParameters: {'url': value});
                    });
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
