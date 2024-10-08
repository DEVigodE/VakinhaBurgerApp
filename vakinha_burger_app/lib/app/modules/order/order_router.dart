import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/order/order_repository.dart';
import '../../repositories/order/order_repository_impl.dart';
import 'order_controller.dart';
import 'order_page.dart';

class OrderRouter {
  OrderRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OrderRepository>(create: (context) => OrderRepositoryImpl(dio: context.read())),
          Provider(create: (context) => OrderController(context.read())),
        ],
        builder: (context, child) {
          return const OrderPage();
        },
        //child: const ProductDetailPage(),
      );
}
