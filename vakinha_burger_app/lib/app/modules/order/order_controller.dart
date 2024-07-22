import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../dto/order_dto.dart';
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

  void incrementProduct(int index) {
    final orders = [...state.orderList]; // isso e para identificar que a lista de pedidos foi alterada, senao o bloc nao atualiza a tela.
    final order = orders[index];
    orders[index] = order.copyWith(amount: order.amount + 1);
    emit(state.copyWith(orderList: orders, status: OrderStatus.updateOrder));
  }

  void decrementProduct(int index) {
    final orders = [...state.orderList];
    final order = orders[index];
    final amount = order.amount;
    if (amount == 1) {
      if (state.status != OrderStatus.confirmRemoveProduct) {
        emit(
          OrderConfirmDeleteProductState(
            orderProduct: order,
            index: index,
            status: OrderStatus.confirmRemoveProduct,
            orderList: state.orderList,
            paymentTypes: state.paymentTypes,
            errorMessage: state.errorMessage,
          ),
        );
        return;
      } else {
        orders.removeAt(index);
      }
    } else {
      orders[index] = order.copyWith(amount: order.amount - 1);
    }

    if (orders.isEmpty) {
      emit(state.copyWith(orderList: orders, status: OrderStatus.emptyOrderBag));
    } else {
      emit(state.copyWith(orderList: orders, status: OrderStatus.updateOrder));
    }
  }

  void cancelDeleteProcess() {
    emit(state.copyWith(status: OrderStatus.loaded));
  }

  void clearOrderBag() {
    emit(state.copyWith(status: OrderStatus.emptyOrderBag));
  }

  Future<void> finishOrder({required String address, required String document, required int paymentTypeId}) async {
    if (state.orderList.isEmpty) {
      emit(state.copyWith(status: OrderStatus.emptyOrderBag));
      return;
    }

    if (address.isEmpty) {
      emit(state.copyWith(status: OrderStatus.error, errorMessage: 'Endereço não informado'));
      return;
    }

    if (document.isEmpty) {
      emit(state.copyWith(status: OrderStatus.error, errorMessage: 'CPF/CNPJ não informado'));
      return;
    }

    emit(state.copyWith(status: OrderStatus.loading));

    final orderDto = OrderDto(
      products: state.orderList,
      addresss: address,
      document: document,
      paymentTypeId: paymentTypeId,
    );

    _orderRepository.createOrder(orderDto).then((value) {
      emit(state.copyWith(status: OrderStatus.success));
    }).catchError((e, s) {
      log('LOG: Erro ao finalizar pedido', error: e, stackTrace: s, name: 'OrderController');
      emit(state.copyWith(status: OrderStatus.error, errorMessage: 'Erro ao finalizar pedido'));
    });
  }
}
