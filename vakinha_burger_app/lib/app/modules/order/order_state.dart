import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../dto/order_product_dto.dart';
import '../../models/payment_type_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  loading,
  loaded,
  error,
}

class OrderState extends Equatable {
  final OrderStatus status;
  final List<OrderProductDto> orderList;
  final List<PaymentTypeModel> paymentTypes;
  final String? errorMessage;

  const OrderState({
    required this.status,
    required this.orderList,
    required this.paymentTypes,
    required this.errorMessage,
  });

  factory OrderState.initial() {
    return const OrderState(status: OrderStatus.initial, orderList: [], paymentTypes: [], errorMessage: null);
  }

  @override
  List<Object?> get props => [
        status,
        orderList,
        paymentTypes,
      ];

  OrderState copyWith({
    OrderStatus? status,
    List<OrderProductDto>? orderList,
    List<PaymentTypeModel>? paymentTypes,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orderList: orderList ?? this.orderList,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
