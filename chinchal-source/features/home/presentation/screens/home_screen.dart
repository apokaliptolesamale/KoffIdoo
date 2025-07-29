import 'dart:developer';

import 'package:apk_template/config/config.dart';
import 'package:apk_template/features/account/presentation/providers/account_provider.dart';
import 'package:apk_template/features/apk_comercio_experto/presentation/providers/expert_mode_provider.dart';
import 'package:apk_template/features/apk_comercio_experto/presentation/screens/products/products_screen.dart';
import 'package:apk_template/features/apk_comercio_experto/presentation/screens/products/views/cart_view.dart';
import 'package:apk_template/features/chinchal/presentation/providers/merchant_provider.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../chinchal/presentation/providers/ntfy_provider.dart';
import '../../../chinchal/presentation/screens/screens.dart';
import '../../../shared/widgets/custom_dialog.dart';
import '../providers/home_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
  }

  void _showSnackBar(BuildContext context, Widget text) {
    final snackBar = SnackBar(
      padding: const EdgeInsets.only(bottom: 30, left: 8),
      duration: const Duration(milliseconds: 5000),
      content: text, //Text('Notificación'),
      showCloseIcon: true,
      action: ref.read(currentIndexProvider) == 1
          ? null
          : SnackBarAction(
              label: 'Ver',
              onPressed: () {
                log(ref
                    .read(goRouterProvider)
                    .routerDelegate
                    .currentConfiguration
                    .last
                    .route
                    .path);
                if (ref
                        .read(goRouterProvider)
                        .routerDelegate
                        .currentConfiguration
                        .last
                        .route
                        .path ==
                    '/operationDetail') {
                  context.pop();
                }
                if (ref
                        .read(goRouterProvider)
                        .routerDelegate
                        .currentConfiguration
                        .last
                        .route
                        .path ==
                    '/profile') {
                  context.pop();
                }
                ref.read(currentIndexProvider.notifier).update((state) => 1);
              },
            ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    
    final accountAsync = ref.watch(getAccountProvider);
    final merchant = ref.watch(merchantSelectedProvider);
    final currentIndex = ref.watch(currentIndexProvider);
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final ntfyState = ref.watch(ntfyProvider);
    final expertMode = ref.watch(expertModeProvider);
   final merchants = accountAsync.when(
  data: (account) {
    if (account == null) return const AsyncValue.data(null);
    return ref.watch(filterMerchantProvider(account));
  },
  loading: () => const AsyncValue.loading(),
  error: (err, stack) => AsyncValue.error(err, stack),
);
    if (ntfyState.state.contains('completed')) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await player.setSource(AssetSource('sounds/fairy_tone.mp3'));
        await player.resume();
        _showSnackBar(
            // ignore: use_build_context_synchronously
            context,
            Center(
              child: Text.rich(
                TextSpan(children: [
                  const TextSpan(
                      text: 'Usted ha recibido un transferencia de '),
                  TextSpan(
                      text: '\$${ntfyState.state.replaceAll('completed-', '')}',
                      style: const TextStyle(fontWeight: FontWeight.bold))
                ]),
              ),
            ));
        ref.read(ntfyProvider.notifier).changeStateParam(stateParam: 'none');
        // Text('Usted ha recibido un transferencia de \$${ntfyState.amount}')
      });
    }
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        bool confirmExit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              acceptFuncion: () => true,
            );
          },
        );
        return confirmExit;
      },
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: height * 0.10,
            title: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pushNamed('profile'),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CircleAvatar(
                          radius: 30,
                          child: Image.asset('assets/images/fotocomercio.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                
                        SizedBox(
                          width: width * 0.7,
                          child: Text(
                            '${merchant!.name}', //'Nombre de usuario',
                            style: textTheme.titleMedium,
                            textScaler: TextScaler.noScaling,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: Text(
                            merchant.moneda!.toUpperCase(), //'username',
                            style: textTheme.titleSmall,
                            textScaler: TextScaler.noScaling,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                
              ],
            ),
          ),
          body: Column(
        children: [
          
          if(expertMode)  SizedBox(
            height: 75,
            child: merchants.when(
              data: (merchants) {
                if (merchants == null || merchants.content!.isEmpty) {
                  return const Center(child: Text('No hay comercios disponibles'));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: merchants.content!.length,
                  itemBuilder: (context, index) {
                    final merchant = merchants.content![index];
                    return GestureDetector(
                      onTap: () {
                        ref.read(merchantSelectedProvider.notifier).state = merchant;
                        context.go('/mode');
                      },
                      child: Card(
                        
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                merchant.name!,
                                style: textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                merchant.moneda!.toUpperCase(),
                                style: textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),

          
          Expanded(
            child: IndexedStack(
            index: currentIndex,
            children: [
              if(expertMode) const CartView(),
              (!expertMode) ? const CalculatorScreen() : const ProductsScreen(),
              const OperationsScreen(),
            ],
          ),
          ),
        ],
      ),
          bottomNavigationBar: ConvexAppBar(
            backgroundColor: colors.primary,
            height: height * 0.07,
            items: [
              
              if(expertMode) const TabItem(
                      icon: Icons.shopping_cart_outlined,
                      title: 'Carrito',
                    ),
              (!expertMode)
                  ? const TabItem(icon: Icons.monetization_on, title: 'Vender')
                  : const TabItem(
                      icon: Icons.store,
                      title: 'Productos',
                    ),
                   const TabItem(icon: Icons.list_alt_rounded, title: 'Operaciones'),
             
            ],
            initialActiveIndex: currentIndex,
            onTap: (index) {
              if (ref.read(merchantSelectedProvider) != null) {
                ref
                    .read(currentIndexProvider.notifier)
                    .update((state) => index);
              } else {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return CustomDialog(
                      message: 'Usted debe seleccionar un comercio antes',
                      acceptFuncion: () {
                        context.pop();
                      },
                    );
                  },
                );
              }
            },
          )),
    );
  }
}
