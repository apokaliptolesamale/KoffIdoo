import 'package:apk_template/features/auth/auth.dart';
import 'package:apk_template/features/auth/presentation/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class LoginScreen extends ConsumerWidget {
  final String url;
  const LoginScreen({super.key, this.url = ''});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider = ref.watch(loginScreenProvider);
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: ref.read(loginScreenProvider.notifier).getUriToLogin(),
        builder: ((context, snapshot) {
          /* if (snapshot.connectionState == ConnectionState.waiting) {
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
          } */
          if (!snapshot.hasData) {
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
            ); //const WaitingWidget();
          } else {
            return SafeArea(
                child: Stack(children: [
              LoginWidget(
                initialUrl: (url.isEmpty) ? snapshot.data! : url,
                onStartLoadUrl:
                    ref.read(loginScreenProvider.notifier).onLoadStar,
                onStopLoadUrl:
                    ref.read(loginScreenProvider.notifier).onLoadStop,
                onProgressChange:
                    ref.read(loginScreenProvider.notifier).onProgessChanged,
              ),
              (loginProvider.progress < 100)
                  ? Scaffold(
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
                    ) //const Center(child: WaitingWidget())
                  : Container(),
            ]));
          }
        }));
  }
}
