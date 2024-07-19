import 'package:flutter/material.dart';

import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/widgets/delivery_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: const Color(0xff140E0E),
        child: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                  ),
                  SizedBox(
                    height: context.percentHeight(.08),
                  ),
                  DeliveryButton(
                    label: 'ACESSAR',
                    height: 35,
                    width: context.percentWidth(.6),
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('/home');
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.screenWidth,
                child: Image.asset(
                  'assets/images/lanche.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
