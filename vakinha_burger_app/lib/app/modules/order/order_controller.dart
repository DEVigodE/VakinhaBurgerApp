import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../dto/order_product_dto.dart';
import '../../repositories/order/order_repository.dart';
import 'order_state.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _orderRepository;
  OrderController(this._orderRepository) : super(OrderState.initial());

  Future<void> load(List<OrderProductDto> orderList) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));
      final paymentTypes = await _orderRepository.getAllPaymentTypes();
      emit(
        state.copyWith(
          orderList: orderList,
          status: OrderStatus.loaded,
          paymentTypes: paymentTypes,
        ),
      );
    } catch (e, s) {
      log('LOG: Erro ao buscar formas de pagamento', error: e, stackTrace: s, name: 'OrderController');
      emit(state.copyWith(status: OrderStatus.error, errorMessage: 'Erro ao buscar formas de pagamento'));
    }
  }
}
