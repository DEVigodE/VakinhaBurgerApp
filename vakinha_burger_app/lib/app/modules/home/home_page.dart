import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/widgets/delivery_appbar.dart';
import 'home_controller.dart';
import 'home_state.dart';
import 'widget/delivery_product_tile.dart';
import 'widget/shopping_bag_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    controller.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            loaded: () => hideLoader(),
            error: () {
              hideLoader();
              showError(state.errorMessage ?? 'Erro inesperado.');
            },
          );
        },
        buildWhen: (previous, current) => previous.status.matchAny(any: () => false, loading: () => true, loaded: () => true, error: () => true),
        builder: (context, state) {
          if (state.status == HomeStateStatus.error) {
            return Center(
              child: ElevatedButton(
                onPressed: () => context.read<HomeController>().loadProducts(),
                child: const Text('Tentar novamente', style: TextStyle(color: Colors.white)),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    final orders = state.shoppingBag.where((element) => element.product == product);
                    return DeliveryProductTile(
                      product: product,
                      orderProduct: orders.isNotEmpty ? orders.first : null,
                    );
                  },
                ),
              ),
              Visibility(
                visible: state.shoppingBag.isNotEmpty,
                child: ShoppingBagWidget(shoppingBag: state.shoppingBag),
              ),
            ],
          );
        },
      ),
    );
  }
}
