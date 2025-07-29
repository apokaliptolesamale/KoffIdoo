import 'package:apk_template/config/router/auth_router_notifier.dart';
import 'package:apk_template/features/apk_comercio_experto/presentation/screens/aperture/aperture_screen.dart';
import 'package:apk_template/features/apk_comercio_experto/presentation/screens/closure/closure_screen.dart';
import 'package:apk_template/features/apk_comercio_experto/presentation/screens/products/products_screen.dart';
import 'package:apk_template/features/apk_comercio_experto/presentation/screens/mode_selector/mode_seector_screen.dart';
import 'package:apk_template/features/chinchal/presentation/screens/refund/refund_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apk_template/features/auth/auth.dart';
import 'package:apk_template/features/home/home.dart';

import '../../features/chinchal/domain/models/operation_model.dart';
import '../../features/chinchal/domain/models/refund_model.dart';
import '../../features/chinchal/presentation/screens/calculator/dynamic_qr_screen.dart';
import '../../features/chinchal/presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    //initialLocation: '/aperture',
    initialLocation: '/splash',
    //initialLocation:'/TPVhome' ,
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
       builder: (context, state) => const SplashScreen(),
      ), 
       GoRoute(
        path: '/closure',
       builder: (context, state) => const CloseCashRegisterPage(),
      ), 
      GoRoute(
        path: '/TPVhome',
       builder: (context, state) => const ProductsScreen(),
      ), 
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/aperture',
        builder: (context, state) =>  const ApertureScreen(),
      ),
      GoRoute(
        path: '/logout/:url',
        name: 'logout',
        builder: (context, state) =>
            LoginScreen(url: state.pathParameters['url']!),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const GetAccountScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/mode',
        builder: (context, state) => const ModeSelectionScreen(),
      ),
      GoRoute(
        path: '/qr/:amount/:image/:qrcode',
        name: DynamicQrCodeScreen.name,
        builder: (context, state) => DynamicQrCodeScreen(
          amount: state.pathParameters['amount'] == 'null'
              ? ''
              : state.pathParameters['amount'],
          image: state.pathParameters['image'] ?? '',
          qrcode: state.pathParameters['qrcode'] ?? '',
        ),
      ),
      GoRoute(
        path: '/profile',
        name: ProfileScreen.name,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/operationDetail/:operation/:refund',
        name: OperationDetailScreen.name,
        builder: (context, state) => OperationDetailScreen(
          operation: OperationMerchantModel.fromStringJson(state.pathParameters['operation']!),//state.pathParameters['operation'] as ,
          refundModel: state.pathParameters['refund'] == 'null'? null:RefundModel.fromStringJson(state.pathParameters['refund']!)//state.pathParameters['refund'] as RefundModel,
        ),
      ),
      GoRoute(
        path: '/refund/:operation',
        name: RefundScreen.name,
        builder: (context, state) => RefundScreen(
          operationModel: OperationMerchantModel.fromStringJson(state.pathParameters['operation']!),
          //merchantModel: MerchantModel.fromStringJson(state.pathParameters['merchant']!),
        ),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.fullPath;
      final path = state.path;
      final authStatus = goRouterNotifier.authStatus;
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }
      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login') {
          return null;
        }
        return '/login';
      }
      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/splash') {
          return '/';
        }
      }
      if (authStatus == AuthStatus.authenticated) {
        if (path == '/qr') {
          return '/qr';
        }
      }
      if (authStatus == AuthStatus.authenticated) {
        if (path == '/operationDetail') {
          return '/operationDetail';
        }
      }
      if (authStatus == AuthStatus.authenticated) {
        if (path == '/refund') {
          return '/refund';
        }
      }
      return null;
    },
  );
});
