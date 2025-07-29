import 'package:apk_template/features/account/presentation/providers/account_provider.dart';
import 'package:apk_template/features/chinchal/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class GetAccountScreen extends ConsumerWidget {
  const GetAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final authStateProvider = ref.watch(authProvider);
    Size size = MediaQuery.of(context).size;
    //final aaa = ref.watch(accountStateProvider);
    /* if (aaa.account == null) {
      ref.read(accountStateProvider.notifier).getAccount();
    }  */

    final account = ref.watch(getAccountProvider);
    return account.when(
        data: (data) {
          if (data != null) {
            return CommerceListScreen(
              account: data,
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(child: CircularProgressIndicator()),
                    SizedBox(
                      height: size.height / 80,
                    ),
                    Text(
                      'Cargando...',
                      style: TextStyle(
                        fontSize: size.width / 20,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        error: (error, stracktrace) => Scaffold(
              body: Center(
                child: Text(error.toString()),
              ),
            ),
        loading: () => Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(child: CircularProgressIndicator()),
                    SizedBox(
                      height: size.height / 80,
                    ),
                    Text(
                      'Cargando...',
                      style: TextStyle(
                        fontSize: size.width / 20,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
