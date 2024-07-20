import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/extensions/formatter_extension.dart';
import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/styles/text_style.dart';
import '../../core/ui/widgets/delivery_appbar.dart';
import '../../core/ui/widgets/delivery_button.dart';
import '../../dto/order_product_dto.dart';
import '../../models/payment_type_model.dart';
import 'order_controller.dart';
import 'order_state.dart';
import 'widget/order_field.dart';
import 'widget/order_product_tile.dart';
import 'widget/payment_types_field.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final formKey = GlobalKey<FormState>();
  final addressEC = TextEditingController();
  final documentEC = TextEditingController();
  int? paymentTypeId;
  final paymentTypeValid = ValueNotifier<bool>(true);

  @override
  void onReady() {
    final orderList = ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(orderList);
    super.onReady();
  }

  @override
  void dispose() {
    addressEC.dispose();
    documentEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          loaded: () => hideLoader(),
          error: () => showError('Erro ao buscar formas de pagamento'),
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Carrinho',
                        style: context.textStyles.textTitle,
                      ),
                      IconButton(onPressed: () {}, icon: Image.asset('assets/images/trashRegular.png')),
                    ],
                  ),
                ),
              ),
              BlocSelector<OrderController, OrderState, List<OrderProductDto>>(
                selector: (state) => state.orderList,
                builder: (context, orderList) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: orderList.length,
                      (context, index) {
                        final orderProduct = orderList[index];
                        return Column(
                          children: [
                            OrderProductTile(
                              index: index,
                              orderProduct: orderProduct,
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
              BlocSelector<OrderController, OrderState, List<OrderProductDto>>(
                selector: (state) => state.orderList,
                builder: (context, orderList) {
                  return SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Total',
                                  style: context.textStyles.textExtraBold.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  orderList
                                      .fold<double>(0.0, (previousValue, element) => previousValue + element.product.price * element.amount)
                                      .currencyPTBR,
                                  style: context.textStyles.textExtraBold.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        OrderField(
                          title: 'Endereço de entrega',
                          controller: addressEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('Campo obrigatório'),
                          ]),
                          hintText: 'Digite o endereço de entrega',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        OrderField(
                          title: 'CPF',
                          controller: documentEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('Campo obrigatório'),
                            Validatorless.cpf('CPF inválido'),
                          ]),
                          hintText: 'Digite o CPF',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocSelector<OrderController, OrderState, List<PaymentTypeModel>>(
                          selector: (state) => state.paymentTypes,
                          builder: (context, paymentTypes) {
                            return ValueListenableBuilder(
                              valueListenable: paymentTypeValid,
                              builder: (_, paymentTypeValidValue, child) {
                                return PaymentTypesField(
                                  paymentTypes: paymentTypes,
                                  onChanged: (selected) {
                                    paymentTypeId = selected;
                                  },
                                  valid: paymentTypeValidValue,
                                  valueSelected: paymentTypeId.toString(),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: DeliveryButton(
                        label: 'Finalizar Pedido',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final paymentTypeSelected = paymentTypeId != null;
                            paymentTypeValid.value = paymentTypeSelected;
                          }
                        },
                        width: double.infinity,
                        height: 48,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
