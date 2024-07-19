import 'package:flutter/material.dart';

import 'core/provider/application_binding.dart';
import 'core/ui/theme/theme_config.dart';
import 'pages/home/home_router.dart';
import 'pages/product_detail/product_detail_router.dart';
import 'pages/splash/splash_pages.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

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
        },
      ),
    );
  }
}
