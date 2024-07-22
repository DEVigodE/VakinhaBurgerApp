import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/text_style.dart';
import '../../core/ui/widgets/delivery_button.dart';

class OrderCompletedPage extends StatefulWidget {
  const OrderCompletedPage({super.key});

  @override
  State<OrderCompletedPage> createState() => _OrderCompletedPageState();
}

class _OrderCompletedPageState extends State<OrderCompletedPage> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 5));
    _controllerCenter.play();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.percentHeight(0.2),
              ),
              Image.asset('assets/images/logo_rounded.png'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  'Pedido realizado com sucesso, em breve você receberá a confirmação do seu pedido',
                  textAlign: TextAlign.center,
                  style: context.textStyles.textExtraBold.copyWith(fontSize: 18),
                ),
              ),
              ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality.explosive, // don't specify a direction, blast randomly
                shouldLoop: true, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                ], // manually specify the colors to be used
                // createParticlePath: drawStar, // define a custom shape/path.
              ),
              const SizedBox(
                height: 40,
              ),
              DeliveryButton(
                label: 'FECHAR',
                width: context.percentWidth(0.8),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
