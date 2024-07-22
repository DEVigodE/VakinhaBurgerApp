import 'package:flutter/material.dart';

import 'core/global/global_context.dart';
import 'core/provider/application_binding.dart';
import 'core/ui/theme/theme_config.dart';
import 'modules/auth/login/login_router.dart';
import 'modules/auth/register/register_router.dart';
import 'modules/home/home_router.dart';
import 'modules/order/order_completed_page.dart';
import 'modules/order/order_router.dart';
import 'modules/product_detail/product_detail_router.dart';
import 'modules/splash/splash_pages.dart';

class AppWidget extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  AppWidget({super.key}) {
    GlobalContext.instance.navigatorKey = _navigatorKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'MyApp',
        theme: ThemeConfig.theme,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => HomeRouter.page,
          '/productDetail': (context) => ProductDetailRouter.page,
          '/auth/login': (context) => LoginRouter.page,
          '/auth/register': (context) => RegisterRouter.page,
          '/order': (context) => OrderRouter.page,
          '/order/completed': (context) => const OrderCompletedPage(),
        },
        navigatorKey: _navigatorKey,
      ),
    );
  }
}
