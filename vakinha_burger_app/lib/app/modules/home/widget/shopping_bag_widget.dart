import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/extensions/formatter_extension.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_style.dart';
import '../../../dto/order_product_dto.dart';

class ShoppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> shoppingBag;

  const ShoppingBagWidget({super.key, required this.shoppingBag});

  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final sp = await SharedPreferences.getInstance();
    if (!sp.containsKey('accesssToken')) {
      final loginResult = await navigator.pushNamed('/auth/login');

      if (loginResult == null || loginResult == false) {
        return;
      }
    }
    navigator.pushNamed('/order', arguments: shoppingBag);
  }

  @override
  Widget build(BuildContext context) {
    final totalValue = shoppingBag.fold<double>(0.0, (previousValue, element) => previousValue + element.product.price * element.amount);

    return Container(
      width: context.screenWidth,
      height: 90,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, -1),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          _goOrder(context);
        },
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.shopping_cart_outlined, color: Colors.white),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Ver Carrinho', style: context.textStyles.textExtraBold.copyWith(fontSize: 14, color: Colors.white)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(totalValue.currencyPTBR, style: context.textStyles.textExtraBold.copyWith(fontSize: 11, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
