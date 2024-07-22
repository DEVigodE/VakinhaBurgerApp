import 'order_product_dto.dart';

class OrderDto {
  OrderDto({
    required this.products,
    required this.addresss,
    required this.document,
    required this.paymentTypeId,
  });

  List<OrderProductDto> products;
  String addresss;
  String document;
  int paymentTypeId;
}
